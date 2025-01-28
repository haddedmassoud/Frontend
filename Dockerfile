# Use the official Node.js 20 image as the base image
FROM node:20

# Create a non-root user with a flexible UID range
RUN useradd -u 1001 -m appuser

# Set the working directory inside the container
WORKDIR /app

# Set ownership of the /app directory to the non-root user
RUN chown -R appuser:appuser /app

# Copy package.json and package-lock.json first
COPY --chown=appuser:appuser ./package.json ./package-lock.json ./

# Install dependencies as the non-root user
USER appuser
RUN npm install

# Copy the rest of the application code with ownership to the non-root user
COPY --chown=appuser:appuser . .

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["npm", "run", "dev"]