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
├── web-ide-Dockerfile.custom-vscode  # Custom Docker image configuration
├── web-ide-vsc-web-docker-compose.yml # Docker Compose configuration
├── code-server-data/                 # Persistent data directory
│   └── config/                       # VS Code configuration files
├── web-ide-run-vscode-server.bat     # Windows script to start the server
├── web-ide-run-vscode-server.sh      # Linux/Mac script to start the server
├── web-ide-stop-vscode-server.bat    # Windows script to stop the server
├── web-ide-stop-vscode-server.sh     # Linux/Mac script to stop the server
├── web-ide-monitor-vscode-server.bat # Windows script for auto-restart monitoring
├── web-ide-monitor-vscode-server.sh  # Linux/Mac script for auto-restart monitoring
├── web-ide-system_info.sh            # Script to display system information
└── web-ide-update_container.sh       # Script to update the container image
```

## Getting Started

### Prerequisites

- Docker installed on your system
- Docker Compose installed on your system

### Running the Web IDE

#### Windows

1. Double-click `web-ide-run-vscode-server.bat` to start the server
2. Access the IDE at https://localhost:8443
3. Use the password displayed in the terminal (or "PASSWORD" if not changed)

#### Linux/Mac

1. Make the scripts executable: `chmod +x web-ide-*.sh`
2. Run `./web-ide-run-vscode-server.sh` to start the server
3. Access the IDE at https://localhost:8443
4. Use the password displayed in the terminal (or "PASSWORD" if not changed)

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