# C# Development Reference

Essential C#/.NET development guidelines for Claude Code projects.

## Project Setup (.NET CLI)
```bash
# Create projects
dotnet new webapi -n MyApi
dotnet new classlib -n MyLibrary
dotnet new xunit -n MyTests

# Solution management
dotnet new sln -n MySolution
dotnet sln add MyApi/MyApi.csproj

# Build and run
dotnet build
dotnet run
dotnet test
dotnet publish -c Release
```

## Project File (.csproj)
```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Microsoft.AspNetCore.OpenApi" Version="8.0.0" />
    <PackageReference Include="Microsoft.EntityFrameworkCore.SqlServer" Version="8.0.0" />
    <PackageReference Include="FluentValidation.AspNetCore" Version="11.3.0" />
  </ItemGroup>
</Project>
```

## Modern C# Features (C# 12)
```csharp
// Primary constructors
public class UserService(IUserRepository repository, ILogger<UserService> logger) {
    public async Task<User?> GetUserAsync(int id) {
        logger.LogInformation("Getting user {UserId}", id);
        return await repository.GetByIdAsync(id);
    }
}

// Record types
public record CreateUserRequest(string Email, string Name);
public record UserResponse(int Id, string Email, string Name, DateTime CreatedAt);

// Pattern matching
public string GetUserStatus(UserResponse user) => user switch {
    { Id: 0 } => "New user",
    { CreatedAt: var date } when date > DateTime.Now.AddDays(-7) => "Recently joined",
    _ => "Regular user"
};
```

## ASP.NET Core Web API
```csharp
[ApiController]
[Route("api/[controller]")]
public class UsersController : ControllerBase {
    private readonly IUserService _userService;
    
    public UsersController(IUserService userService) => _userService = userService;
    
    [HttpGet]
    public async Task<IActionResult> GetAll([FromQuery] int page = 1) {
        var users = await _userService.GetPaginatedAsync(page, 20);
        return Ok(users);
    }
    
    [HttpPost]
    [ProducesResponseType(typeof(UserDto), StatusCodes.Status201Created)]
    public async Task<IActionResult> Create([FromBody] CreateUserRequest request) {
        var user = await _userService.CreateAsync(request);
        return CreatedAtAction(nameof(GetById), new { id = user.Id }, user);
    }
}
```

## Entity Framework Core
```csharp
public class ApplicationDbContext : DbContext {
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }
    
    public DbSet<User> Users => Set<User>();
    
    protected override void OnModelCreating(ModelBuilder modelBuilder) {
        modelBuilder.Entity<User>(entity => {
            entity.HasKey(u => u.Id);
            entity.Property(u => u.Email).IsRequired().HasMaxLength(256);
            entity.HasIndex(u => u.Email).IsUnique();
        });
    }
}

public class User {
    public int Id { get; set; }
    public required string Email { get; set; }
    public required string Name { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
}
```

## Dependency Injection
```csharp
var builder = WebApplication.CreateBuilder(args);

// Services
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<IUserRepository, UserRepository>();

// Configuration
builder.Services.Configure<JwtSettings>(builder.Configuration.GetSection("Jwt"));

var app = builder.Build();
```

## Error Handling
```csharp
public class GlobalExceptionMiddleware {
    private readonly RequestDelegate _next;
    
    public async Task InvokeAsync(HttpContext context) {
        try {
            await _next(context);
        } catch (Exception ex) {
            await HandleExceptionAsync(context, ex);
        }
    }
    
    private static async Task HandleExceptionAsync(HttpContext context, Exception exception) {
        var response = exception switch {
            NotFoundException => new { StatusCode = 404, Message = exception.Message },
            ValidationException => new { StatusCode = 400, Message = "Validation failed" },
            _ => new { StatusCode = 500, Message = "Internal server error" }
        };
        
        context.Response.StatusCode = response.StatusCode;
        await context.Response.WriteAsync(JsonSerializer.Serialize(response));
    }
}
```

## Testing (xUnit)
```csharp
public class UserServiceTests {
    private readonly Mock<IUserRepository> _mockRepository = new();
    private readonly UserService _service;
    
    public UserServiceTests() {
        _service = new UserService(_mockRepository.Object);
    }
    
    [Fact]
    public async Task GetByIdAsync_WhenUserExists_ReturnsUser() {
        // Arrange
        var expectedUser = new User { Id = 1, Email = "test@example.com" };
        _mockRepository.Setup(r => r.GetByIdAsync(1)).ReturnsAsync(expectedUser);
        
        // Act
        var result = await _service.GetByIdAsync(1);
        
        // Assert
        Assert.NotNull(result);
        Assert.Equal(expectedUser.Email, result.Email);
    }
    
    [Theory]
    [InlineData("")]
    [InlineData(" ")]
    [InlineData(null)]
    public async Task CreateAsync_WithInvalidEmail_ThrowsException(string? email) {
        var request = new CreateUserRequest { Email = email!, Name = "Test" };
        await Assert.ThrowsAsync<ValidationException>(() => _service.CreateAsync(request));
    }
}
```

## Async/Await Best Practices
```csharp
// ConfigureAwait(false) in library code
public async Task<string> GetDataAsync() {
    var result = await FetchFromApiAsync().ConfigureAwait(false);
    return ProcessData(result);
}

// Cancellation token support
public async Task<T> GetWithTimeoutAsync<T>(Func<CancellationToken, Task<T>> operation, TimeSpan timeout) {
    using var cts = new CancellationTokenSource(timeout);
    return await operation(cts.Token);
}
```

## Best Practices
- Use nullable reference types (`<Nullable>enable</Nullable>`)
- Prefer async/await over blocking calls
- Use dependency injection for loose coupling
- Implement proper error handling middleware
- Use Entity Framework migrations for database changes
- Write comprehensive unit and integration tests
- Follow SOLID principles in design
- Use configuration patterns for settings