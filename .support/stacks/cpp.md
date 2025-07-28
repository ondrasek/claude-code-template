# C++ Development Reference

Essential modern C++ development guidelines for Claude Code projects.

## Build System (CMake)
```cmake
# CMakeLists.txt
cmake_minimum_required(VERSION 3.20)
project(MyProject VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Compiler warnings
if(MSVC)
    add_compile_options(/W4 /WX)
else()
    add_compile_options(-Wall -Wextra -Wpedantic -Werror)
endif()

# Find packages
find_package(fmt REQUIRED)
find_package(GTest REQUIRED)

# Add library
add_library(mylib src/core.cpp src/utils.cpp)
target_include_directories(mylib PUBLIC include)
target_link_libraries(mylib PUBLIC fmt::fmt)

# Add executable
add_executable(myapp src/main.cpp)
target_link_libraries(myapp PRIVATE mylib)

# Tests
enable_testing()
add_subdirectory(tests)
```

## Build Commands
```bash
# Configure
cmake -B build -S . -DCMAKE_BUILD_TYPE=Release

# Build
cmake --build build --parallel

# Test
ctest --test-dir build --output-on-failure

# Install
cmake --install build --prefix /usr/local
```

## Modern C++ Features (C++20)
```cpp
#include <concepts>
#include <ranges>
#include <coroutine>

// Concepts
template<typename T>
concept Numeric = std::integral<T> || std::floating_point<T>;

template<Numeric T>
T add(T a, T b) {
    return a + b;
}

// Ranges
std::vector<int> numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

auto result = numbers 
    | std::views::filter([](int n) { return n % 2 == 0; })
    | std::views::transform([](int n) { return n * n; });

// Auto type deduction
auto lambda = [](auto x, auto y) { return x + y; };
```

## Memory Management
```cpp
#include <memory>

// Smart pointers (RAII)
auto unique = std::make_unique<Resource>(100);
auto shared = std::make_shared<Resource>(200);

// Custom deleters
auto fileDeleter = [](FILE* f) { if (f) fclose(f); };
std::unique_ptr<FILE, decltype(fileDeleter)> file(
    fopen("data.txt", "r"), fileDeleter);

// Rule of Five
class Resource {
public:
    explicit Resource(size_t size) : data_(size) {}
    ~Resource() = default;
    Resource(const Resource&) = delete;
    Resource& operator=(const Resource&) = delete;
    Resource(Resource&&) = default;
    Resource& operator=(Resource&&) = default;
    
private:
    std::vector<int> data_;
};
```

## Error Handling
```cpp
#include <optional>
#include <variant>
#include <expected> // C++23

// Using std::optional
std::optional<int> divide(int a, int b) {
    if (b == 0) return std::nullopt;
    return a / b;
}

// Using std::variant for errors
template<typename T>
using Result = std::variant<T, std::string>;

Result<int> parseNumber(const std::string& str) {
    try {
        return std::stoi(str);
    } catch (...) {
        return "Invalid number format";
    }
}

// Exception safety
class Container {
    std::vector<std::unique_ptr<Resource>> resources_;
    
public:
    void add(std::unique_ptr<Resource> resource) {
        resources_.push_back(std::move(resource));
    }
    
    void swap(Container& other) noexcept {
        resources_.swap(other.resources_);
    }
};
```

## Concurrency
```cpp
#include <thread>
#include <mutex>
#include <condition_variable>
#include <atomic>
#include <future>

// Thread-safe queue
class ThreadSafeQueue {
    mutable std::mutex mutex_;
    std::condition_variable cv_;
    std::queue<int> queue_;
    
public:
    void push(int value) {
        {
            std::lock_guard lock(mutex_);
            queue_.push(value);
        }
        cv_.notify_one();
    }
    
    std::optional<int> pop() {
        std::unique_lock lock(mutex_);
        cv_.wait(lock, [this] { return !queue_.empty(); });
        
        int value = queue_.front();
        queue_.pop();
        return value;
    }
};

// Async and futures
template<typename Iterator>
auto parallel_sum(Iterator begin, Iterator end) {
    auto size = std::distance(begin, end);
    if (size < 1000) {
        return std::accumulate(begin, end, 0);
    }
    
    auto mid = begin + size / 2;
    auto future = std::async(std::launch::async, 
        parallel_sum<Iterator>, mid, end);
    
    auto sum1 = parallel_sum(begin, mid);
    return sum1 + future.get();
}

// Atomic operations
class Counter {
    std::atomic<int> count_{0};
    
public:
    void increment() {
        count_.fetch_add(1, std::memory_order_relaxed);
    }
    
    int get() const {
        return count_.load(std::memory_order_relaxed);
    }
};
```

## Template Metaprogramming
```cpp
// Variadic templates
template<typename... Args>
void print(Args&&... args) {
    ((std::cout << args << " "), ...);
    std::cout << '\n';
}

// Fold expressions
template<typename... Args>
auto sum(Args... args) {
    return (args + ...);
}

// SFINAE and concepts
template<std::integral T>
void process(T value) {
    std::cout << "Processing integer: " << value << '\n';
}

template<std::floating_point T>
void process(T value) {
    std::cout << "Processing float: " << value << '\n';
}
```

## Testing with Google Test
```cpp
#include <gtest/gtest.h>

class MathTest : public ::testing::Test {
protected:
    void SetUp() override {
        // Setup code
    }
};

TEST_F(MathTest, Addition) {
    EXPECT_EQ(add(2, 3), 5);
    EXPECT_EQ(add(-1, 1), 0);
}

TEST(MathTest, Division) {
    EXPECT_THROW(divide(10, 0), std::invalid_argument);
    EXPECT_DOUBLE_EQ(divide(10.0, 3.0), 3.33333);
}

// Parameterized tests
class PrimeTest : public ::testing::TestWithParam<int> {};

TEST_P(PrimeTest, IsPrime) {
    int n = GetParam();
    EXPECT_TRUE(isPrime(n));
}

INSTANTIATE_TEST_SUITE_P(PrimeNumbers, PrimeTest, 
    ::testing::Values(2, 3, 5, 7, 11, 13, 17, 19));
```

## Performance Optimization
```cpp
// constexpr for compile-time computation
template<size_t N>
constexpr auto fibonacci() {
    if constexpr (N == 0) return 0;
    else if constexpr (N == 1) return 1;
    else return fibonacci<N-1>() + fibonacci<N-2>();
}

// Force inline
[[gnu::always_inline]] inline int fastAdd(int a, int b) {
    return a + b;
}

// Branch prediction hints
[[likely]] if (condition) {
    // Common path
}
[[unlikely]] else {
    // Rare path
}

// Cache-friendly data layout
struct alignas(64) CacheLineAligned {
    std::atomic<int> counter;
    char padding[60];
};
```

## Common Libraries
```bash
# Package managers
vcpkg install fmt spdlog catch2
conan install . --build=missing

# Popular libraries
fmt           # String formatting
spdlog        # Logging
nlohmann-json # JSON parsing
catch2        # Testing framework
boost         # Comprehensive library collection
```

## Best Practices
- Use RAII for resource management
- Prefer stack allocation over heap when possible
- Use const correctness - const by default
- Follow Rule of Zero/Five for classes
- Use smart pointers - avoid raw new/delete
- Prefer algorithms over hand-written loops
- Use static analysis tools (clang-tidy, cppcheck)
- Enable all warnings and treat as errors
- Write unit tests with good coverage
- Profile before optimizing - measure first
- Use modern C++ features appropriately
- Keep functions small and focused
- Use meaningful variable names
- Avoid global state when possible