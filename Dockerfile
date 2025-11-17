# Stage 1: Dependencies stage
FROM node:20.18.3-slim AS builder

# Create app directory
WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install dependencies (production only)
# Note: Using npm install since package-lock.json is not present in the repository
RUN npm install --only=production

# Stage 2: Production stage
FROM node:20.18.3-slim

# Install mariadb-client and cleanup in the same layer to minimize image size
RUN apt-get update && \
    apt-get install -y --no-install-recommends mariadb-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create app directory
WORKDIR /usr/src/app

# Copy node_modules from builder stage
COPY --from=builder /usr/src/app/node_modules ./node_modules

# Copy application code
COPY . .

# Set environment variables
ENV NODE_ENV=production \
    EGG_SERVER_ENV=prod

# Expose ports
EXPOSE 8443 8543 9190

# Start application
CMD ["npm", "run", "start:docker"]
