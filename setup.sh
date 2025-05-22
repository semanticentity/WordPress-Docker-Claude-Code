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

# Set up instance ID for port calculation
INSTANCE_ID=1
echo -e "\n${YELLOW}Configuring instance ID for multi-instance support...${NC}"
read -p "Enter an instance ID number (default: 1): " input_instance_id
if [ -n "$input_instance_id" ] && [[ "$input_instance_id" =~ ^[0-9]+$ ]]; then
    INSTANCE_ID=$input_instance_id
fi

# Calculate port offsets based on instance ID
PORT_OFFSET=$((($INSTANCE_ID - 1) * 10))
VS_CODE_PORT=$((8080 + $PORT_OFFSET))
WORDPRESS_PORT=$((8000 + $PORT_OFFSET))
PHPMYADMIN_PORT=$((8081 + $PORT_OFFSET))
MYSQL_PORT=$((13306 + $PORT_OFFSET))
DEV_PORT1=$((3000 + $PORT_OFFSET))
DEV_PORT2=$((9000 + $PORT_OFFSET))

# Create or update docker-compose override file with dynamic ports
cat > docker-compose.yml << EOF
services:
  # Development Environment with Claude Code and VS Code Server
  devenv:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: claude-wp-devenv${INSTANCE_ID}
    volumes:
      # Mount the host Docker socket to allow Docker in Docker
      - /var/run/docker.sock:/var/run/docker.sock
      # Mount the WordPress code directory
      - ./wordpress:/home/developer/wordpress
      # Mount any SSH keys (optional)
      - ~/.ssh:/home/developer/.ssh:ro
    ports:
      # VS Code Server port
      - "${VS_CODE_PORT}:8080"
      # Additional ports for development
      - "${DEV_PORT1}:3000"
      - "${DEV_PORT2}:9000"
    environment:
      - ANTHROPIC_API_KEY=\${ANTHROPIC_API_KEY}
      # Add any other required environment variables
    restart: unless-stopped
    depends_on:
      - db
      - wordpress
    networks:
      - wp-network

  # WordPress Container
  wordpress:
    image: wordpress:latest
    container_name: claude-wp-wordpress${INSTANCE_ID}
    volumes:
      # Mount WordPress content for direct editing
      - ./wordpress:/var/www/html
      # Custom wp-config
      - ./config/wp-config.php:/var/www/html/wp-config.php
      # Custom PHP configuration
      - ./config/php.ini:/usr/local/etc/php/conf.d/custom.ini
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
      WORDPRESS_DB_NAME: wordpress
      WORDPRESS_DEBUG: 1
    ports:
      - "${WORDPRESS_PORT}:80"
    depends_on:
      - db
    restart: unless-stopped
    networks:
      - wp-network
  
  # Database Container
  db:
    image: mysql:8.0
    container_name: claude-wp-db${INSTANCE_ID}
    command: --default-authentication-plugin=mysql_native_password
    volumes:
      - db_data${INSTANCE_ID}:/var/lib/mysql
      - ./config/mysql:/etc/mysql/conf.d
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress
    ports:
      - "${MYSQL_PORT}:3306"
    restart: unless-stopped
    networks:
      - wp-network
  
  # PhpMyAdmin (optional)
  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    container_name: claude-wp-phpmyadmin${INSTANCE_ID}
    environment:
      PMA_HOST: db
      PMA_PORT: 3306
    ports:
      - "${PHPMYADMIN_PORT}:80"
    depends_on:
      - db
    networks:
      - wp-network

# Persistent Volumes
volumes:
  db_data${INSTANCE_ID}:
    name: claude-wp-db-data${INSTANCE_ID}

# Docker Networks
networks:
  wp-network:
    name: claude-wp-network${INSTANCE_ID}
    driver: bridge
EOF

echo -e "${GREEN}Docker Compose configuration created with instance ID ${INSTANCE_ID}${NC}"
echo -e "VS Code will be available at port ${VS_CODE_PORT}"
echo -e "WordPress will be available at port ${WORDPRESS_PORT}"
echo -e "PhpMyAdmin will be available at port ${PHPMYADMIN_PORT}"

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
    echo -e "VS Code Server: ${GREEN}http://localhost:${VS_CODE_PORT}${NC}"
    echo -e "WordPress Site: ${GREEN}http://localhost:${WORDPRESS_PORT}${NC}"
    echo -e "PhpMyAdmin:    ${GREEN}http://localhost:${PHPMYADMIN_PORT}${NC}"
    
    echo -e "\n${BLUE}Usage Instructions:${NC}"
    echo -e "1. Access VS Code Server at ${GREEN}http://localhost:${VS_CODE_PORT}${NC}"
    echo -e "2. Open the terminal in VS Code and run: ${GREEN}claude${NC} to start Claude Code"
    echo -e "3. Your WordPress files are available at: ${GREEN}/home/developer/wordpress${NC}"
    echo -e "4. Database can be managed via PhpMyAdmin at ${GREEN}http://localhost:${PHPMYADMIN_PORT}${NC}"
    echo -e "   (Username: wordpress, Password: wordpress)"
    echo -e "5. To stop the environment, run: ${GREEN}docker-compose down${NC}"
    echo -e "6. To restart, run: ${GREEN}docker-compose up -d${NC}"
    
    echo -e "\n${YELLOW}Note: This instance is using ID ${INSTANCE_ID}. To run multiple instances,${NC}"
    echo -e "${YELLOW}run this script again in a different directory and choose a different ID.${NC}"
else
    echo -e "\n${RED}Failed to start the development environment.${NC}"
    echo -e "Please check the error messages above and try again."
fi
