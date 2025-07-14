#!/bin/bash

# This script is used to deploy the database from the local environment to the Cloudways server.

# Exit immediately if a command exits with a non-zero status.
set -e

# Variables
LOCAL_DB_EXPORT_PATH="/tmp/local.sql"
REMOTE_SSH_HOST="your_ssh_host"
REMOTE_SSH_USER="your_ssh_user"
REMOTE_DB_IMPORT_PATH="/tmp/remote.sql"
REMOTE_WP_PATH="your_remote_wp_path"

# Export the local database
echo "Exporting local database..."
wp db export $LOCAL_DB_EXPORT_PATH --allow-root

# Transfer the database to the remote server
echo "Transferring database to remote server..."
scp $LOCAL_DB_EXPORT_PATH $REMOTE_SSH_USER@$REMOTE_SSH_HOST:$REMOTE_DB_IMPORT_PATH

# Import the database on the remote server
echo "Importing database on remote server..."
ssh $REMOTE_SSH_USER@$REMOTE_SSH_HOST "cd $REMOTE_WP_PATH && wp db import $REMOTE_DB_IMPORT_PATH"

# Clean up local and remote files
echo "Cleaning up..."
rm $LOCAL_DB_EXPORT_PATH
ssh $REMOTE_SSH_USER@$REMOTE_SSH_HOST "rm $REMOTE_DB_IMPORT_PATH"

echo "Database migration complete."
