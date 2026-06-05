#!/bin/bash
# Uninstaller for md2pdf-quick-action
set -euo pipefail

rm -f /usr/local/bin/m
rm -rf "$HOME/Library/Services/Make PDF.workflow"
/System/Library/CoreServices/pbs -update 2>/dev/null || true

echo "Removed m and the Make PDF Quick Action."
