#!/bin/bash
# Conky Manager Uninstallation Script

set -e

INSTALL_DIR="$HOME/.local/share/conky-manager"
BIN_DIR="$HOME/.local/bin"
SCRIPT_NAME="conky-manager"

echo "Uninstalling Conky Manager..."

# Remove installed files
rm -rf "$INSTALL_DIR"
rm -f "$BIN_DIR/$SCRIPT_NAME"
rm -f "/usr/local/bin/$SCRIPT_NAME" 2>/dev/null || true

# Remove from PATH in .bashrc (optional, commented out)
# sed -i '\|export PATH="$HOME/.local/bin:$PATH"|d' "$HOME/.bashrc"

echo "Uninstallation complete!"
