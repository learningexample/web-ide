#!/bin/bash
# run-vscode-server.sh - Start VS Code Web Server on Linux

echo "Starting VS Code Web Server..."

# Check if CODE_SERVER_PASSWORD environment variable is set
if [ -z "$CODE_SERVER_PASSWORD" ]; then
  # Generate random password if not set (only numbers and letters)
  GENERATED_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
  export CODE_SERVER_PASSWORD="$GENERATED_PASSWORD"
  echo "Generated random password: $GENERATED_PASSWORD"
fi

# Check if the container already exists and stop it properly if it does
if docker ps -a | grep code-server > /dev/null; then
  echo "Found existing code-server container, stopping it gracefully..."
  docker compose -f webide-docker-compose.yml down > /dev/null 2>&1
fi

# Start the VS Code web server using Docker Compose
echo "Starting code-server container..."
docker compose -f webide-docker-compose.yml up -d

# Check if container started successfully
if docker ps | grep code-server > /dev/null; then
  echo "VS Code web server is now running!"
  echo "Access it at https://localhost:8443"
  echo "Default password is \"PASSWORD\" unless you've set CODE_SERVER_PASSWORD environment variable"
else
  echo "Failed to start VS Code web server. Please check docker logs for details."
fi
