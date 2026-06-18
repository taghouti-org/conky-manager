#!/bin/bash
# Conky Manager Installation Script

set -e

INSTALL_DIR="$HOME/.local/share/conky-manager"
BIN_DIR="$HOME/.local/bin"
SCRIPT_NAME="conky-manager"

echo "Installing Conky Manager..."

# Create directories
mkdir -p "$INSTALL_DIR"
mkdir -p "$BIN_DIR"

# Copy script
cp "$(dirname "$0")/conky_manager.py" "$INSTALL_DIR/conky_manager.py"
chmod +x "$INSTALL_DIR/conky_manager.py"

# Create wrapper script in ~/.local/bin
cat > "$BIN_DIR/$SCRIPT_NAME" << 'EOF'
#!/bin/bash
exec python3 "$HOME/.local/share/conky-manager/conky_manager.py" "$@"
EOF
chmod +x "$BIN_DIR/$SCRIPT_NAME"

# Create symlink in /usr/local/bin (requires sudo)
if [ -w /usr/local/bin ]; then
    ln -sf "$BIN_DIR/$SCRIPT_NAME" "/usr/local/bin/$SCRIPT_NAME"
    echo "Symlink created: /usr/local/bin/$SCRIPT_NAME"
else
    echo "Note: Cannot create symlink in /usr/local/bin (permission denied)"
    echo "You can run it from: $BIN_DIR/$SCRIPT_NAME"
    echo "Or add $BIN_DIR to your PATH"
fi

# Add to PATH if not already there
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$HOME/.bashrc"
    echo "Added $BIN_DIR to PATH in .bashrc"
fi

echo ""
echo "Installation complete!"
echo ""
echo "You can now run: $SCRIPT_NAME"
echo "Or run directly: python3 $INSTALL_DIR/conky_manager.py"
