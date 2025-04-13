@echo off
setlocal EnableDelayedExpansion
echo Starting VS Code Web Server...

REM Check if CODE_SERVER_PASSWORD environment variable is set
set "GENERATED_PASSWORD="
if "%CODE_SERVER_PASSWORD%"=="" (
  REM Generate random password if not set (only numbers and letters)
  set "CHARS=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
  set "GENERATED_PASSWORD="
  for /L %%i in (1,1,12) do (
    set /a rand=!random! %% 62
    for /F %%j in ("!rand!") do set "GENERATED_PASSWORD=!GENERATED_PASSWORD!!CHARS:~%%j,1!"
  )
  set "CODE_SERVER_PASSWORD=!GENERATED_PASSWORD!"
  echo Generated random password: !GENERATED_PASSWORD!
)

REM Check if the container already exists and stop it properly if it does
docker ps -a | findstr code-server > nul
if %ERRORLEVEL% == 0 (
  echo Found existing code-server container, stopping it gracefully...
  docker compose -f vsc-web-docker-compose.yml down > nul 2>&1
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
