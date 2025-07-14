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

## System Requirements

Before you dive in, make sure you have:

*   **Docker and Docker Compose:** These are the tools that make all this magic happen. If you don't have them, you can find installation instructions here: [Get Docker](https://docs.docker.com/get-docker/)
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

4.  **Start the environment:**
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

This project is just getting started. Here are some of the ideas we have for the future:

*   **Management Dashboard:** A web-based interface to manage all of your WordPress instances, like Local by Flywheel.
*   **Local Image Caching:** A local Docker registry to cache images and speed up the setup process.
*   **More Blueprints:** Pre-configured setups for common WordPress development scenarios (e.g., WooCommerce, a specific theme, etc.).
*   **Automated Deployments:** A more robust deployment system using GitHub Actions.

If you have any ideas, feel free to open an issue or a pull request!

## Troubleshooting

*   **"No space left on device" error:** This means your hard drive is full. You'll need to free up some space to run the environment.
*   **Port conflicts:** If you have other services running on ports 80, 443, or 8081, you can change the ports in the `docker-compose.yml` file.
*   **`npm test` fails:** Make sure your Docker environment is running (`docker compose up -d`).

## License

This project is released under the MIT License.
