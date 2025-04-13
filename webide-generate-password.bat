@echo off
setlocal EnableDelayedExpansion

:: Generate random passwords using PowerShell
FOR /F "tokens=*" %%a in ('powershell -Command "[System.Convert]::ToBase64String([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(12))"') do (
    set CODE_SERVER_PASSWORD=%%a
)

FOR /F "tokens=*" %%a in ('powershell -Command "[System.Convert]::ToBase64String([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(12))"') do (
    set CODE_SERVER_SUDO_PASSWORD=%%a
)

:: Show the generated passwords to the user
echo Generated new passwords:
echo CODE_SERVER_PASSWORD: !CODE_SERVER_PASSWORD!
echo CODE_SERVER_SUDO_PASSWORD: !CODE_SERVER_SUDO_PASSWORD!

:: Store passwords in a local .env file
echo CODE_SERVER_PASSWORD=!CODE_SERVER_PASSWORD!> .env
echo CODE_SERVER_SUDO_PASSWORD=!CODE_SERVER_SUDO_PASSWORD!>> .env

echo Passwords saved to .env file
echo You can now run docker-compose with these passwords

:: Set environment variables for the current session
set CODE_SERVER_PASSWORD=!CODE_SERVER_PASSWORD!
set CODE_SERVER_SUDO_PASSWORD=!CODE_SERVER_SUDO_PASSWORD!

endlocal & (
    set "CODE_SERVER_PASSWORD=%CODE_SERVER_PASSWORD%"
    set "CODE_SERVER_SUDO_PASSWORD=%CODE_SERVER_SUDO_PASSWORD%"
)
