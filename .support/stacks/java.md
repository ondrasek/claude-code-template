# Java Development Reference

Essential Java/Spring Boot development guidelines for Claude Code projects.

## Build Tools
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

## Maven Configuration
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
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
            <version>3.1.0</version>
        </dependency>
    </dependencies>
</project>
```

## Modern Java Features (17+)
```java
// Records
public record User(String name, int age) { }

// Pattern Matching
if (obj instanceof String s && s.length() > 5) {
    System.out.println(s.toUpperCase());
}

// Switch Expressions
String result = switch (day) {
    case MONDAY, FRIDAY, SUNDAY -> "6";
    case TUESDAY -> "7";
    case THURSDAY, SATURDAY -> "8";
    case WEDNESDAY -> "9";
};

// Text Blocks
String json = """
    {
        "name": "John",
        "age": 30
    }
    """;
```

## Spring Boot REST API
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

## Service Layer
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

## JPA Repository
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

## JPA Entity
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

## Exception Handling
```java
@ResponseStatus(HttpStatus.NOT_FOUND)
public class ResourceNotFoundException extends RuntimeException {
    public ResourceNotFoundException(String resource, Long id) {
        super(String.format("%s not found with id: %d", resource, id));
    }
}

@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {
    
    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleNotFound(ResourceNotFoundException e) {
        log.error("Resource not found: {}", e.getMessage());
        return ResponseEntity
            .status(HttpStatus.NOT_FOUND)
            .body(new ErrorResponse(e.getMessage()));
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

## Configuration
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

## Security
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

## Best Practices
- Use connection pooling (HikariCP by default)
- Enable query caching for frequently accessed data
- Use projection DTOs for read operations
- Implement pagination for large result sets
- Use `@Async` for non-blocking operations
- Profile with JProfiler or VisualVM
- Monitor with Micrometer and Prometheus
- Follow SOLID principles
- Write comprehensive tests
- Use proper exception handling