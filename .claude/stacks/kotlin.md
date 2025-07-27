# Kotlin Backend Development Guidelines

This file contains Kotlin-specific backend development guidelines for Claude Code.

## Build Tools

### Gradle Kotlin DSL
```kotlin
// build.gradle.kts
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    kotlin("jvm") version "1.9.20"
    kotlin("plugin.spring") version "1.9.20"
    id("org.springframework.boot") version "3.2.0"
    id("io.spring.dependency-management") version "1.1.4"
}

group = "com.example"
version = "1.0.0"
java.sourceCompatibility = JavaVersion.VERSION_17

repositories {
    mavenCentral()
}

dependencies {
    // Spring Boot
    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation("org.springframework.boot:spring-boot-starter-data-jpa")
    implementation("org.springframework.boot:spring-boot-starter-validation")
    
    // Kotlin
    implementation("org.jetbrains.kotlin:kotlin-reflect")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-reactor")
    
    // Jackson Kotlin
    implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
    
    // Database
    runtimeOnly("org.postgresql:postgresql")
    
    // Testing
    testImplementation("org.springframework.boot:spring-boot-starter-test")
    testImplementation("io.mockk:mockk:1.13.8")
    testImplementation("io.kotest:kotest-runner-junit5:5.8.0")
}

tasks.withType<KotlinCompile> {
    kotlinOptions {
        freeCompilerArgs += "-Xjsr305=strict"
        jvmTarget = "17"
    }
}

tasks.withType<Test> {
    useJUnitPlatform()
}
```

## Project Structure

### Kotlin Backend Layout
```
project-root/
├── src/
│   ├── main/
│   │   ├── kotlin/
│   │   │   └── com/example/app/
│   │   │       ├── Application.kt
│   │   │       ├── controller/
│   │   │       ├── service/
│   │   │       ├── repository/
│   │   │       ├── model/
│   │   │       ├── dto/
│   │   │       └── config/
│   │   └── resources/
│   │       ├── application.yml
│   │       └── db/migration/
│   └── test/
│       └── kotlin/
├── build.gradle.kts
└── settings.gradle.kts
```

## Kotlin Language Features

### Data Classes and DTOs
```kotlin
// Domain model
data class User(
    val id: Long = 0,
    val email: String,
    val name: String,
    val active: Boolean = true,
    val createdAt: Instant = Instant.now()
)

// DTOs with validation
data class CreateUserRequest(
    @field:NotBlank
    @field:Email
    val email: String,
    
    @field:NotBlank
    @field:Size(min = 2, max = 100)
    val name: String
)

data class UserResponse(
    val id: Long,
    val email: String,
    val name: String
) {
    companion object {
        fun from(user: User) = UserResponse(
            id = user.id,
            email = user.email,
            name = user.name
        )
    }
}
```

### Sealed Classes for Result Types
```kotlin
sealed class Result<out T> {
    data class Success<T>(val data: T) : Result<T>()
    data class Error(val message: String, val code: String? = null) : Result<Nothing>()
    
    inline fun <R> map(transform: (T) -> R): Result<R> = when (this) {
        is Success -> Success(transform(data))
        is Error -> this
    }
    
    inline fun onSuccess(action: (T) -> Unit): Result<T> {
        if (this is Success) action(data)
        return this
    }
    
    inline fun onError(action: (String) -> Unit): Result<T> {
        if (this is Error) action(message)
        return this
    }
}
```

## Spring Boot with Kotlin

### REST Controller
```kotlin
@RestController
@RequestMapping("/api/v1/users")
class UserController(
    private val userService: UserService
) {
    @GetMapping
    suspend fun getAllUsers(
        @PageableDefault(size = 20) pageable: Pageable
    ): Page<UserResponse> {
        return userService.findAll(pageable)
            .map { UserResponse.from(it) }
    }
    
    @GetMapping("/{id}")
    suspend fun getUser(@PathVariable id: Long): UserResponse {
        return userService.findById(id)
            ?.let { UserResponse.from(it) }
            ?: throw ResourceNotFoundException("User not found with id: $id")
    }
    
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    suspend fun createUser(
        @Valid @RequestBody request: CreateUserRequest
    ): UserResponse {
        val user = userService.create(request)
        return UserResponse.from(user)
    }
    
    @PutMapping("/{id}")
    suspend fun updateUser(
        @PathVariable id: Long,
        @Valid @RequestBody request: UpdateUserRequest
    ): UserResponse {
        val user = userService.update(id, request)
        return UserResponse.from(user)
    }
    
    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    suspend fun deleteUser(@PathVariable id: Long) {
        userService.delete(id)
    }
}
```

### Service Layer with Coroutines
```kotlin
@Service
class UserService(
    private val userRepository: UserRepository,
    private val emailService: EmailService,
    private val cacheManager: CacheManager
) {
    private val logger = LoggerFactory.getLogger(javaClass)
    
    @Transactional(readOnly = true)
    suspend fun findAll(pageable: Pageable): Page<User> = withContext(Dispatchers.IO) {
        userRepository.findAll(pageable)
    }
    
    @Cacheable("users")
    suspend fun findById(id: Long): User? = withContext(Dispatchers.IO) {
        userRepository.findById(id).orElse(null)
    }
    
    @Transactional
    suspend fun create(request: CreateUserRequest): User = withContext(Dispatchers.IO) {
        // Check if email exists
        userRepository.findByEmail(request.email)?.let {
            throw ConflictException("Email already exists")
        }
        
        val user = User(
            email = request.email,
            name = request.name
        )
        
        val savedUser = userRepository.save(user)
        
        // Send welcome email asynchronously
        launch {
            try {
                emailService.sendWelcomeEmail(savedUser)
            } catch (e: Exception) {
                logger.error("Failed to send welcome email", e)
            }
        }
        
        savedUser
    }
    
    @CacheEvict("users", key = "#id")
    @Transactional
    suspend fun delete(id: Long) = withContext(Dispatchers.IO) {
        userRepository.findById(id).orElseThrow {
            ResourceNotFoundException("User not found")
        }
        userRepository.deleteById(id)
    }
}
```

### Repository with Spring Data JPA
```kotlin
@Repository
interface UserRepository : JpaRepository<User, Long> {
    fun findByEmail(email: String): User?
    
    @Query("SELECT u FROM User u WHERE u.active = true")
    fun findActiveUsers(pageable: Pageable): Page<User>
    
    @Modifying
    @Query("UPDATE User u SET u.lastLogin = :timestamp WHERE u.id = :id")
    fun updateLastLogin(id: Long, timestamp: Instant)
    
    suspend fun findByNameContaining(name: String): List<User>
}

// Custom repository implementation
@Repository
class CustomUserRepository(
    private val entityManager: EntityManager
) {
    suspend fun searchUsers(criteria: SearchCriteria): List<User> = withContext(Dispatchers.IO) {
        val cb = entityManager.criteriaBuilder
        val query = cb.createQuery(User::class.java)
        val root = query.from(User::class.java)
        
        val predicates = mutableListOf<Predicate>()
        
        criteria.name?.let {
            predicates.add(cb.like(root.get("name"), "%$it%"))
        }
        
        criteria.email?.let {
            predicates.add(cb.equal(root.get("email"), it))
        }
        
        query.where(*predicates.toTypedArray())
        entityManager.createQuery(query).resultList
    }
}
```

## Error Handling

### Global Exception Handler
```kotlin
@RestControllerAdvice
class GlobalExceptionHandler {
    private val logger = LoggerFactory.getLogger(javaClass)
    
    @ExceptionHandler(ResourceNotFoundException::class)
    fun handleNotFound(ex: ResourceNotFoundException): ResponseEntity<ErrorResponse> {
        val error = ErrorResponse(
            status = HttpStatus.NOT_FOUND.value(),
            error = "Not Found",
            message = ex.message ?: "Resource not found",
            timestamp = Instant.now()
        )
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(error)
    }
    
    @ExceptionHandler(ValidationException::class)
    fun handleValidation(ex: ValidationException): ResponseEntity<ValidationErrorResponse> {
        val errors = ex.errors.associate { it.field to it.message }
        val response = ValidationErrorResponse(
            status = HttpStatus.BAD_REQUEST.value(),
            error = "Validation Failed",
            errors = errors,
            timestamp = Instant.now()
        )
        return ResponseEntity.badRequest().body(response)
    }
    
    @ExceptionHandler(Exception::class)
    fun handleGeneral(ex: Exception): ResponseEntity<ErrorResponse> {
        logger.error("Unexpected error", ex)
        val error = ErrorResponse(
            status = HttpStatus.INTERNAL_SERVER_ERROR.value(),
            error = "Internal Server Error",
            message = "An unexpected error occurred",
            timestamp = Instant.now()
        )
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(error)
    }
}

// Custom exceptions
class ResourceNotFoundException(message: String) : RuntimeException(message)
class ConflictException(message: String) : RuntimeException(message)
class ValidationException(val errors: List<FieldError>) : RuntimeException()
```

## Testing

### Unit Tests with MockK
```kotlin
@ExtendWith(MockKExtension::class)
class UserServiceTest {
    @MockK
    private lateinit var userRepository: UserRepository
    
    @MockK
    private lateinit var emailService: EmailService
    
    @InjectMockKs
    private lateinit var userService: UserService
    
    @Test
    fun `should create user successfully`() = runTest {
        // Given
        val request = CreateUserRequest(
            email = "test@example.com",
            name = "Test User"
        )
        
        val user = User(
            id = 1L,
            email = request.email,
            name = request.name
        )
        
        every { userRepository.findByEmail(request.email) } returns null
        every { userRepository.save(any()) } returns user
        coEvery { emailService.sendWelcomeEmail(any()) } just Runs
        
        // When
        val result = userService.create(request)
        
        // Then
        assertThat(result).isEqualTo(user)
        verify { userRepository.save(any()) }
        coVerify { emailService.sendWelcomeEmail(user) }
    }
    
    @Test
    fun `should throw exception when email exists`() = runTest {
        // Given
        val request = CreateUserRequest(
            email = "existing@example.com",
            name = "Test User"
        )
        
        every { userRepository.findByEmail(request.email) } returns User(
            email = request.email,
            name = "Existing User"
        )
        
        // When/Then
        assertThrows<ConflictException> {
            userService.create(request)
        }
        
        verify(exactly = 0) { userRepository.save(any()) }
    }
}
```

### Integration Tests
```kotlin
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureMockMvc
@ActiveProfiles("test")
class UserControllerIntegrationTest @Autowired constructor(
    private val mockMvc: MockMvc,
    private val objectMapper: ObjectMapper,
    private val userRepository: UserRepository
) {
    
    @BeforeEach
    fun setup() {
        userRepository.deleteAll()
    }
    
    @Test
    fun `should create and retrieve user`() {
        // Create user
        val createRequest = CreateUserRequest(
            email = "test@example.com",
            name = "Test User"
        )
        
        val createResult = mockMvc.post("/api/v1/users") {
            contentType = MediaType.APPLICATION_JSON
            content = objectMapper.writeValueAsString(createRequest)
        }.andExpect {
            status { isCreated() }
            jsonPath("$.email") { value(createRequest.email) }
            jsonPath("$.name") { value(createRequest.name) }
        }.andReturn()
        
        val userId = objectMapper.readTree(createResult.response.contentAsString)
            .get("id").asLong()
        
        // Retrieve user
        mockMvc.get("/api/v1/users/$userId") {
            accept = MediaType.APPLICATION_JSON
        }.andExpect {
            status { isOk() }
            jsonPath("$.id") { value(userId) }
            jsonPath("$.email") { value(createRequest.email) }
        }
    }
}
```

## Coroutines and Async Programming

### Parallel Processing
```kotlin
@Service
class DataProcessingService {
    suspend fun processMultipleDataSources(): ProcessingResult = coroutineScope {
        val deferred1 = async { fetchFromSource1() }
        val deferred2 = async { fetchFromSource2() }
        val deferred3 = async { fetchFromSource3() }
        
        val results = awaitAll(deferred1, deferred2, deferred3)
        
        ProcessingResult(
            source1Data = results[0],
            source2Data = results[1],
            source3Data = results[2]
        )
    }
    
    suspend fun processWithTimeout(): Result<Data> = withTimeoutOrNull(5000) {
        fetchSlowData()
    }?.let { Result.Success(it) } ?: Result.Error("Operation timed out")
    
    fun processStream(): Flow<ProcessedItem> = flow {
        getDataStream().collect { rawData ->
            val processed = processItem(rawData)
            emit(processed)
        }
    }.flowOn(Dispatchers.Default)
        .catch { e -> logger.error("Stream processing error", e) }
}
```

### WebFlux Integration
```kotlin
@RestController
@RequestMapping("/api/v1/stream")
class StreamController(
    private val dataService: DataService
) {
    @GetMapping(produces = [MediaType.TEXT_EVENT_STREAM_VALUE])
    fun streamData(): Flow<ServerSentEvent<DataEvent>> = 
        dataService.getDataStream()
            .map { data ->
                ServerSentEvent.builder<DataEvent>()
                    .id(data.id.toString())
                    .event("data-update")
                    .data(DataEvent.from(data))
                    .build()
            }
            .onEach { delay(1000) } // Rate limiting
    
    @GetMapping("/reactive")
    fun reactiveEndpoint(): Mono<ResponseEntity<String>> = mono {
        delay(100)
        ResponseEntity.ok("Reactive response")
    }
}
```

## Configuration

### Application Configuration
```kotlin
@Configuration
@ConfigurationProperties(prefix = "app")
@ConstructorBinding
data class AppProperties(
    val jwt: JwtProperties,
    val cors: CorsProperties,
    val cache: CacheProperties
) {
    data class JwtProperties(
        val secret: String,
        val expiration: Duration = Duration.ofHours(24)
    )
    
    data class CorsProperties(
        val allowedOrigins: List<String> = listOf("*"),
        val allowedMethods: List<String> = listOf("GET", "POST", "PUT", "DELETE")
    )
    
    data class CacheProperties(
        val timeToLive: Duration = Duration.ofMinutes(10),
        val maxSize: Int = 1000
    )
}

@Configuration
@EnableCaching
class CacheConfig(
    private val appProperties: AppProperties
) {
    @Bean
    fun cacheManager(): CacheManager = CaffeineCacheManager().apply {
        setCaffeine(
            Caffeine.newBuilder()
                .expireAfterWrite(appProperties.cache.timeToLive)
                .maximumSize(appProperties.cache.maxSize.toLong())
        )
    }
}
```

### Security Configuration
```kotlin
@Configuration
@EnableWebSecurity
@EnableMethodSecurity
class SecurityConfig(
    private val jwtAuthenticationFilter: JwtAuthenticationFilter,
    private val authenticationProvider: AuthenticationProvider
) {
    
    @Bean
    fun securityFilterChain(http: HttpSecurity): SecurityFilterChain {
        return http
            .csrf { it.disable() }
            .cors { }
            .sessionManagement { 
                it.sessionCreationPolicy(SessionCreationPolicy.STATELESS) 
            }
            .authorizeHttpRequests { auth ->
                auth
                    .requestMatchers("/api/v1/auth/**").permitAll()
                    .requestMatchers("/api/v1/public/**").permitAll()
                    .requestMatchers(HttpMethod.GET, "/api/v1/users/**").hasAnyRole("USER", "ADMIN")
                    .requestMatchers("/api/v1/admin/**").hasRole("ADMIN")
                    .anyRequest().authenticated()
            }
            .authenticationProvider(authenticationProvider)
            .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter::class.java)
            .build()
    }
}
```

## Database and Transactions

### Entity Definitions
```kotlin
@Entity
@Table(name = "users")
class User(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Long = 0,
    
    @Column(unique = true, nullable = false)
    var email: String,
    
    @Column(nullable = false)
    var name: String,
    
    @Column(nullable = false)
    var passwordHash: String,
    
    @Enumerated(EnumType.STRING)
    var role: UserRole = UserRole.USER,
    
    var active: Boolean = true,
    
    @CreatedDate
    var createdAt: Instant = Instant.now(),
    
    @LastModifiedDate
    var updatedAt: Instant = Instant.now(),
    
    @Version
    var version: Long = 0
) {
    @OneToMany(mappedBy = "user", cascade = [CascadeType.ALL], orphanRemoval = true)
    var orders: MutableList<Order> = mutableListOf()
}

enum class UserRole {
    USER, ADMIN, MODERATOR
}
```

## Monitoring and Logging

### Structured Logging
```kotlin
@Component
class LoggingAspect {
    private val logger = LoggerFactory.getLogger(javaClass)
    
    @Around("@annotation(Loggable)")
    fun logExecutionTime(joinPoint: ProceedingJoinPoint): Any? {
        val start = System.currentTimeMillis()
        
        return try {
            val result = joinPoint.proceed()
            val duration = System.currentTimeMillis() - start
            
            logger.info(
                "Method executed successfully",
                kv("method", joinPoint.signature.name),
                kv("duration", duration),
                kv("class", joinPoint.target.javaClass.simpleName)
            )
            
            result
        } catch (e: Exception) {
            logger.error(
                "Method execution failed",
                kv("method", joinPoint.signature.name),
                kv("error", e.message),
                e
            )
            throw e
        }
    }
}

@Target(AnnotationTarget.FUNCTION)
@Retention(AnnotationRetention.RUNTIME)
annotation class Loggable
```

## Best Practices

1. **Use coroutines** for async operations instead of blocking calls
2. **Leverage null safety** - avoid using !! operator
3. **Prefer immutability** - use val over var when possible
4. **Use data classes** for DTOs and value objects
5. **Apply functional programming** - use map, filter, fold
6. **Extension functions** for utility methods
7. **Sealed classes** for restricted hierarchies
8. **Inline classes** for type-safe wrappers
9. **Delegate properties** for cross-cutting concerns
10. **Test with MockK** for Kotlin-friendly mocking

## Integration with Claude Code

When working with Kotlin backend projects:
- Use the `patterns` agent for Kotlin idioms and coroutines
- Use the `researcher` agent for Spring Boot Kotlin best practices
- Use the `principles` agent for functional programming patterns
- Use the `complete` agent for null safety checks
- Use the `docsync` agent for KDoc documentation