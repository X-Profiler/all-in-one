# syntax=docker/dockerfile:1.4
# =============================================================================
# Stage 1: Build Stage
# =============================================================================
FROM node:20-alpine AS builder

# Install git for GitHub dependencies
RUN apk add --no-cache git

WORKDIR /usr/src/app

# Copy package files first for better layer caching
COPY package.json ./

# Install production dependencies only
# Using cache mount to speed up builds (BuildKit feature)
RUN --mount=type=cache,target=/root/.npm \
    npm install --registry=https://registry.npmmirror.com --omit=dev

# Copy application source (only necessary files)
COPY app.js index.js ./
COPY config/ ./config/
COPY lib/ ./lib/
COPY scripts/ ./scripts/

# =============================================================================
# Stage 2: Production Stage
# =============================================================================
FROM node:20-alpine AS production

# Install MySQL client for init_db.sh script
# Combined with cleanup in single layer (layer optimization)
RUN apk add --no-cache mysql-client

# Create app directory
WORKDIR /usr/src/app

# Copy built application from builder stage
COPY --from=builder /usr/src/app ./

# Set environment variables
ENV NODE_ENV=production \
    EGG_SERVER_ENV=prod

# Expose application ports
EXPOSE 8443 8543 9190

# Start the application
CMD ["npm", "run", "start:docker"]
