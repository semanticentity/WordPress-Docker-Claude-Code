#!/bin/bash

# Deployment script for WordPress
# This script is intended to be run by a GitHub Actions workflow.

# Exit immediately if a command exits with a non-zero status.
set -e

# Server details from GitHub Secrets
SSH_HOST=$1
SSH_USER=$2
SSH_KEY=$3
REMOTE_PATH=$4

# Create a temporary file for the SSH key
SSH_KEY_FILE=$(mktemp)
echo "$SSH_KEY" > "$SSH_KEY_FILE"
chmod 600 "$SSH_KEY_FILE"

# Sync the WordPress files to the server
echo "Deploying to ${SSH_USER}@${SSH_HOST}:${REMOTE_PATH}"
rsync -avz --delete \
  -e "ssh -i $SSH_KEY_FILE -o StrictHostKeyChecking=no" \
  ./wordpress/ \
  "${SSH_USER}@${SSH_HOST}:${REMOTE_PATH}"

# Clean up the temporary SSH key file
rm -f "$SSH_KEY_FILE"

echo "Deployment finished successfully."
