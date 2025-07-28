# Kotlin Backend Development Reference

Essential Kotlin backend development guidelines for Claude Code projects.

## Build System (Gradle Kotlin DSL)
```kotlin
// build.gradle.kts
plugins {
    kotlin("jvm") version "1.9.20"
    kotlin("plugin.spring") version "1.9.20"
    id("org.springframework.boot") version "3.2.0"
}

dependencies {
    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation("org.springframework.boot:spring-boot-starter-data-jpa")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core")
    implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
    testImplementation("io.mockk:mockk:1.13.8")
}
```

## Project Structure
```
project/
├── src/main/kotlin/com/example/app/
│   ├── Application.kt
│   ├── controller/
│   ├── service/
│   ├── repository/
│   └── model/
└── src/test/kotlin/
```

## Modern Kotlin Features
```kotlin
// Data classes with validation
data class CreateUserRequest(
    @field:NotBlank @field:Email val email: String,
    @field:NotBlank @field:Size(min = 2, max = 100) val name: String
)

// Sealed classes for results
sealed class Result<out T> {
    data class Success<T>(val data: T) : Result<T>()
    data class Error(val message: String) : Result<Nothing>()
}

// Extension functions
inline fun <R> Result<*>.onSuccess(action: (Any) -> R): Result<*> {
    if (this is Result.Success) action(data)
    return this
}
```

## Spring Boot with Kotlin
```kotlin
@RestController
@RequestMapping("/api/v1/users")
class UserController(private val userService: UserService) {
    
    @GetMapping
    suspend fun getAllUsers(@PageableDefault(size = 20) pageable: Pageable) =
        userService.findAll(pageable).map { UserResponse.from(it) }
    
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    suspend fun createUser(@Valid @RequestBody request: CreateUserRequest) =
        UserResponse.from(userService.create(request))
}

@Service
class UserService(private val userRepository: UserRepository) {
    
    @Transactional
    suspend fun create(request: CreateUserRequest): User = withContext(Dispatchers.IO) {
        userRepository.findByEmail(request.email)?.let {
            throw ConflictException("Email already exists")
        }
        userRepository.save(User(email = request.email, name = request.name))
    }
}
```

## Database & JPA
```kotlin
@Entity
@Table(name = "users")
class User(
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Long = 0,
    
    @Column(unique = true, nullable = false)
    var email: String,
    
    @Column(nullable = false)
    var name: String,
    
    @CreatedDate var createdAt: Instant = Instant.now(),
    @Version var version: Long = 0
)

@Repository
interface UserRepository : JpaRepository<User, Long> {
    fun findByEmail(email: String): User?
    suspend fun findByNameContaining(name: String): List<User>
}
```

## Coroutines & Async
```kotlin
// Parallel processing
suspend fun processMultipleDataSources(): ProcessingResult = coroutineScope {
    val deferred1 = async { fetchFromSource1() }
    val deferred2 = async { fetchFromSource2() }
    awaitAll(deferred1, deferred2)
}

// Flow for streaming
fun processStream(): Flow<ProcessedItem> = flow {
    getDataStream().collect { rawData ->
        emit(processItem(rawData))
    }
}.flowOn(Dispatchers.Default)
```

## Testing
```kotlin
@ExtendWith(MockKExtension::class)
class UserServiceTest {
    @MockK private lateinit var userRepository: UserRepository
    @InjectMockKs private lateinit var userService: UserService
    
    @Test
    fun `should create user successfully`() = runTest {
        every { userRepository.findByEmail(any()) } returns null
        every { userRepository.save(any()) } returns user
        
        val result = userService.create(request)
        
        assertThat(result).isEqualTo(user)
        verify { userRepository.save(any()) }
    }
}
```

## Configuration
```kotlin
@Configuration
@ConfigurationProperties(prefix = "app")
@ConstructorBinding
data class AppProperties(
    val jwt: JwtProperties,
    val cors: CorsProperties
) {
    data class JwtProperties(
        val secret: String,
        val expiration: Duration = Duration.ofHours(24)
    )
}
```

## Best Practices
- Use coroutines for async operations instead of blocking calls
- Leverage null safety - avoid using !! operator  
- Prefer immutability with val over var
- Use data classes for DTOs and value objects
- Apply functional programming with map, filter, fold
- Use extension functions for utility methods
- Test with MockK for Kotlin-friendly mocking