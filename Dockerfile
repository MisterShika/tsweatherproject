# Use Node 22
FROM node:22

# Create a non-root user
RUN useradd -ms /bin/sh -u 1001 app

# Set working directory
WORKDIR /app

# Copy package.json first
COPY package.json package-lock.json* ./

# Ensure the app user owns these files
RUN chown -R app:app /app

# Switch to app user
USER app

# Install dependencies
RUN npm install

# Copy the rest of the source code and set ownership
COPY --chown=app:app . .

# Expose port
EXPOSE 3000

# Run Next.js dev server
CMD ["npm", "run", "dev"]
