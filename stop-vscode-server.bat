@echo off
echo Stopping VS Code Web Server...

REM Check if the container exists
docker ps -a | findstr code-server > nul
if %ERRORLEVEL% == 0 (
  echo Found code-server container, stopping it...
  
  REM Stop the container using Docker Compose
  docker compose -f vsc-web-docker-compose.yml down
  
  echo VS Code web server has been stopped.
) else (
  echo No running code-server container found. Nothing to stop.
)

echo Done.
