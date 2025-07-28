# Docker Development Guidelines

This file contains Docker and containerization guidelines for Claude Code.

## Docker Basics

### Dockerfile Best Practices
```dockerfile
# Use specific version tags, not 'latest'
FROM node:18-alpine AS base

# Set working directory
WORKDIR /app

# Install dependencies first (for better caching)
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

# Copy source code
COPY . .

# Create non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001

# Switch to non-root user
USER nextjs

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:3000/health || exit 1

# Start command
CMD ["npm", "start"]
```

### Multi-Stage Builds
```dockerfile
# Build stage
FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Production stage
FROM alpine:latest AS production

# Add certificates for HTTPS
RUN apk --no-cache add ca-certificates
WORKDIR /root/

# Copy binary from builder
COPY --from=builder /app/main .

# Add non-root user
RUN adduser -D -s /bin/sh appuser
USER appuser

CMD ["./main"]
```

## Docker Compose

### Development Environment
```yaml
# docker-compose.yml
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile.dev
    ports:
      - "3000:3000"
    volumes:
      - .:/app
      - /app/node_modules
    environment:
      - NODE_ENV=development
      - DATABASE_URL=postgresql://user:password@db:5432/appdb
    depends_on:
      db:
        condition: service_healthy
    networks:
      - app-network

  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: appdb
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql
    ports:
      - "5432:5432"
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user -d appdb"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - app-network

  redis:
    image: redis:7-alpine
    command: redis-server --appendonly yes
    volumes:
      - redis_data:/data
    ports:
      - "6379:6379"
    networks:
      - app-network

  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./ssl:/etc/nginx/ssl:ro
    depends_on:
      - app
    networks:
      - app-network

volumes:
  postgres_data:
  redis_data:

networks:
  app-network:
    driver: bridge
```

### Production Override
```yaml
# docker-compose.prod.yml
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    restart: unless-stopped
    environment:
      - NODE_ENV=production
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"

  db:
    restart: unless-stopped
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
```

## Container Optimization

### Size Optimization
```dockerfile
# Alpine-based image
FROM node:18-alpine

# Multi-stage with distroless
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM gcr.io/distroless/nodejs18-debian11
COPY --from=builder /app/node_modules ./node_modules
COPY . .
CMD ["index.js"]

# Minimize layers
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Use .dockerignore
# .dockerignore content:
node_modules
npm-debug.log
.git
.gitignore
README.md
.env
.nyc_output
coverage
.nyc_output
```

### Security Hardening
```dockerfile
# Use specific, minimal base image
FROM node:18.17.0-alpine3.18

# Update packages and remove package manager
RUN apk update && apk upgrade && \
    apk add --no-cache dumb-init && \
    rm -rf /var/cache/apk/*

# Create app directory and user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001
    
WORKDIR /app

# Set correct permissions
COPY --chown=nextjs:nodejs package*.json ./
USER nextjs

# Install dependencies
RUN npm ci --only=production && \
    npm cache clean --force

# Copy app source
COPY --chown=nextjs:nodejs . .

# Run as non-root
USER nextjs

# Use dumb-init for signal handling
ENTRYPOINT ["dumb-init", "--"]
CMD ["node", "server.js"]
```

## Development Workflow

### Docker Commands
```bash
# Build image
docker build -t myapp:latest .
docker build -t myapp:dev -f Dockerfile.dev .

# Run container
docker run -d -p 3000:3000 --name myapp myapp:latest
docker run -it --rm -v $(pwd):/app myapp:dev sh

# Docker Compose
docker-compose up -d
docker-compose up --build
docker-compose down -v
docker-compose logs -f app

# Development with hot reload
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up

# Production deployment
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

# Scaling services
docker-compose up -d --scale app=3

# View logs
docker logs -f container_name
docker-compose logs -f service_name
```

### Environment Management
```bash
# .env file
NODE_ENV=development
DATABASE_URL=postgresql://user:password@localhost:5432/appdb
REDIS_URL=redis://localhost:6379
JWT_SECRET=your-secret-key

# docker-compose.yml uses .env automatically
services:
  app:
    environment:
      - NODE_ENV=${NODE_ENV}
      - DATABASE_URL=${DATABASE_URL}
      
# Override for different environments
# .env.production
NODE_ENV=production
DATABASE_URL=postgresql://prod-user:prod-pass@prod-db:5432/prod-db
```

## Container Registries

### Docker Hub
```bash
# Tag and push
docker tag myapp:latest username/myapp:latest
docker tag myapp:latest username/myapp:v1.0.0
docker push username/myapp:latest
docker push username/myapp:v1.0.0

# Pull and run
docker pull username/myapp:latest
docker run -d -p 3000:3000 username/myapp:latest
```

### Private Registry
```bash
# Login to private registry
docker login registry.company.com

# Tag for private registry
docker tag myapp:latest registry.company.com/myapp:latest

# Push to private registry
docker push registry.company.com/myapp:latest
```

### GitHub Container Registry
```bash
# Login with personal access token
echo $GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin

# Tag and push
docker tag myapp:latest ghcr.io/username/myapp:latest
docker push ghcr.io/username/myapp:latest
```

## Kubernetes Integration

### Deployment YAML
```yaml
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
  labels:
    app: myapp
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: myapp
        image: myapp:latest
        ports:
        - containerPort: 3000
        env:
        - name: NODE_ENV
          value: "production"
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: myapp-secrets
              key: database-url
        resources:
          requests:
            memory: "128Mi"
            cpu: "100m"
          limits:
            memory: "256Mi"
            cpu: "200m"
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /ready
            port: 3000
          initialDelaySeconds: 5
          periodSeconds: 5

---
apiVersion: v1
kind: Service
metadata:
  name: myapp-service
spec:
  selector:
    app: myapp
  ports:
  - protocol: TCP
    port: 80
    targetPort: 3000
  type: LoadBalancer
```

## Monitoring and Logging

### Health Checks
```dockerfile
# Simple health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:3000/health || exit 1

# Custom health check script
COPY healthcheck.sh /healthcheck.sh
RUN chmod +x /healthcheck.sh
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD /healthcheck.sh
```

### Logging Configuration
```yaml
# docker-compose.yml with logging
services:
  app:
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
        
  # Using syslog
  app2:
    logging:
      driver: "syslog"
      options:
        syslog-address: "tcp://log-server:514"
        
  # Using fluentd
  app3:
    logging:
      driver: "fluentd"
      options:
        fluentd-address: "localhost:24224"
        tag: "docker.{{.Name}}"
```

## CI/CD Integration

### GitHub Actions
```yaml
# .github/workflows/docker.yml
name: Docker Build and Push

on:
  push:
    branches: [ main ]
  pull_request:
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
        
    - name: Extract metadata
      id: meta
      uses: docker/metadata-action@v5
      with:
        images: ghcr.io/${{ github.repository }}
        tags: |
          type=ref,event=branch
          type=ref,event=pr
          type=sha
          
    - name: Build and push
      uses: docker/build-push-action@v5
      with:
        context: .
        push: true
        tags: ${{ steps.meta.outputs.tags }}
        labels: ${{ steps.meta.outputs.labels }}
        cache-from: type=gha
        cache-to: type=gha,mode=max
```

## Troubleshooting

### Common Issues
```bash
# Container won't start
docker logs container_name
docker exec -it container_name sh

# Port already in use
docker ps -a
netstat -tulpn | grep :3000
lsof -i :3000

# Clean up Docker
docker system prune -f
docker volume prune -f
docker image prune -a -f

# Check container resource usage
docker stats
docker stats container_name

# Inspect container/image
docker inspect container_name
docker history image_name

# Copy files to/from container
docker cp file.txt container_name:/app/
docker cp container_name:/app/logs ./
```

### Performance Optimization
```dockerfile
# Use BuildKit
# syntax=docker/dockerfile:1

# Enable build cache mount
RUN --mount=type=cache,target=/var/cache/apt \
    apt-get update && apt-get install -y package

# Use secrets for sensitive data
RUN --mount=type=secret,id=api_key \
    API_KEY=$(cat /run/secrets/api_key) && \
    configure_app_with_key $API_KEY

# Parallel downloads
FROM alpine
RUN apk add --no-cache --virtual .build-deps \
        package1 \
        package2 \
    && process_packages \
    && apk del .build-deps
```

## Security Best Practices

1. **Use minimal base images** (alpine, distroless)
2. **Run as non-root user**
3. **Scan images for vulnerabilities**
4. **Use specific version tags**
5. **Keep base images updated**
6. **Limit container capabilities**
7. **Use secrets management**
8. **Enable Docker Content Trust**
9. **Network segmentation**
10. **Regular security audits**

## Integration with Claude Code

When working with Docker projects:
- Use the `patterns` agent for Docker best practices
- Use the `researcher` agent for container optimization
- Use the `principles` agent for security guidelines
- Use the `complete` agent for missing health checks
- Use the `docsync` agent for Docker documentation