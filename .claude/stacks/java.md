# Java Development Guidelines

This file contains Java-specific development guidelines for Claude Code.

## Build Tools

### Maven
```xml
<!-- pom.xml -->
<project>
    <groupId>com.example</groupId>
    <artifactId>my-app</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>
    
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
    
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
            <version>3.1.0</version>
        </dependency>
    </dependencies>
</project>
```

### Gradle
```groovy
// build.gradle
plugins {
    id 'java'
    id 'org.springframework.boot' version '3.1.0'
}

java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    testImplementation 'org.junit.jupiter:junit-jupiter:5.9.0'
}
```

### Common Commands
```bash
# Maven
mvn clean install
mvn test
mvn package
mvn spring-boot:run

# Gradle
gradle build
gradle test
gradle bootRun
gradle clean
```

## Project Structure

### Standard Maven/Gradle Layout
```
project-root/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/example/app/
│   │   │       ├── Application.java
│   │   │       ├── controller/
│   │   │       ├── service/
│   │   │       ├── repository/
│   │   │       └── model/
│   │   └── resources/
│   │       ├── application.properties
│   │       └── static/
│   └── test/
│       ├── java/
│       └── resources/
├── pom.xml or build.gradle
└── README.md
```

## Java Conventions

### Naming Conventions
```java
// Classes: PascalCase
public class UserAccount { }

// Interfaces: PascalCase, often with 'able' suffix
public interface Serializable { }

// Methods: camelCase
public void calculateTotal() { }

// Variables: camelCase
private String userName;

// Constants: UPPER_SNAKE_CASE
public static final int MAX_RETRY_COUNT = 3;

// Packages: lowercase
package com.example.myapp.service;
```

### Modern Java Features (17+)
```java
// Records (Java 14+)
public record User(String name, int age) { }

// Sealed Classes (Java 17)
public sealed class Shape 
    permits Circle, Rectangle, Triangle { }

// Pattern Matching (Java 17)
if (obj instanceof String s && s.length() > 5) {
    System.out.println(s.toUpperCase());
}

// Switch Expressions (Java 14+)
String result = switch (day) {
    case MONDAY, FRIDAY, SUNDAY -> "6";
    case TUESDAY -> "7";
    case THURSDAY, SATURDAY -> "8";
    case WEDNESDAY -> "9";
};

// Text Blocks (Java 15+)
String json = """
    {
        "name": "John",
        "age": 30
    }
    """;
```

## Spring Boot Patterns

### REST Controller
```java
@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;
    
    @GetMapping
    public List<UserDto> getAllUsers() {
        return userService.findAll();
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<UserDto> getUser(@PathVariable Long id) {
        return userService.findById(id)
            .map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
    }
    
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public UserDto createUser(@Valid @RequestBody CreateUserRequest request) {
        return userService.create(request);
    }
    
    @ExceptionHandler(ValidationException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ErrorResponse handleValidation(ValidationException e) {
        return new ErrorResponse(e.getMessage());
    }
}
```

### Service Layer
```java
@Service
@Transactional
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final UserMapper userMapper;
    
    public List<UserDto> findAll() {
        return userRepository.findAll().stream()
            .map(userMapper::toDto)
            .collect(Collectors.toList());
    }
    
    public Optional<UserDto> findById(Long id) {
        return userRepository.findById(id)
            .map(userMapper::toDto);
    }
    
    @Transactional
    public UserDto create(CreateUserRequest request) {
        User user = userMapper.toEntity(request);
        user = userRepository.save(user);
        return userMapper.toDto(user);
    }
}
```

### Repository with JPA
```java
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
    
    @Query("SELECT u FROM User u WHERE u.active = true")
    List<User> findActiveUsers();
    
    @Modifying
    @Query("UPDATE User u SET u.lastLogin = :date WHERE u.id = :id")
    void updateLastLogin(@Param("id") Long id, @Param("date") LocalDateTime date);
    
    Page<User> findByAgeGreaterThan(int age, Pageable pageable);
}
```

## Exception Handling

### Custom Exceptions
```java
public class BusinessException extends RuntimeException {
    private final ErrorCode errorCode;
    
    public BusinessException(ErrorCode errorCode, String message) {
        super(message);
        this.errorCode = errorCode;
    }
}

@ResponseStatus(HttpStatus.NOT_FOUND)
public class ResourceNotFoundException extends BusinessException {
    public ResourceNotFoundException(String resource, Long id) {
        super(ErrorCode.NOT_FOUND, 
              String.format("%s not found with id: %d", resource, id));
    }
}
```

### Global Exception Handler
```java
@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {
    
    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleNotFound(ResourceNotFoundException e) {
        log.error("Resource not found: {}", e.getMessage());
        return ResponseEntity
            .status(HttpStatus.NOT_FOUND)
            .body(new ErrorResponse(e.getErrorCode(), e.getMessage()));
    }
    
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ValidationErrorResponse> handleValidation(
            MethodArgumentNotValidException e) {
        Map<String, String> errors = e.getBindingResult()
            .getFieldErrors()
            .stream()
            .collect(Collectors.toMap(
                FieldError::getField,
                FieldError::getDefaultMessage
            ));
        return ResponseEntity
            .badRequest()
            .body(new ValidationErrorResponse(errors));
    }
}
```

## Testing

### JUnit 5 Tests
```java
@SpringBootTest
@AutoConfigureMockMvc
class UserControllerTest {
    
    @Autowired
    private MockMvc mockMvc;
    
    @MockBean
    private UserService userService;
    
    @Test
    @DisplayName("Should return user when ID exists")
    void getUser_WhenExists_ReturnsUser() throws Exception {
        // Given
        UserDto user = new UserDto(1L, "John", "john@example.com");
        when(userService.findById(1L)).thenReturn(Optional.of(user));
        
        // When & Then
        mockMvc.perform(get("/api/users/1"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.name").value("John"))
            .andExpect(jsonPath("$.email").value("john@example.com"));
    }
    
    @ParameterizedTest
    @ValueSource(strings = {"", " ", "invalid-email"})
    void createUser_WithInvalidEmail_ReturnsBadRequest(String email) 
            throws Exception {
        String request = """
            {
                "name": "John",
                "email": "%s"
            }
            """.formatted(email);
            
        mockMvc.perform(post("/api/users")
                .contentType(MediaType.APPLICATION_JSON)
                .content(request))
            .andExpect(status().isBadRequest());
    }
}
```

### Integration Tests
```java
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureMockMvc
@Sql("/test-data.sql")
class UserIntegrationTest {
    
    @Autowired
    private TestRestTemplate restTemplate;
    
    @Test
    void createAndRetrieveUser() {
        // Create user
        CreateUserRequest request = new CreateUserRequest("John", "john@example.com");
        ResponseEntity<UserDto> createResponse = restTemplate
            .postForEntity("/api/users", request, UserDto.class);
        
        assertThat(createResponse.getStatusCode()).isEqualTo(HttpStatus.CREATED);
        Long userId = createResponse.getBody().getId();
        
        // Retrieve user
        UserDto user = restTemplate
            .getForObject("/api/users/" + userId, UserDto.class);
        
        assertThat(user.getName()).isEqualTo("John");
    }
}
```

## Configuration Management

### Application Properties
```properties
# application.properties
spring.application.name=my-app
server.port=8080

# Database
spring.datasource.url=jdbc:postgresql://localhost:5432/mydb
spring.datasource.username=${DB_USERNAME:myuser}
spring.datasource.password=${DB_PASSWORD}

# JPA
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=false
spring.jpa.properties.hibernate.format_sql=true

# Logging
logging.level.root=INFO
logging.level.com.example=DEBUG
```

### Configuration Classes
```java
@Configuration
@ConfigurationProperties(prefix = "app")
@Validated
public class AppConfiguration {
    
    @NotNull
    private String apiKey;
    
    @Min(1)
    @Max(100)
    private int maxRetries = 3;
    
    private Duration timeout = Duration.ofSeconds(30);
    
    // Getters and setters
}
```

## Security with Spring Security

### Security Configuration
```java
@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {
    
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        return http
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/api/public/**").permitAll()
                .requestMatchers("/api/admin/**").hasRole("ADMIN")
                .anyRequest().authenticated()
            )
            .sessionManagement(session -> session
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
            )
            .addFilterBefore(jwtAuthenticationFilter(), 
                UsernamePasswordAuthenticationFilter.class)
            .build();
    }
    
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
```

## Database Patterns

### Entity Mapping
```java
@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false, unique = true)
    private String email;
    
    @Column(nullable = false)
    private String name;
    
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Order> orders = new ArrayList<>();
    
    @CreatedDate
    private LocalDateTime createdAt;
    
    @LastModifiedDate
    private LocalDateTime updatedAt;
    
    @Version
    private Long version;
}
```

### Transaction Management
```java
@Service
@RequiredArgsConstructor
public class OrderService {
    
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public Order createOrder(CreateOrderRequest request) {
        // Transactional logic
    }
    
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void auditOrder(Long orderId) {
        // Runs in new transaction
    }
    
    @Transactional(readOnly = true)
    public List<Order> findOrders() {
        // Read-only optimization
    }
}
```

## Performance Best Practices

1. **Use connection pooling** (HikariCP by default in Spring Boot)
2. **Enable query caching** for frequently accessed data
3. **Use projection DTOs** instead of entities for read operations
4. **Implement pagination** for large result sets
5. **Use `@Async` for non-blocking operations**
6. **Profile with JProfiler or VisualVM**
7. **Monitor with Micrometer and Prometheus**

## Code Quality Tools

```xml
<!-- Maven plugins -->
<plugin>
    <groupId>com.github.spotbugs</groupId>
    <artifactId>spotbugs-maven-plugin</artifactId>
</plugin>

<plugin>
    <groupId>org.sonarsource.scanner.maven</groupId>
    <artifactId>sonar-maven-plugin</artifactId>
</plugin>

<plugin>
    <groupId>org.jacoco</groupId>
    <artifactId>jacoco-maven-plugin</artifactId>
</plugin>
```

## Integration with Claude Code

When working with Java projects:
- Use the `patterns` agent for design pattern guidance
- Use the `researcher` agent for Spring Boot best practices
- Use the `principles` agent for SOLID in Java context
- Use the `complete` agent for exception handling
- Use the `docsync` agent for Javadoc updates