#!/bin/bash

# This script generates SSL certificates for local development.

# Exit immediately if a command exits with a non-zero status.
set -e

# Create a directory for the certificates
mkdir -p config/certs

# Generate the certificates
mkcert -key-file config/certs/localhost-key.pem -cert-file config/certs/localhost.pem "localhost" "127.0.0.1" "::1"
