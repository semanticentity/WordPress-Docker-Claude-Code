#!/bin/bash

# Script to install Claude Code following official documentation
set -e

echo "Installing Claude Code..."

# Make sure we're using Node.js 18+
NODE_VERSION=$(node -v)
if [[ ! $NODE_VERSION =~ ^v18 && ! $NODE_VERSION =~ ^v[2-9][0-9] ]]; then
    echo "Error: Node.js 18+ is required. Current version: $NODE_VERSION"
    exit 1
fi

# Configure npm for Linux environment (helps with WSL issues)
npm config set os linux

# Install Claude Code globally with --force and --no-os-check flags
echo "Installing @anthropic-ai/claude-code globally..."
npm install -g @anthropic-ai/claude-code --force --no-os-check

# Create a simple wrapper script
echo "Creating Claude Code wrapper..."
cat > /usr/local/bin/claude-wrapper << 'EOF'
#!/bin/bash

# Set environment variable to disable MCP functionality
export CLAUDE_DISABLE_MCP=true

# Create empty config.json if it doesn't exist
mkdir -p ~/.claudecode
if [ ! -f ~/.claudecode/config.json ]; then
  echo '{
    "servers": [],
    "settings": {
      "defaultTerminal": "bash",
      "autoStartEnabled": false,
      "loggingEnabled": false
    }
  }' > ~/.claudecode/config.json
fi

# Run claude with any passed arguments
/usr/local/bin/claude "$@"
EOF

# Make the wrapper executable
chmod +x /usr/local/bin/claude-wrapper

# Create an alias
echo 'alias claude="claude-wrapper"' >> ~/.bashrc

echo "Claude Code installation completed successfully!"
echo "Please restart your shell or run 'source ~/.bashrc' to use the 'claude' command"
