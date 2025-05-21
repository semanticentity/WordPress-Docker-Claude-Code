# Claude Code + WordPress Docker Development Environment

This project provides a complete development environment that combines:
- **Claude Code** - Anthropic's agentic coding assistant
- **VS Code Server** - Web-based VS Code IDE
- **WordPress** - Fresh WordPress installation for development
- **Remote accessibility** - Accessible from any device with a web browser

## System Requirements

- **Docker** and **Docker Compose**
- At least 4GB of free RAM
- At least 10GB of free disk space
- An Anthropic API key (for Claude Code)

## Quick Start

1. Clone this repository:
   ```bash
   git clone https://github.com/IncomeStreamSurfer/WordPress-Docker-Claude-Code.git
   cd WordPress-Docker-Claude-Code
   ```

2. Run the setup script:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

3. Follow the prompts to configure your environment
   - Enter your Anthropic API key when prompted

4. Once setup completes, access the environment:
   - VS Code Server: http://localhost:8080
   - WordPress Site: http://localhost:8000
   - PhpMyAdmin: http://localhost:8081

## Features

### Development Environment

- **Ubuntu 22.04** base with all necessary development tools
- **VS Code Server** with pre-installed extensions for web development
- **Claude Code** CLI pre-installed and configured
- **GitHub CLI** for easy repository management
- **Docker CLI** for container management from within the environment

### WordPress Setup

- **Latest WordPress** installation
- **MySQL 8.0** database
- **PhpMyAdmin** for database management
- **PHP configuration** optimized for development
- **Xdebug** for debugging PHP code

### Claude Code

- **Claude Code CLI** pre-installed and configured to work properly
- **Custom installation script** to prevent common setup issues
- **Error handling wrapper** to ensure smooth operation

## Directory Structure

```
claude-wp-docker/
├── config/                # Configuration files
│   ├── code-server-config.yaml  # VS Code Server configuration
│   ├── mysql/             # MySQL configuration
│   ├── php.ini            # PHP configuration
│   └── wp-config.php      # WordPress configuration
├── scripts/               # Script files
│   └── install-claude-code.sh   # Claude Code installation script
├── wordpress/             # WordPress files (mounted into container)
├── Dockerfile             # Development environment definition
├── docker-compose.yml     # Service definitions
├── setup.sh               # Setup script
└── README.md              # This file
```

## Usage Guide

### Starting Claude Code

1. Access the VS Code Server at http://localhost:8080
2. Open a terminal in VS Code
3. Type `claude` to start Claude Code
4. Follow the authentication prompts if needed

### Working with WordPress

All WordPress files are available in the `/home/developer/wordpress` directory inside the container. Changes to these files will be reflected immediately on the WordPress site.

To access WordPress admin:
1. Visit http://localhost:8000/wp-admin
2. Default credentials are:
   - Username: `admin`
   - Password: `password`
   (You should change these immediately in a production environment)


### Managing the Environment

- **Start environment**: `docker-compose up -d`
- **Stop environment**: `docker-compose down`
- **View logs**: `docker-compose logs -f`
- **Rebuild containers**: `docker-compose build --no-cache`

## Customization

### Adding WordPress Plugins/Themes

You can install plugins and themes directly through the WordPress admin interface, or by adding files to the appropriate directories in `wordpress/wp-content/`.

## Troubleshooting

### Common Issues

1. **Can't access VS Code Server**:
   - Check if the container is running: `docker ps`
   - Check logs: `docker logs claude-wp-devenv`

2. **Claude Code authentication fails**:
   - Ensure your Anthropic API key is correctly set in the `.env` file
   - Restart the container: `docker-compose restart devenv`

3. **WordPress database connection error**:
   - Check if the database container is running: `docker ps`
   - Check database logs: `docker logs claude-wp-db`

4. **Port conflicts**:
   - If you have services already using ports 8000, 8080, 8081, or 13306, modify the port mappings in `docker-compose.yml`
   - MySQL port is exposed on 13306 instead of the default 3306 to avoid conflicts

## License

This project is released under the MIT License.

## Acknowledgements

- [Anthropic](https://www.anthropic.com/) for Claude and Claude Code
- [WordPress](https://wordpress.org/) for the CMS
- [Docker](https://www.docker.com/) for containerization
- [VS Code](https://code.visualstudio.com/) for the IDE
