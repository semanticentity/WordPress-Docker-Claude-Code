#!/bin/bash

# Claude WordPress Docker Development Environment Setup Script
# This script initializes and configures the development environment

# Color codes for terminal output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}===============================================${NC}"
echo -e "${BLUE}  Claude Code + WordPress Docker Setup Script  ${NC}"
echo -e "${BLUE}===============================================${NC}"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Error: Docker is not installed.${NC}"
    echo -e "Please install Docker and Docker Compose before running this script."
    echo -e "Visit https://docs.docker.com/get-docker/ for installation instructions."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}Error: Docker Compose is not installed.${NC}"
    echo -e "Please install Docker Compose before running this script."
    echo -e "Visit https://docs.docker.com/compose/install/ for installation instructions."
    exit 1
fi

# Create necessary directories
echo -e "\n${YELLOW}Creating necessary directories...${NC}"
mkdir -p wordpress
mkdir -p config/mysql

# Set up Anthropic API Key
echo -e "\n${YELLOW}Configuring Anthropic API Key...${NC}"
read -p "Enter your Anthropic API Key (or press Enter to skip for now): " anthropic_key

if [ -n "$anthropic_key" ]; then
    echo "ANTHROPIC_API_KEY=$anthropic_key" > .env
    echo -e "${GREEN}API key saved to .env file.${NC}"
else
    echo "ANTHROPIC_API_KEY=your_api_key_here" > .env
    echo -e "${YELLOW}No API key provided. You'll need to add it to the .env file before using Claude Code.${NC}"
fi

# Set permissions for the script directories
chmod -R 777 wordpress
chmod +x setup.sh

echo -e "\n${GREEN}Setup completed successfully!${NC}"
echo -e "\n${YELLOW}Starting the development environment...${NC}"
echo -e "This may take a few minutes for the first run as Docker images are downloaded and built."

# Force rebuild and start the environment
echo -e "\n${YELLOW}Forcing rebuild to avoid cached images...${NC}"
docker-compose build --no-cache
docker-compose up -d

# Check if containers started successfully
if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}Development environment started successfully!${NC}"
    echo -e "\n${BLUE}You can access the following services:${NC}"
    echo -e "VS Code Server: ${GREEN}http://localhost:8080${NC}"
    echo -e "WordPress Site: ${GREEN}http://localhost:8000${NC}"
    echo -e "PhpMyAdmin:    ${GREEN}http://localhost:8081${NC}"
    
    echo -e "\n${BLUE}Usage Instructions:${NC}"
    echo -e "1. Access VS Code Server at ${GREEN}http://localhost:8080${NC}"
    echo -e "2. Open the terminal in VS Code and run: ${GREEN}claude${NC} to start Claude Code"
    echo -e "3. Your WordPress files are available at: ${GREEN}/home/developer/wordpress${NC}"
    echo -e "4. Database can be managed via PhpMyAdmin at ${GREEN}http://localhost:8081${NC}"
    echo -e "   (Username: wordpress, Password: wordpress)"
    echo -e "5. To stop the environment, run: ${GREEN}docker-compose down${NC}"
    echo -e "6. To restart, run: ${GREEN}docker-compose up -d${NC}"
else
    echo -e "\n${RED}Failed to start the development environment.${NC}"
    echo -e "Please check the error messages above and try again."
fi
