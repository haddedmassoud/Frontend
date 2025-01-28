# Use the official Node.js 20 image as the base image
FROM node:20

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Set file permissions and ownership
RUN chmod 644 /app/vite.config.ts && \
    chown node:node /app/vite.config.ts && \
    chown -R node:node /app/node_modules

# Expose the port the app runs on
EXPOSE 3000

# Switch to non-root user
USER node

# Command to run the application
CMD ["npm", "run", "dev"]