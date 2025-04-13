# Web IDE

A containerized Visual Studio Code web server environment using Docker and code-server.

## Overview

This project provides a ready-to-use web-based VS Code development environment that runs in a Docker container. Access your development environment from any browser without installing VS Code locally.

## Features

- Browser-based VS Code editor
- Persistent configuration and extensions
- Automatic container restart monitoring
- Parent directory mounted as workspace
- Secure password access

## File Structure

```
web-ide/
├── README.md                         # This documentation
├── webide-Dockerfile.custom          # Custom Docker image configuration
├── webide-docker-compose.yml         # Docker Compose configuration
├── code-server-data/                 # Persistent data directory
│   └── config/                       # VS Code configuration files
├── webide-generate-password.bat      # Windows script to generate secure passwords
├── webide-generate-password.sh       # Linux/Mac script to generate secure passwords
├── webide-run-server.bat             # Windows script to start the server
├── webide-run-server.sh              # Linux/Mac script to start the server
├── webide-stop-server.bat            # Windows script to stop the server
├── webide-stop-server.sh             # Linux/Mac script to stop the server
└── webide-system_info.sh             # Script to display system information
```

## Getting Started

### Prerequisites

- Docker installed on your system
- Docker Compose installed on your system

### Running the Web IDE

#### Windows

1. Double-click `webide-generate-password.bat` to generate secure passwords
2. Double-click `webide-run-server.bat` to start the server
3. Access the IDE at https://localhost:8443
4. Use the password displayed when you ran the generate password script

#### Linux/Mac

1. Make the scripts executable: `chmod +x webide-*.sh`
2. Run `./webide-generate-password.sh` to generate secure passwords
3. Run `./webide-run-server.sh` to start the server
4. Access the IDE at https://localhost:8443
5. Use the password displayed when you ran the generate password script

### Workspace Access

The parent directory of this project is mounted as the `/workspace` directory in the container. This means you can access and edit all files in the parent directory through the web IDE.

### Stopping the Web IDE

- Windows: Run `web-ide-stop-vscode-server.bat`
- Linux/Mac: Run `./web-ide-stop-vscode-server.sh`

### Automatic Monitoring

To automatically restart the server if it crashes:

- Windows: Run `web-ide-monitor-vscode-server.bat`
- Linux/Mac: Run `./web-ide-monitor-vscode-server.sh`

## Customizing

- Edit `web-ide-vsc-web-docker-compose.yml` to change port mappings or environment variables
- Modify `web-ide-Dockerfile.custom-vscode` to install additional tools or dependencies
- Environment variables:
  - `CODE_SERVER_PASSWORD`: Set a custom password
  - `SUDO_PASSWORD`: Set the sudo password for container access

## Workspace

The parent directory of this project is mounted as the workspace in VS Code.
All files in the parent directory will be available for editing in the web IDE.