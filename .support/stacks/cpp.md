# C++ Development Guidelines

This file contains C++ specific development guidelines for Claude Code.

## Build Systems

### CMake
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
find_package(spdlog REQUIRED)
find_package(GTest REQUIRED)

# Add library
add_library(mylib 
    src/core.cpp
    src/utils.cpp
)

target_include_directories(mylib PUBLIC 
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)

target_link_libraries(mylib 
    PUBLIC fmt::fmt
    PRIVATE spdlog::spdlog
)

# Add executable
add_executable(myapp src/main.cpp)
target_link_libraries(myapp PRIVATE mylib)

# Tests
enable_testing()
add_subdirectory(tests)
```

### Build Commands
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

## Project Structure

### Modern C++ Project Layout
```
project-root/
├── include/               # Public headers
│   └── myproject/
│       ├── core.hpp
│       └── utils.hpp
├── src/                   # Implementation files
│   ├── main.cpp
│   ├── core.cpp
│   └── utils.cpp
├── tests/                 # Unit tests
│   ├── CMakeLists.txt
│   └── test_core.cpp
├── benchmarks/            # Performance tests
├── docs/                  # Documentation
├── cmake/                 # CMake modules
├── CMakeLists.txt
└── README.md
```

## Modern C++ Features (C++20)

### Concepts
```cpp
#include <concepts>

template<typename T>
concept Numeric = std::integral<T> || std::floating_point<T>;

template<Numeric T>
T add(T a, T b) {
    return a + b;
}

// Custom concept
template<typename T>
concept Printable = requires(T t) {
    { std::cout << t } -> std::same_as<std::ostream&>;
};
```

### Ranges
```cpp
#include <ranges>
#include <vector>
#include <algorithm>

std::vector<int> numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

// Filter and transform
auto result = numbers 
    | std::views::filter([](int n) { return n % 2 == 0; })
    | std::views::transform([](int n) { return n * n; });

// Take first 3
auto first_three = numbers | std::views::take(3);
```

### Coroutines
```cpp
#include <coroutine>

struct Task {
    struct promise_type {
        Task get_return_object() { 
            return {std::coroutine_handle<promise_type>::from_promise(*this)}; 
        }
        std::suspend_never initial_suspend() { return {}; }
        std::suspend_never final_suspend() noexcept { return {}; }
        void return_void() {}
        void unhandled_exception() {}
    };
    
    std::coroutine_handle<promise_type> h_;
};

Task myCoroutine() {
    std::cout << "Start\n";
    co_await std::suspend_always{};
    std::cout << "End\n";
}
```

### Modules (C++20)
```cpp
// math.ixx
export module math;

export namespace math {
    int add(int a, int b) {
        return a + b;
    }
    
    template<typename T>
    T multiply(T a, T b) {
        return a * b;
    }
}

// main.cpp
import math;

int main() {
    return math::add(1, 2);
}
```

## Smart Pointers and Memory Management

### RAII and Smart Pointers
```cpp
#include <memory>
#include <vector>

class Resource {
public:
    explicit Resource(size_t size) : data_(size) {}
    // Rule of Five
    ~Resource() = default;
    Resource(const Resource&) = delete;
    Resource& operator=(const Resource&) = delete;
    Resource(Resource&&) = default;
    Resource& operator=(Resource&&) = default;
    
private:
    std::vector<int> data_;
};

void smartPointerExamples() {
    // Unique ownership
    auto unique = std::make_unique<Resource>(100);
    
    // Shared ownership
    auto shared = std::make_shared<Resource>(200);
    auto shared2 = shared; // Reference count = 2
    
    // Weak reference
    std::weak_ptr<Resource> weak = shared;
    if (auto locked = weak.lock()) {
        // Use locked
    }
}
```

### Custom Deleters
```cpp
auto fileDeleter = [](FILE* f) { 
    if (f) fclose(f); 
};

std::unique_ptr<FILE, decltype(fileDeleter)> file(
    fopen("data.txt", "r"), 
    fileDeleter
);
```

## Error Handling

### Modern Error Handling
```cpp
#include <expected> // C++23
#include <optional>
#include <variant>

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

// Using expected (C++23)
std::expected<int, std::string> safeDivide(int a, int b) {
    if (b == 0) 
        return std::unexpected("Division by zero");
    return a / b;
}
```

### Exception Safety
```cpp
class Container {
    std::vector<std::unique_ptr<Resource>> resources_;
    
public:
    // Strong exception guarantee
    void add(std::unique_ptr<Resource> resource) {
        resources_.push_back(std::move(resource));
    }
    
    // Basic exception guarantee with rollback
    void swap(Container& other) noexcept {
        resources_.swap(other.resources_);
    }
};
```

## Concurrency

### std::thread and Synchronization
```cpp
#include <thread>
#include <mutex>
#include <condition_variable>
#include <atomic>

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
```

### std::async and Futures
```cpp
#include <future>
#include <numeric>

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
```

### Atomic Operations
```cpp
#include <atomic>

class SpinLock {
    std::atomic_flag flag_ = ATOMIC_FLAG_INIT;
    
public:
    void lock() {
        while (flag_.test_and_set(std::memory_order_acquire)) {
            // Spin
        }
    }
    
    void unlock() {
        flag_.clear(std::memory_order_release);
    }
};

// Lock-free counter
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

### Variadic Templates
```cpp
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
```

### SFINAE and Type Traits
```cpp
#include <type_traits>

// Enable if example
template<typename T>
typename std::enable_if_t<std::is_arithmetic_v<T>, T>
abs(T value) {
    return value < 0 ? -value : value;
}

// Concept-based overloading (C++20)
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

### Basic Tests
```cpp
#include <gtest/gtest.h>

class MathTest : public ::testing::Test {
protected:
    void SetUp() override {
        // Setup code
    }
    
    void TearDown() override {
        // Cleanup code
    }
};

TEST_F(MathTest, Addition) {
    EXPECT_EQ(add(2, 3), 5);
    EXPECT_EQ(add(-1, 1), 0);
}

TEST(MathTest, Division) {
    EXPECT_THROW(divide(10, 0), std::invalid_argument);
    EXPECT_DOUBLE_EQ(divide(10.0, 3.0), 3.33333, 0.00001);
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

### Compile-Time Optimization
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
```

### Memory Optimization
```cpp
// Structure packing
#pragma pack(push, 1)
struct PackedData {
    char c;
    int i;
    short s;
};
#pragma pack(pop)

// Cache-friendly data layout
struct alignas(64) CacheLineAligned {
    std::atomic<int> counter;
    char padding[60];
};
```

## Best Practices

1. **Use RAII** - Resource Acquisition Is Initialization
2. **Prefer stack allocation** over heap when possible
3. **Use const correctness** - const by default
4. **Follow Rule of Zero/Five** for classes
5. **Use smart pointers** - avoid raw new/delete
6. **Prefer algorithms** over hand-written loops
7. **Use static analysis** tools (clang-tidy, cppcheck)
8. **Enable all warnings** and treat as errors
9. **Write unit tests** with good coverage
10. **Profile before optimizing** - measure first

## Integration with Claude Code

When working with C++ projects:
- Use the `patterns` agent for design patterns in C++
- Use the `researcher` agent for modern C++ features
- Use the `principles` agent for SOLID in C++ context
- Use the `complete` agent for RAII patterns
- Use the `docsync` agent for Doxygen documentation