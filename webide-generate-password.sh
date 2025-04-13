#!/bin/bash

# Generate random passwords
CODE_SERVER_PASSWORD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16 | base64)
CODE_SERVER_SUDO_PASSWORD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16 | base64)

# Show the generated passwords to the user
echo "Generated new passwords:"
echo "CODE_SERVER_PASSWORD: $CODE_SERVER_PASSWORD"
echo "CODE_SERVER_SUDO_PASSWORD: $CODE_SERVER_SUDO_PASSWORD"

# Store passwords in a local .env file
echo "CODE_SERVER_PASSWORD=$CODE_SERVER_PASSWORD" > .env
echo "CODE_SERVER_SUDO_PASSWORD=$CODE_SERVER_SUDO_PASSWORD" >> .env

echo "Passwords saved to .env file"
echo "You can now run docker-compose with these passwords"

# Export the passwords as environment variables for the current session
export CODE_SERVER_PASSWORD
export CODE_SERVER_SUDO_PASSWORD
