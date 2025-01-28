# Use the official Node.js 20 image as the base image
FROM node:20

# Set the working directory inside the container
WORKDIR /app

# Set ownership of the /app directory to the node user
RUN chown -R node:node /app

# Switch to the non-root user
USER node

# Copy package.json and package-lock.json first
COPY --chown=node:node ./package.json ./package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY --chown=node:node . .

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["npm", "run", "dev"]