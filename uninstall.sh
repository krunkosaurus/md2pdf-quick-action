#!/bin/bash
# Uninstaller for md2pdf-quick-action
set -euo pipefail

# Match install.sh: removing from a root-owned /usr/local/bin needs sudo
if [ ! -e /usr/local/bin/m ]; then
  : # nothing to remove
elif [ -w /usr/local/bin ]; then
  rm -f /usr/local/bin/m
else
  echo "/usr/local/bin is not writable; using sudo (you may be asked for your password)"
  sudo rm -f /usr/local/bin/m
fi
rm -rf "$HOME/Library/Services/Make PDF.workflow"
/System/Library/CoreServices/pbs -update 2>/dev/null || true

echo "Removed m and the Make PDF Quick Action."
