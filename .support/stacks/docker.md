# Docker Development Reference

Essential Docker containerization guidelines for Claude Code projects.

## Dockerfile Best Practices
```dockerfile
# Use specific version tags
FROM node:18-alpine AS base

WORKDIR /app

# Install dependencies first (better caching)
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

# Copy source code
COPY . .

# Create non-root user
RUN addgroup -g 1001 -S nodejs && adduser -S nextjs -u 1001
USER nextjs

EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:3000/health || exit 1

CMD ["npm", "start"]
```

## Multi-Stage Builds
```dockerfile
# Build stage
FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

# Production stage
FROM alpine:latest AS production
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app/main .
RUN adduser -D -s /bin/sh appuser
USER appuser
CMD ["./main"]
```

## Docker Compose
```yaml
# docker-compose.yml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development
      - DATABASE_URL=postgresql://user:password@db:5432/appdb
    depends_on:
      db:
        condition: service_healthy

  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: appdb
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user -d appdb"]
      interval: 10s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    volumes:
      - redis_data:/data
    ports:
      - "6379:6379"

volumes:
  postgres_data:
  redis_data:
```

## Common Commands
```bash
# Build and run
docker build -t myapp:latest .
docker run -d -p 3000:3000 --name myapp myapp:latest

# Docker Compose
docker-compose up -d
docker-compose up --build
docker-compose down -v
docker-compose logs -f app

# Development with hot reload
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up

# Production deployment
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

# Cleanup
docker system prune -f
docker volume prune -f
```

## Size Optimization
```dockerfile
# Alpine-based image
FROM node:18-alpine

# Multi-stage with distroless
FROM gcr.io/distroless/nodejs18-debian11
COPY --from=builder /app/node_modules ./node_modules
COPY . .
CMD ["index.js"]

# Minimize layers
RUN apt-get update && apt-get install -y \
    curl git \
    && rm -rf /var/lib/apt/lists/*
```

## Security Hardening
```dockerfile
# Use specific, minimal base image
FROM node:18.17.0-alpine3.18

# Update packages
RUN apk update && apk upgrade && \
    apk add --no-cache dumb-init && \
    rm -rf /var/cache/apk/*

# Create app user
RUN addgroup -g 1001 -S nodejs && adduser -S nextjs -u 1001
WORKDIR /app
COPY --chown=nextjs:nodejs package*.json ./
USER nextjs

# Install dependencies
RUN npm ci --only=production && npm cache clean --force

# Copy app source
COPY --chown=nextjs:nodejs . .

# Use dumb-init for signal handling
ENTRYPOINT ["dumb-init", "--"]
CMD ["node", "server.js"]
```

## Container Registries
```bash
# Docker Hub
docker tag myapp:latest username/myapp:latest
docker push username/myapp:latest

# GitHub Container Registry
echo $GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin
docker tag myapp:latest ghcr.io/username/myapp:latest
docker push ghcr.io/username/myapp:latest

# Private registry
docker login registry.company.com
docker tag myapp:latest registry.company.com/myapp:latest
docker push registry.company.com/myapp:latest
```

## Environment Management
```bash
# .env file
NODE_ENV=development
DATABASE_URL=postgresql://user:password@localhost:5432/appdb
REDIS_URL=redis://localhost:6379

# docker-compose.yml uses .env automatically
services:
  app:
    environment:
      - NODE_ENV=${NODE_ENV}
      - DATABASE_URL=${DATABASE_URL}
```

## Monitoring & Logging
```yaml
# Logging configuration
services:
  app:
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"

# Health checks
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD /healthcheck.sh
```

## CI/CD Integration
```yaml
# GitHub Actions
name: Docker Build and Push
on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v3
    - name: Login to GitHub Container Registry
      uses: docker/login-action@v3
      with:
        registry: ghcr.io
        username: ${{ github.actor }}
        password: ${{ secrets.GITHUB_TOKEN }}
    - name: Build and push
      uses: docker/build-push-action@v5
      with:
        context: .
        push: true
        tags: ghcr.io/${{ github.repository }}:latest
```

## Troubleshooting
```bash
# Container debugging
docker logs container_name
docker exec -it container_name sh
docker stats container_name
docker inspect container_name

# Port conflicts
docker ps -a
netstat -tulpn | grep :3000

# Copy files to/from container
docker cp file.txt container_name:/app/
docker cp container_name:/app/logs ./
```

## Best Practices
- Use specific version tags, not 'latest'
- Run as non-root user for security
- Use minimal base images (alpine, distroless)
- Implement proper health checks
- Use multi-stage builds for smaller images
- Scan images for vulnerabilities regularly
- Use .dockerignore to exclude unnecessary files
- Keep containers stateless and ephemeral
- Use secrets management for sensitive data
- Monitor container resource usage