FROM ubuntu:22.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Set up timezone
RUN apt-get update && apt-get install -y tzdata
ENV TZ=UTC

# Install essential packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    sudo \
    gnupg \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    build-essential \
    vim \
    nano \
    python3 \
    python3-pip \
    unzip \
    locales

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Set up locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install Docker CLI (to communicate with the host's Docker daemon)
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce-cli

# Install VS Code Server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Copy Claude Code installation script
COPY scripts/install-claude-code.sh /tmp/install-claude-code.sh
RUN chmod +x /tmp/install-claude-code.sh && /tmp/install-claude-code.sh

# Create a non-root user (developer)
RUN useradd -m -s /bin/bash developer && \
    echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set up VS Code extensions directory
RUN mkdir -p /home/developer/.local/share/code-server/extensions
RUN chown -R developer:developer /home/developer/.local

# Switch to the non-root user
USER developer
WORKDIR /home/developer

# Set up VS Code configuration
RUN mkdir -p /home/developer/.config/code-server
COPY config/code-server-config.yaml /home/developer/.config/code-server/config.yaml

# Setup basic Claude Code directory
RUN mkdir -p /home/developer/.claudecode

# Install VS Code extensions
RUN code-server --install-extension ms-vscode.vscode-typescript-next && \
    code-server --install-extension dbaeumer.vscode-eslint && \
    code-server --install-extension esbenp.prettier-vscode && \
    code-server --install-extension bmewburn.vscode-intelephense-client && \
    code-server --install-extension ecmel.vscode-html-css && \
    code-server --install-extension xdebug.php-debug

# Setup GitHub CLI (optional - can be configured later)
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && \
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
    sudo apt update && sudo apt install -y gh

# Expose ports for VS Code Server and other services
EXPOSE 8080 3000 8000

# Set environment variables
ENV PATH="/home/developer/.npm-global/bin:${PATH}"
ENV EDITOR=code-server

# Start VS Code Server
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none", "."]
