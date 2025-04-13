@echo off
setlocal EnableDelayedExpansion

echo Starting VS Code Web Server with automatic restart monitoring...

:start_server
call run-vscode-server.bat

echo VS Code Web Server monitor active. Will restart server if it stops.
echo Press CTRL+C to stop monitoring.

:check_loop
timeout /t 60 /nobreak > nul
docker ps | findstr code-server > nul
if %ERRORLEVEL% NEQ 0 (
  echo Container not found or stopped! Restarting VS Code Web Server...
  goto start_server
)
goto check_loop
