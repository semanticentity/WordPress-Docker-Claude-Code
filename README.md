# WordPress Docker Development Environment with Claude Code

This project provides a comprehensive, Docker-based development environment for WordPress. It includes a VS Code Server with Claude Code integration, enabling a powerful and efficient development workflow.

The environment is designed to be self-contained and reproducible, minimizing the need for complex local machine configuration.

## Features

*   **Integrated Development Environment:** VS Code Server provides a web-based IDE with pre-installed extensions for PHP and web development.
*   **WordPress Ready:** Includes the latest version of WordPress, a MySQL database, and PhpMyAdmin for database management.
*   **AI-Assisted Development:** Pre-configured with Anthropic's Claude Code for AI-powered code generation and assistance.
*   **Local HTTPS:** Supports local HTTPS using `mkcert` for a production-like development environment.
*   **Automated Testing:** Includes a pre-configured PHPUnit testing environment for plugin development.
*   **Multi-Instance Support:** Allows for running multiple, isolated WordPress instances simultaneously.

## Prerequisites

The following software must be installed on your host machine:

*   **Docker and Docker Compose:** The foundation of the containerized environment.
    *   **macOS:** [Docker Desktop for Mac](https://docs.docker.com/desktop/mac/install/)
    *   **Windows:** [Docker Desktop for Windows](https://docs.docker.com/desktop/windows/install/)
    *   **Linux:** [Docker Engine](https://docs.docker.com/engine/install/) and [Docker Compose plugin](https://docs.docker.com/compose/install/)
*   **Node.js and npm:** Used for running utility scripts.
    *   **macOS and Windows:** [Node.js Installer](https://nodejs.org/)
    *   **Linux:** `sudo apt update && sudo apt install nodejs npm` (or equivalent for your distribution).

## System Requirements

*   **Disk Space:** A minimum of 10GB of free disk space is recommended.
*   **API Key:** An Anthropic API key is required for Claude Code functionality.

## Getting Started

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/IncomeStreamSurfer/WordPress-Docker-Claude-Code.git
    cd WordPress-Docker-Claude-Code
    ```

2.  **Run the setup script:**
    ```bash
    bash setup.sh
    ```
    This script will prompt for an instance ID and your Anthropic API key.

3.  **Generate SSL certificates:**
    ```bash
    bash scripts/generate-certs.sh
    ```
    This one-time command creates the necessary SSL certificates for local HTTPS.

4.  **Install npm dependencies:**
    ```bash
    npm install
    ```

5.  **Start the environment:**
    ```bash
    docker compose up -d
    ```

The environment is now running.

## Accessing the Environment

*   **VS Code Server:** [https://localhost](https://localhost)
*   **WordPress Site:** [https://localhost](https://localhost)
*   **PhpMyAdmin:** [http://localhost:8081](http://localhost:8081) (port may vary based on instance ID).

## Development Workflow

### Code Editing

The `wordpress` directory is mounted into the WordPress container. Any changes made to these files on the host machine will be immediately reflected in the running application.

### Running Tests

To run the PHPUnit tests for the included `hello` plugin, execute the following command:

```bash
npm test
```

This provides a template for setting up tests for your own plugins.

### Stopping the Environment

To stop the Docker containers, run:

```bash
docker compose down
```

## Project Roadmap

This project is under active development. Future enhancements include:

*   **Enhanced Setup Script:** A more robust setup script that can detect and install missing prerequisites.
*   **Management Dashboard:** A web-based UI for managing multiple WordPress instances.
*   **Local Image Caching:** A local Docker registry to improve setup times and reduce bandwidth usage.
*   **Development Blueprints:** Pre-configured environments for specific development scenarios (e.g., WooCommerce, specific themes).
*   **CI/CD Integration:** Automated deployment pipelines using GitHub Actions.

Contributions and suggestions are welcome.

## Troubleshooting

*   **"No space left on device" error:** This indicates insufficient disk space on the host machine.
*   **Port conflicts:** If another service is using a required port, modify the port mappings in the `docker-compose.yml` file.
*   **`npm test` fails:** Ensure the Docker environment is running (`docker compose up -d`).

## License

This project is licensed under the MIT License.
