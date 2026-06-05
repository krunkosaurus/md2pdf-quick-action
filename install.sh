#!/bin/bash
# Installer for md2pdf-quick-action
# - Installs the `m` CLI to /usr/local/bin
# - Installs the "Make PDF" Finder Quick Action to ~/Library/Services
set -euo pipefail

cd "$(dirname "$0")"

# Check dependency
if ! command -v md-to-pdf >/dev/null 2>&1; then
  echo "md-to-pdf not found. Install it first:"
  echo "  npm install -g md-to-pdf"
  exit 1
fi

# Install the CLI
# Stock macOS (especially Apple Silicon) ships /usr/local/bin root-owned or
# missing entirely, so escalate for this one step when needed
BIN_DIR=/usr/local/bin
echo "Installing m -> $BIN_DIR/m"
if [ -d "$BIN_DIR" ] && [ -w "$BIN_DIR" ]; then
  install -m 755 bin/m "$BIN_DIR/m"
else
  echo "$BIN_DIR is not writable; using sudo (you may be asked for your password)"
  sudo mkdir -p "$BIN_DIR"
  sudo install -m 755 bin/m "$BIN_DIR/m"
fi

# Install the Quick Action
echo "Installing Quick Action -> ~/Library/Services/Make PDF.workflow"
mkdir -p "$HOME/Library/Services"
rm -rf "$HOME/Library/Services/Make PDF.workflow"
cp -R "quick-action/Make PDF.workflow" "$HOME/Library/Services/"

# Refresh the Services registry so it shows up without logout
/System/Library/CoreServices/pbs -update 2>/dev/null || true

echo ""
echo "Done! Right-click any .md file in Finder -> Quick Actions -> Make PDF"
echo "Or from the terminal: m file.md"
