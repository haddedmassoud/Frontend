# Use the official Node.js 20 image as the base image
FROM node:20

# Set the working directory inside the container
WORKDIR /app

# Set ownership of the /app directory to the node user
RUN chown -R node:node /app

# Switch to root user for privileged operations
USER root

# Copy package.json and package-lock.json first
COPY ./package.json ./package-lock.json ./

# Install dependencies with root privileges
RUN npm install

# Copy the rest of the application code with ownership to the non-root user
COPY --chown=node:node . .

# Expose the port the app runs on
EXPOSE 3000

# Switch back to the non-root user for runtime
USER node

# Command to run the application
CMD ["npm", "run", "dev"]
