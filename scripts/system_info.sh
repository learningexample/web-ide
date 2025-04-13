#!/bin/bash
# system_info.sh - Display system information for debugging

echo "======== System Information ========"
echo "Date and time: $(date)"
echo "Hostname: $(hostname)"
echo "Kernel: $(uname -r)"
echo "Architecture: $(uname -m)"
echo ""

echo "======== OS Information ========"
if [ -f /etc/os-release ]; then
    cat /etc/os-release | grep -E "^(NAME|VERSION)="
elif [ -f /etc/lsb-release ]; then
    cat /etc/lsb-release | grep -E "^(DISTRIB_DESCRIPTION|DISTRIB_RELEASE)="
else
    echo "OS information not available"
fi
echo ""

echo "======== Memory Usage ========"
free -h
echo ""

echo "======== Disk Usage ========"
df -h
echo ""

echo "======== Docker Information ========"
if command -v docker &> /dev/null; then
    echo "Docker version: $(docker --version)"
    echo "Docker containers running: $(docker ps -q | wc -l)"
    echo "All Docker containers: $(docker ps -a -q | wc -l)"
    echo "Docker images: $(docker images -q | wc -l)"
else
    echo "Docker not installed or not in PATH"
fi
echo ""

echo "======== CPU Information ========"
if [ -f /proc/cpuinfo ]; then
    grep -m1 "model name" /proc/cpuinfo
    grep -c "processor" /proc/cpuinfo | awk '{print "CPU cores: " $1}'
    grep -m1 "cpu MHz" /proc/cpuinfo
else
    echo "CPU information not available"
fi
echo ""

echo "======== Process Information ========"
echo "Top 5 CPU-intensive processes:"
ps aux --sort=-%cpu | head -6
echo ""
echo "Top 5 memory-intensive processes:"
ps aux --sort=-%mem | head -6
echo ""

echo "======== Network Information ========"
echo "IP addresses:"
ip addr show | grep -E "inet " | awk '{print $2}' | sed 's/\/.*//'
echo ""
echo "Network connections:"
netstat -tulpn | grep LISTEN
echo ""

echo "======== Python Information ========"
if command -v python3 &> /dev/null; then
    echo "Python version: $(python3 --version)"
    if command -v pip3 &> /dev/null; then
        echo "Pip version: $(pip3 --version)"
        echo ""
        echo "Installed Python Packages:"
        pip3 list
    else
        echo "pip3 not installed or not in PATH"
    fi
else
    echo "Python3 not installed or not in PATH"
fi
echo ""

echo "======== Node.js Information ========"
if command -v node &> /dev/null; then
    echo "Node.js version: $(node --version)"
    if command -v npm &> /dev/null; then
        echo "NPM version: $(npm --version)"
    else
        echo "npm not installed or not in PATH"
    fi
else
    echo "Node.js not installed or not in PATH"
fi
echo ""

echo "======== Environment Variables ========"
echo "USER: $USER"
echo "HOME: $HOME"
echo "PATH: $PATH"
echo ""
echo "All environment variables:"
env | sort
echo ""

echo "======== Last System Boot ========"
uptime
echo ""

echo "======== System Load ========"
cat /proc/loadavg
echo ""

echo "======== File System Information ========"
mount | grep -v tmpfs
echo ""

echo "System information report completed at $(date)"