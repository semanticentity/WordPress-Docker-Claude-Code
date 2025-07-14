# Claude Code + WordPress Docker Development Environment

Hey there, future coding wizard! Welcome to your new favorite WordPress development environment. We've cooked up something special to make your life easier, combining the power of Docker with the magic of Anthropic's Claude Code.

This setup gives you a complete, isolated development environment that you can spin up and tear down with just a few commands. No more messing with local server configurations!

## What's Inside?

*   **A full-fledged IDE in your browser:** We're using VS Code Server, so you get a familiar, powerful coding experience.
*   **The latest and greatest WordPress:** A fresh installation is ready for you to start building.
*   **Claude Code on demand:** Get help from your AI coding partner right in the terminal.
*   **Local HTTPS:** Develop with a secure connection, just like in production.
*   **Easy testing:** Run your plugin's tests with a single command.
*   **Multi-instance support:** Run multiple, separate WordPress sites at the same time.

## Prerequisites

Before you can use this environment, you'll need to have a few tools installed on your computer. Don't worry, we'll walk you through it.

### Docker and Docker Compose

This is the core of our setup. It's a tool that lets us run our development environment in a "container," which is like a lightweight virtual machine.

*   **On macOS:** The easiest way to get Docker and Docker Compose is to install [Docker Desktop for Mac](https://docs.docker.com/desktop/mac/install/).
*   **On Windows:** You'll want to install [Docker Desktop for Windows](https://docs.docker.com/desktop/windows/install/).
*   **On Linux:** You can follow the official instructions to install the [Docker Engine](https://docs.docker.com/engine/install/) and the [Docker Compose plugin](https://docs.docker.com/compose/install/).

### Node.js and npm

We use `npm` to run our testing script. `npm` comes bundled with Node.js.

*   **On macOS and Windows:** The easiest way to install Node.js and `npm` is to download the installer from the [official Node.js website](https://nodejs.org/).
*   **On Linux:** You can use your distribution's package manager to install Node.js and `npm`. For example, on Ubuntu, you would run `sudo apt update && sudo apt install nodejs npm`.

## System Requirements

*   **At least 10GB of free disk space:** This is important! The Docker images can be chunky.
*   **An Anthropic API key:** You'll need this to use Claude Code.

## Quick Start

1.  **Clone this repository:**
    ```bash
    git clone https://github.com/IncomeStreamSurfer/WordPress-Docker-Claude-Code.git
    cd WordPress-Docker-Claude-Code
    ```

2.  **Run the setup script:**
    ```bash
    bash setup.sh
    ```
    This will ask you for an instance ID (you can just press Enter to use the default) and your Anthropic API key.

3.  **Generate your local SSL certificates:**
    ```bash
    bash scripts/generate-certs.sh
    ```
    You only need to do this once. This will create a `config/certs` directory with your SSL certificates.

4.  **Install the npm dependencies:**
    ```bash
    npm install
    ```

5.  **Start the environment:**
    ```bash
    docker compose up -d
    ```

That's it! Your environment is up and running.

## How to Use Your New Environment

*   **VS Code Server:** [https://localhost](https://localhost)
*   **WordPress Site:** [https://localhost](https://localhost)
*   **PhpMyAdmin:** [http://localhost:8081](http://localhost:8081) (or whatever port was assigned during setup)

### Working with Your Code

All of your WordPress files are in the `wordpress` directory. Any changes you make there will be instantly reflected in your running WordPress site.

### Running Tests

We've set up a super simple way to run your plugin's tests. Just run this command in your terminal:

```bash
npm test
```

This will run the PHPUnit tests for the `hello` plugin. You can use this as a starting point for your own tests.

### Stopping the Environment

When you're done for the day, you can stop the environment with this command:

```bash
docker compose down
```

## Roadmap

This project is just getting started. We have a lot of ideas for making it even better. We're calling these our "graceful DX love bombs" because we want to make the developer experience as delightful as possible.

*   **Smarter Setup Script:** An enhanced `setup.sh` that can detect if prerequisites are missing and offer to install them for the user.
*   **Management Dashboard:** A web-based interface to manage all of your WordPress instances, like Local by Flywheel.
*   **Local Image Caching:** A local Docker registry to cache images and speed up the setup process, reducing the need to re-download images.
*   **More Blueprints:** Pre-configured setups for common WordPress development scenarios (e.g., WooCommerce, a specific theme, etc.).
*   **Automated Deployments:** A more robust deployment system using GitHub Actions.

If you have any ideas, feel free to open an issue or a pull request!

## Troubleshooting

*   **"No space left on device" error:** This means your hard drive is full. You'll need to free up some space to run the environment.
*   **Port conflicts:** If you have other services running on ports 80, 443, or 8081, you can change the ports in the `docker-compose.yml` file.
*   **`npm test` fails:** Make sure your Docker environment is running (`docker compose up -d`).

## License

This project is released under the MIT License.
