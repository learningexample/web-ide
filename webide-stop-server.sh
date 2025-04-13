#!/bin/bash
# stop-vscode-server.sh - Stop VS Code Web Server on Linux

echo "Stopping VS Code Web Server..."

# Check if the container exists
if docker ps -a | grep code-server > /dev/null; then
  echo "Found code-server container, stopping it..."
  
  # Stop the container using Docker Compose
  docker compose -f webide-docker-compose.yml down
  
  echo "VS Code web server has been stopped."
else
  echo "No running code-server container found. Nothing to stop."
fi

echo "Done."
