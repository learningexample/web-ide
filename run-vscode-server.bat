@echo off
echo Starting VS Code Web Server...
 

REM Check if the container already exists and remove it if it does
docker ps -a | findstr code-server > nul
if %ERRORLEVEL% == 0 (
  echo Found existing code-server container, removing it...
  docker rm -f code-server > nul 2>&1
)

REM Start the VS Code web server using Docker Compose
echo Starting code-server container...
docker compose -f vsc-web-docker-compose.yml up -d

REM Check if container started successfully
docker ps | findstr code-server > nul
if %ERRORLEVEL% == 0 (
  echo VS Code web server is now running!
  echo Access it at https://localhost:8443
  echo Default password is "PASSWORD" unless you've set CODE_SERVER_PASSWORD environment variable
) else (
  echo Failed to start VS Code web server. Please check docker logs for details.
)
