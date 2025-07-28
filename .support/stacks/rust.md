# Rust Development Guidelines

This file contains Rust-specific development guidelines for Claude Code.

## Cargo Package Management

### Project Management
- **New project**: `cargo new project_name`
- **Build project**: `cargo build` (debug) or `cargo build --release`
- **Run project**: `cargo run` or `cargo run --release`
- **Check code**: `cargo check` (faster than build)
- **Update dependencies**: `cargo update`

### Dependency Management
```toml
# Cargo.toml
[dependencies]
serde = { version = "1.0", features = ["derive"] }
tokio = { version = "1", features = ["full"] }
reqwest = "0.11"

[dev-dependencies]
criterion = "0.5"
mockall = "0.11"
```

### Common Commands
```bash
cargo add serde --features derive    # Add dependency
cargo tree                           # View dependency tree
cargo audit                          # Security audit
cargo clippy                         # Linting
cargo fmt                           # Format code
cargo doc --open                    # Generate docs
```

## Project Structure

### Standard Rust Project Layout
```
project-root/
├── Cargo.toml                      # Project manifest
├── Cargo.lock                      # Lock file (commit for apps)
├── src/
│   ├── main.rs                     # Application entry point
│   ├── lib.rs                      # Library entry point
│   ├── bin/                        # Additional binaries
│   └── modules/
│       ├── mod.rs
│       └── submodule.rs
├── tests/                          # Integration tests
├── benches/                        # Benchmarks
├── examples/                       # Example usage
└── target/                         # Build artifacts (gitignored)
```

## Error Handling

### Result Type Pattern
```rust
use std::error::Error;
use std::fmt;

#[derive(Debug)]
enum AppError {
    Io(std::io::Error),
    Parse(std::num::ParseIntError),
    Custom(String),
}

impl fmt::Display for AppError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            AppError::Io(e) => write!(f, "IO error: {}", e),
            AppError::Parse(e) => write!(f, "Parse error: {}", e),
            AppError::Custom(s) => write!(f, "Error: {}", s),
        }
    }
}

impl Error for AppError {}

// Using the ? operator
fn read_number(path: &str) -> Result<i32, AppError> {
    let contents = std::fs::read_to_string(path)
        .map_err(AppError::Io)?;
    let number = contents.trim().parse::<i32>()
        .map_err(AppError::Parse)?;
    Ok(number)
}
```

### Error Libraries
```rust
// Using anyhow for applications
use anyhow::{Context, Result};

fn process_file(path: &str) -> Result<String> {
    let content = std::fs::read_to_string(path)
        .context("Failed to read file")?;
    Ok(content)
}

// Using thiserror for libraries
use thiserror::Error;

#[derive(Error, Debug)]
pub enum DataError {
    #[error("data not found")]
    NotFound,
    #[error("invalid format: {0}")]
    InvalidFormat(String),
    #[error(transparent)]
    Io(#[from] std::io::Error),
}
```

## Testing

### Unit Tests
```rust
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_addition() {
        assert_eq!(add(2, 2), 4);
    }

    #[test]
    #[should_panic(expected = "overflow")]
    fn test_overflow() {
        add(u32::MAX, 1);
    }

    #[test]
    fn test_result() -> Result<(), String> {
        let value = operation()?;
        assert_eq!(value, 42);
        Ok(())
    }
}
```

### Integration Tests
```rust
// tests/integration_test.rs
use my_crate;

#[test]
fn test_public_api() {
    let result = my_crate::public_function();
    assert!(result.is_ok());
}
```

### Property-Based Testing
```rust
use proptest::prelude::*;

proptest! {
    #[test]
    fn test_reversing_twice(s: String) {
        let reversed = reverse(&s);
        let double_reversed = reverse(&reversed);
        assert_eq!(s, double_reversed);
    }
}
```

### Test Organization
```bash
cargo test                  # Run all tests
cargo test test_name       # Run specific test
cargo test -- --nocapture  # Show println! output
cargo test -- --test-threads=1  # Sequential execution
```

## Async Programming

### Tokio Runtime
```rust
use tokio;

#[tokio::main]
async fn main() {
    let result = async_operation().await;
    println!("Result: {:?}", result);
}

async fn async_operation() -> Result<String, Box<dyn Error>> {
    let response = reqwest::get("https://api.example.com")
        .await?
        .text()
        .await?;
    Ok(response)
}
```

### Concurrent Tasks
```rust
use tokio::task;
use futures::future::join_all;

async fn process_concurrently(items: Vec<String>) -> Vec<Result<String, Error>> {
    let tasks: Vec<_> = items
        .into_iter()
        .map(|item| {
            task::spawn(async move {
                process_item(item).await
            })
        })
        .collect();
    
    let results = join_all(tasks).await;
    results.into_iter()
        .map(|r| r.unwrap())
        .collect()
}
```

## Memory Management

### Ownership Patterns
```rust
// Move semantics
fn take_ownership(s: String) {
    println!("{}", s);
} // s is dropped here

// Borrowing
fn borrow(s: &str) {
    println!("{}", s);
} // s is not dropped

// Mutable borrowing
fn modify(s: &mut String) {
    s.push_str(" modified");
}

// Clone when needed
let s1 = String::from("hello");
let s2 = s1.clone(); // Explicit clone
```

### Smart Pointers
```rust
use std::rc::Rc;
use std::cell::RefCell;
use std::sync::Arc;

// Reference counting
let data = Rc::new(vec![1, 2, 3]);
let data_clone = Rc::clone(&data);

// Interior mutability
let value = RefCell::new(5);
*value.borrow_mut() += 1;

// Thread-safe reference counting
let shared = Arc::new(Mutex::new(0));
let shared_clone = Arc::clone(&shared);
```

## Common Patterns

### Builder Pattern
```rust
#[derive(Default)]
struct ServerBuilder {
    host: Option<String>,
    port: Option<u16>,
    workers: Option<usize>,
}

impl ServerBuilder {
    fn new() -> Self {
        Self::default()
    }
    
    fn host(mut self, host: impl Into<String>) -> Self {
        self.host = Some(host.into());
        self
    }
    
    fn port(mut self, port: u16) -> Self {
        self.port = Some(port);
        self
    }
    
    fn build(self) -> Result<Server, String> {
        Ok(Server {
            host: self.host.ok_or("host required")?,
            port: self.port.unwrap_or(8080),
            workers: self.workers.unwrap_or(4),
        })
    }
}

// Usage
let server = ServerBuilder::new()
    .host("localhost")
    .port(3000)
    .build()?;
```

### Type State Pattern
```rust
struct Unauthorized;
struct Authorized { token: String }

struct Client<State> {
    state: State,
}

impl Client<Unauthorized> {
    fn new() -> Self {
        Client { state: Unauthorized }
    }
    
    fn login(self, token: String) -> Client<Authorized> {
        Client { state: Authorized { token } }
    }
}

impl Client<Authorized> {
    fn make_request(&self) -> Result<Response, Error> {
        // Can only call this when authorized
    }
}
```

## Performance Optimization

### Benchmarking with Criterion
```rust
use criterion::{black_box, criterion_group, criterion_main, Criterion};

fn fibonacci(n: u64) -> u64 {
    match n {
        0 => 1,
        1 => 1,
        n => fibonacci(n-1) + fibonacci(n-2),
    }
}

fn bench_fibonacci(c: &mut Criterion) {
    c.bench_function("fib 20", |b| {
        b.iter(|| fibonacci(black_box(20)))
    });
}

criterion_group!(benches, bench_fibonacci);
criterion_main!(benches);
```

### Zero-Cost Abstractions
```rust
// Iterator chains compile to efficient code
let sum: i32 = vec![1, 2, 3, 4, 5]
    .iter()
    .filter(|&&x| x % 2 == 0)
    .map(|&x| x * x)
    .sum();

// Use const generics for compile-time optimization
fn process_array<const N: usize>(arr: [i32; N]) -> i32 {
    arr.iter().sum()
}
```

## Web Development

### Actix-web Example
```rust
use actix_web::{web, App, HttpResponse, HttpServer, Result};
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize)]
struct User {
    name: String,
    age: u32,
}

async fn get_user(user_id: web::Path<u32>) -> Result<HttpResponse> {
    let user = User {
        name: "Alice".to_string(),
        age: 30,
    };
    Ok(HttpResponse::Ok().json(user))
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| {
        App::new()
            .route("/user/{id}", web::get().to(get_user))
    })
    .bind("127.0.0.1:8080")?
    .run()
    .await
}
```

## CLI Applications

### Using clap
```rust
use clap::Parser;

#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
struct Args {
    /// Name of the person to greet
    #[arg(short, long)]
    name: String,

    /// Number of times to greet
    #[arg(short, long, default_value_t = 1)]
    count: u8,
}

fn main() {
    let args = Args::parse();

    for _ in 0..args.count {
        println!("Hello {}!", args.name)
    }
}
```

## Best Practices

1. **Use `clippy`** for additional lints beyond the compiler
2. **Format with `rustfmt`** - maintain consistent style
3. **Document public APIs** - use `///` for doc comments
4. **Handle all Results** - don't use `unwrap()` in production
5. **Minimize `unsafe`** - and document why it's needed
6. **Use semantic versioning** - follow SemVer for libraries
7. **Write tests** - unit, integration, and doc tests
8. **Profile before optimizing** - use tools like `cargo flamegraph`
9. **Leverage the type system** - make invalid states unrepresentable
10. **Follow Rust API guidelines** - https://rust-lang.github.io/api-guidelines/

## Integration with Claude Code

When working with Rust projects:
- Use the `patterns` agent to identify Rust idioms
- Use the `researcher` agent to find crates on crates.io
- Use the `principles` agent for ownership/borrowing guidance
- Use the `complete` agent to add error handling
- Use the `docsync` agent to update rustdoc comments