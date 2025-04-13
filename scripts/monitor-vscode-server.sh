#!/bin/bash
# monitor-vscode-server.sh - Start VS Code Web Server with automatic restart monitoring

echo "Starting VS Code Web Server with automatic restart monitoring..."

start_server() {
  # Call the run script to start the server
  ./scripts/run-vscode-server.sh
}

# Initial server start
start_server

echo "VS Code Web Server monitor active. Will restart server if it stops."
echo "Press CTRL+C to stop monitoring."

# Monitor loop
while true; do
  sleep 60
  if ! docker ps | grep code-server > /dev/null; then
    echo "Container not found or stopped! Restarting VS Code Web Server..."
    start_server
  fi
done
