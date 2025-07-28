# C# Development Guidelines

This file contains C#/.NET specific development guidelines for Claude Code.

## Project Management

### .NET CLI
```bash
# Create new projects
dotnet new webapi -n MyApi
dotnet new classlib -n MyLibrary
dotnet new xunit -n MyTests
dotnet new console -n MyApp

# Solution management
dotnet new sln -n MySolution
dotnet sln add MyApi/MyApi.csproj
dotnet sln add MyLibrary/MyLibrary.csproj

# Package management
dotnet add package Microsoft.EntityFrameworkCore
dotnet add package Serilog.AspNetCore
dotnet restore

# Build and run
dotnet build
dotnet run
dotnet test
dotnet publish -c Release
```

### Project File (.csproj)
```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
    <RootNamespace>MyApp</RootNamespace>
    <AssemblyName>MyApp.Api</AssemblyName>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Microsoft.AspNetCore.OpenApi" Version="8.0.0" />
    <PackageReference Include="Swashbuckle.AspNetCore" Version="6.5.0" />
    <PackageReference Include="Microsoft.EntityFrameworkCore.SqlServer" Version="8.0.0" />
    <PackageReference Include="FluentValidation.AspNetCore" Version="11.3.0" />
    <PackageReference Include="Serilog.AspNetCore" Version="8.0.0" />
  </ItemGroup>
</Project>
```

## Project Structure

### Clean Architecture Layout
```
solution-root/
├── src/
│   ├── MyApp.Domain/           # Domain entities and interfaces
│   ├── MyApp.Application/      # Business logic and use cases
│   ├── MyApp.Infrastructure/   # Data access and external services
│   └── MyApp.Api/              # Web API presentation layer
├── tests/
│   ├── MyApp.UnitTests/
│   ├── MyApp.IntegrationTests/
│   └── MyApp.FunctionalTests/
├── MyApp.sln
└── README.md
```

## Modern C# Features (C# 12)

### Primary Constructors
```csharp
public class UserService(IUserRepository repository, ILogger<UserService> logger)
{
    public async Task<User?> GetUserAsync(int id)
    {
        logger.LogInformation("Getting user {UserId}", id);
        return await repository.GetByIdAsync(id);
    }
}
```

### Record Types
```csharp
// Immutable DTOs
public record CreateUserRequest(string Email, string Name);
public record UserResponse(int Id, string Email, string Name, DateTime CreatedAt);

// With positional pattern matching
public string GetUserStatus(UserResponse user) => user switch
{
    { Id: 0 } => "New user",
    { CreatedAt: var date } when date > DateTime.Now.AddDays(-7) => "Recently joined",
    _ => "Regular user"
};
```

### Pattern Matching
```csharp
public static string DescribeValue(object value) => value switch
{
    null => "null",
    string s => $"String: {s}",
    int i when i > 0 => $"Positive int: {i}",
    int i => $"Non-positive int: {i}",
    List<int> { Count: 0 } => "Empty list",
    List<int> { Count: var count } list => $"List with {count} items",
    _ => value.ToString() ?? "Unknown"
};
```

### Nullable Reference Types
```csharp
#nullable enable

public class UserManager
{
    private readonly Dictionary<int, User> _users = new();
    
    public User? FindUser(int id) => _users.GetValueOrDefault(id);
    
    public void ProcessUser(User? user)
    {
        if (user is null) return;
        
        // user is non-null here
        Console.WriteLine(user.Name);
    }
    
    public string GetUserEmail(int id)
    {
        var user = FindUser(id);
        return user?.Email ?? "no-email@example.com";
    }
}
```

## ASP.NET Core Web API

### Minimal APIs
```csharp
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddSingleton<IUserService, UserService>();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.MapGet("/users", async (IUserService service) => 
    await service.GetAllAsync());

app.MapGet("/users/{id:int}", async (int id, IUserService service) => 
    await service.GetByIdAsync(id) is User user
        ? Results.Ok(user)
        : Results.NotFound());

app.MapPost("/users", async (CreateUserRequest request, IUserService service) =>
{
    var user = await service.CreateAsync(request);
    return Results.Created($"/users/{user.Id}", user);
});

app.Run();
```

### Controller-Based APIs
```csharp
[ApiController]
[Route("api/[controller]")]
public class UsersController : ControllerBase
{
    private readonly IUserService _userService;
    private readonly ILogger<UsersController> _logger;
    
    public UsersController(IUserService userService, ILogger<UsersController> logger)
    {
        _userService = userService;
        _logger = logger;
    }
    
    [HttpGet]
    [ProducesResponseType(typeof(IEnumerable<UserDto>), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetAll([FromQuery] int page = 1, [FromQuery] int pageSize = 20)
    {
        var users = await _userService.GetPaginatedAsync(page, pageSize);
        return Ok(users);
    }
    
    [HttpGet("{id:int}")]
    [ProducesResponseType(typeof(UserDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetById(int id)
    {
        var user = await _userService.GetByIdAsync(id);
        return user is null ? NotFound() : Ok(user);
    }
    
    [HttpPost]
    [ProducesResponseType(typeof(UserDto), StatusCodes.Status201Created)]
    [ProducesResponseType(typeof(ValidationProblemDetails), StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> Create([FromBody] CreateUserRequest request)
    {
        var user = await _userService.CreateAsync(request);
        return CreatedAtAction(nameof(GetById), new { id = user.Id }, user);
    }
}
```

## Entity Framework Core

### DbContext Configuration
```csharp
public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options) { }
    
    public DbSet<User> Users => Set<User>();
    public DbSet<Order> Orders => Set<Order>();
    
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());
        
        // Global query filters
        modelBuilder.Entity<User>().HasQueryFilter(u => !u.IsDeleted);
    }
    
    public override async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
    {
        foreach (var entry in ChangeTracker.Entries<IAuditableEntity>())
        {
            switch (entry.State)
            {
                case EntityState.Added:
                    entry.Entity.CreatedAt = DateTime.UtcNow;
                    break;
                case EntityState.Modified:
                    entry.Entity.UpdatedAt = DateTime.UtcNow;
                    break;
            }
        }
        
        return await base.SaveChangesAsync(cancellationToken);
    }
}
```

### Entity Configuration
```csharp
public class User : IAuditableEntity
{
    public int Id { get; set; }
    public required string Email { get; set; }
    public required string Name { get; set; }
    public string PasswordHash { get; set; } = string.Empty;
    public bool IsDeleted { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
    
    public ICollection<Order> Orders { get; set; } = new List<Order>();
}

public class UserConfiguration : IEntityTypeConfiguration<User>
{
    public void Configure(EntityTypeBuilder<User> builder)
    {
        builder.HasKey(u => u.Id);
        
        builder.Property(u => u.Email)
            .IsRequired()
            .HasMaxLength(256);
            
        builder.HasIndex(u => u.Email)
            .IsUnique();
            
        builder.Property(u => u.Name)
            .IsRequired()
            .HasMaxLength(100);
            
        builder.HasMany(u => u.Orders)
            .WithOne(o => o.User)
            .HasForeignKey(o => o.UserId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
```

### Repository Pattern
```csharp
public interface IRepository<T> where T : class
{
    Task<T?> GetByIdAsync(int id);
    Task<IEnumerable<T>> GetAllAsync();
    Task<T> AddAsync(T entity);
    Task UpdateAsync(T entity);
    Task DeleteAsync(T entity);
    Task<bool> ExistsAsync(int id);
}

public class Repository<T> : IRepository<T> where T : class
{
    protected readonly ApplicationDbContext _context;
    protected readonly DbSet<T> _dbSet;
    
    public Repository(ApplicationDbContext context)
    {
        _context = context;
        _dbSet = context.Set<T>();
    }
    
    public virtual async Task<T?> GetByIdAsync(int id)
    {
        return await _dbSet.FindAsync(id);
    }
    
    public virtual async Task<IEnumerable<T>> GetAllAsync()
    {
        return await _dbSet.ToListAsync();
    }
    
    public virtual async Task<T> AddAsync(T entity)
    {
        await _dbSet.AddAsync(entity);
        await _context.SaveChangesAsync();
        return entity;
    }
    
    public virtual async Task UpdateAsync(T entity)
    {
        _dbSet.Update(entity);
        await _context.SaveChangesAsync();
    }
    
    public virtual async Task DeleteAsync(T entity)
    {
        _dbSet.Remove(entity);
        await _context.SaveChangesAsync();
    }
    
    public virtual async Task<bool> ExistsAsync(int id)
    {
        return await _dbSet.FindAsync(id) is not null;
    }
}
```

## Dependency Injection

### Service Registration
```csharp
public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddApplicationServices(this IServiceCollection services)
    {
        // Register services with appropriate lifetimes
        services.AddScoped<IUserService, UserService>();
        services.AddScoped<IEmailService, EmailService>();
        services.AddScoped(typeof(IRepository<>), typeof(Repository<>));
        
        // Register with factory
        services.AddSingleton<IConnectionFactory>(sp =>
        {
            var connectionString = sp.GetRequiredService<IConfiguration>()
                .GetConnectionString("DefaultConnection");
            return new SqlConnectionFactory(connectionString!);
        });
        
        // Register with options pattern
        services.Configure<JwtSettings>(configuration.GetSection("Jwt"));
        services.AddSingleton<IJwtService, JwtService>();
        
        return services;
    }
}
```

## Error Handling

### Global Exception Handling
```csharp
public class GlobalExceptionMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<GlobalExceptionMiddleware> _logger;
    
    public GlobalExceptionMiddleware(RequestDelegate next, ILogger<GlobalExceptionMiddleware> logger)
    {
        _next = next;
        _logger = logger;
    }
    
    public async Task InvokeAsync(HttpContext context)
    {
        try
        {
            await _next(context);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "An unhandled exception occurred");
            await HandleExceptionAsync(context, ex);
        }
    }
    
    private static async Task HandleExceptionAsync(HttpContext context, Exception exception)
    {
        context.Response.ContentType = "application/json";
        
        var response = exception switch
        {
            NotFoundException => new ErrorResponse
            {
                StatusCode = StatusCodes.Status404NotFound,
                Message = exception.Message
            },
            ValidationException validationEx => new ErrorResponse
            {
                StatusCode = StatusCodes.Status400BadRequest,
                Message = "Validation failed",
                Errors = validationEx.Errors
            },
            UnauthorizedException => new ErrorResponse
            {
                StatusCode = StatusCodes.Status401Unauthorized,
                Message = "Unauthorized"
            },
            _ => new ErrorResponse
            {
                StatusCode = StatusCodes.Status500InternalServerError,
                Message = "An error occurred while processing your request"
            }
        };
        
        context.Response.StatusCode = response.StatusCode;
        await context.Response.WriteAsync(JsonSerializer.Serialize(response));
    }
}
```

### Custom Exceptions
```csharp
public abstract class DomainException : Exception
{
    protected DomainException(string message) : base(message) { }
}

public class NotFoundException : DomainException
{
    public NotFoundException(string entityName, object key) 
        : base($"{entityName} with key {key} was not found") { }
}

public class ValidationException : DomainException
{
    public IReadOnlyDictionary<string, string[]> Errors { get; }
    
    public ValidationException(IDictionary<string, string[]> errors)
        : base("One or more validation errors occurred")
    {
        Errors = new ReadOnlyDictionary<string, string[]>(errors);
    }
}
```

## Testing

### xUnit Unit Tests
```csharp
public class UserServiceTests
{
    private readonly Mock<IUserRepository> _mockRepository;
    private readonly Mock<ILogger<UserService>> _mockLogger;
    private readonly UserService _service;
    
    public UserServiceTests()
    {
        _mockRepository = new Mock<IUserRepository>();
        _mockLogger = new Mock<ILogger<UserService>>();
        _service = new UserService(_mockRepository.Object, _mockLogger.Object);
    }
    
    [Fact]
    public async Task GetByIdAsync_WhenUserExists_ReturnsUser()
    {
        // Arrange
        var expectedUser = new User { Id = 1, Email = "test@example.com", Name = "Test" };
        _mockRepository.Setup(r => r.GetByIdAsync(1))
            .ReturnsAsync(expectedUser);
        
        // Act
        var result = await _service.GetByIdAsync(1);
        
        // Assert
        Assert.NotNull(result);
        Assert.Equal(expectedUser.Email, result.Email);
        _mockRepository.Verify(r => r.GetByIdAsync(1), Times.Once);
    }
    
    [Theory]
    [InlineData("")]
    [InlineData(" ")]
    [InlineData(null)]
    public async Task CreateAsync_WithInvalidEmail_ThrowsValidationException(string? email)
    {
        // Arrange
        var request = new CreateUserRequest { Email = email!, Name = "Test" };
        
        // Act & Assert
        await Assert.ThrowsAsync<ValidationException>(() => _service.CreateAsync(request));
    }
}
```

### Integration Tests
```csharp
public class UserApiIntegrationTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly WebApplicationFactory<Program> _factory;
    private readonly HttpClient _client;
    
    public UserApiIntegrationTests(WebApplicationFactory<Program> factory)
    {
        _factory = factory;
        _client = _factory.WithWebHostBuilder(builder =>
        {
            builder.ConfigureServices(services =>
            {
                // Replace real database with in-memory
                services.RemoveAll<DbContextOptions<ApplicationDbContext>>();
                services.AddDbContext<ApplicationDbContext>(options =>
                {
                    options.UseInMemoryDatabase("TestDb");
                });
            });
        }).CreateClient();
    }
    
    [Fact]
    public async Task GetUsers_ReturnsSuccessStatusCode()
    {
        // Act
        var response = await _client.GetAsync("/api/users");
        
        // Assert
        response.EnsureSuccessStatusCode();
        var content = await response.Content.ReadAsStringAsync();
        Assert.NotEmpty(content);
    }
    
    [Fact]
    public async Task CreateUser_WithValidData_ReturnsCreated()
    {
        // Arrange
        var request = new CreateUserRequest
        {
            Email = "newuser@example.com",
            Name = "New User"
        };
        
        var content = new StringContent(
            JsonSerializer.Serialize(request),
            Encoding.UTF8,
            "application/json");
        
        // Act
        var response = await _client.PostAsync("/api/users", content);
        
        // Assert
        Assert.Equal(HttpStatusCode.Created, response.StatusCode);
        Assert.Contains("newuser@example.com", await response.Content.ReadAsStringAsync());
    }
}
```

## Async/Await Best Practices

```csharp
public class AsyncService
{
    // ConfigureAwait(false) in library code
    public async Task<string> GetDataAsync()
    {
        var result = await FetchFromApiAsync().ConfigureAwait(false);
        return ProcessData(result);
    }
    
    // Async all the way
    public async Task ProcessMultipleAsync(IEnumerable<int> ids)
    {
        var tasks = ids.Select(ProcessSingleAsync);
        await Task.WhenAll(tasks);
    }
    
    // Cancellation token support
    public async Task<T> GetWithTimeoutAsync<T>(
        Func<CancellationToken, Task<T>> operation,
        TimeSpan timeout)
    {
        using var cts = new CancellationTokenSource(timeout);
        try
        {
            return await operation(cts.Token);
        }
        catch (OperationCanceledException)
        {
            throw new TimeoutException($"Operation timed out after {timeout}");
        }
    }
    
    // Avoid async void except for event handlers
    private async void Button_Click(object sender, EventArgs e)
    {
        try
        {
            await ProcessAsync();
        }
        catch (Exception ex)
        {
            // Handle exception
        }
    }
}
```

## Configuration

### Options Pattern
```csharp
public class JwtSettings
{
    public required string Secret { get; set; }
    public required string Issuer { get; set; }
    public required string Audience { get; set; }
    public int ExpirationMinutes { get; set; } = 60;
}

// appsettings.json
{
  "Jwt": {
    "Secret": "your-secret-key-here",
    "Issuer": "MyApp",
    "Audience": "MyAppUsers",
    "ExpirationMinutes": 120
  }
}

// Usage
public class JwtService
{
    private readonly JwtSettings _settings;
    
    public JwtService(IOptions<JwtSettings> options)
    {
        _settings = options.Value;
    }
}
```

## Performance Best Practices

1. **Use async/await properly** - avoid blocking calls
2. **Implement caching** - use IMemoryCache or distributed cache
3. **Use pagination** - don't load entire datasets
4. **Optimize LINQ queries** - understand query execution
5. **Pool expensive objects** - HttpClient, DbContext
6. **Use ValueTask** for hot paths
7. **Leverage Span<T>** for memory efficiency
8. **Profile with dotTrace or PerfView**
9. **Monitor with Application Insights**
10. **Use BenchmarkDotNet** for micro-benchmarks

## Integration with Claude Code

When working with C# projects:
- Use the `patterns` agent for C# idioms and patterns
- Use the `researcher` agent for .NET best practices
- Use the `principles` agent for SOLID in C# context
- Use the `complete` agent for null checks and error handling
- Use the `docsync` agent for XML documentation comments