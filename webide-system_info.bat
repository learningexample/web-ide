@echo off
echo ======== System Information ========
echo Date and time: %date% %time%
echo Hostname: %computername%
echo Windows version:
ver
echo.

echo ======== OS Information ========
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"OS Manufacturer" /C:"OS Configuration" /C:"OS Build Type"
echo.

echo ======== Memory Usage ========
echo Total Physical Memory:
systeminfo | findstr /C:"Total Physical Memory"
echo Available Physical Memory:
systeminfo | findstr /C:"Available Physical Memory"
echo Virtual Memory: Max Size:
systeminfo | findstr /C:"Virtual Memory: Max Size"
echo Virtual Memory: Available:
systeminfo | findstr /C:"Virtual Memory: Available"
echo.

echo ======== Disk Usage ========
wmic logicaldisk get deviceid,volumename,size,freespace
echo.

echo ======== Docker Information ========
where docker >nul 2>&1
if %errorlevel% equ 0 (
    echo Docker version:
    docker --version
    echo Docker containers running:
    docker ps -q | find /c /v ""
    echo All Docker containers:
    docker ps -a -q | find /c /v ""
    echo Docker images:
    docker images -q | find /c /v ""
) else (
    echo Docker not installed or not in PATH
)
echo.

echo ======== CPU Information ========
echo Processor information:
wmic cpu get name, numberofcores, maxclockspeed
echo.

echo ======== Process Information ========
echo Top CPU-intensive processes:
wmic process get caption,commandline,ProcessId,ThreadCount /format:list | findstr /r /c:"^Caption" /c:"^CommandLine" /c:"^ProcessId" /c:"^ThreadCount" | sort
echo.
echo Memory usage by process:
tasklist /v
echo.

echo ======== Network Information ========
echo IP Configuration:
ipconfig /all
echo.
echo Network connections:
netstat -ano | findstr LISTENING
echo.

echo ======== Python Information ========
where python >nul 2>&1
if %errorlevel% equ 0 (
    echo Python version:
    python --version
    where pip >nul 2>&1
    if %errorlevel% equ 0 (
        echo Pip version:
        pip --version
        echo.
        echo Installed Python Packages:
        pip list
    ) else (
        echo pip not installed or not in PATH
    )
) else (
    echo Python not installed or not in PATH
)
echo.

echo ======== Node.js Information ========
where node >nul 2>&1
if %errorlevel% equ 0 (
    echo Node.js version:
    node --version
    where npm >nul 2>&1
    if %errorlevel% equ 0 (
        echo NPM version:
        npm --version
    ) else (
        echo npm not installed or not in PATH
    )
) else (
    echo Node.js not installed or not in PATH
)
echo.

echo ======== Environment Variables ========
echo User environment variables:
set
echo.

echo ======== System Uptime ========
net statistics workstation | find "Statistics since"
echo.

echo ======== File System Information ========
echo Drives and file systems:
wmic logicaldisk get caption,description,filesystem,volumename
echo.

echo System information report completed at %date% %time%
pause
