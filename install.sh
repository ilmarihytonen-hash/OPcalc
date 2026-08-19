#!/usr/bin/env bash
# ==============================================================================
#  OPcalc project
#  Copyright (C) 2026 OPcalc project Contributors
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
# ==============================================================================

set -e

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"
cd "$PROJECT_DIR"

echo "========================================="
echo " Starting OPcalc Installation..."
echo "========================================="

# 1. Install Debian system tools and python3-tk for your GUI window environment
echo "[1/5] Installing required system packages via apt..."
sudo apt update
sudo apt install -y python3 python3-pip python3-venv python3-tk

# 2. Create a project-specific virtual environment (.venv)
echo "[2/5] Creating isolated Python virtual environment (.venv)..."
python3 -m venv .venv

# 3. Activate the virtual environment and upgrade pip
echo "[3/5] Activating virtual environment..."
source .venv/bin/activate
pip install --upgrade pip --quiet

# 4. Install SymPy
echo "[4/5] Installing Python package dependencies via pip..."
pip install sympy

# 5. Create Desktop Shortcut for Linux / KDE Plasma
echo "[5/5] Creating Desktop Shortcut..."
DESKTOP_FILE="$HOME/Desktop/opcalc.desktop"

cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Version=3.0.0
Type=Application
Name=OPcalc
Comment=Symbolic Math Calculator
Exec=$PROJECT_DIR/run.sh
Icon=$PROJECT_DIR/icon.png
Terminal=false
Categories=Utility;Education;Science;Math;
EOF

# Grant execution rights so Plasma allows launching by double-clicking
chmod +x "$DESKTOP_FILE"

# Make the app searchable inside the global KDE Applications Launcher menu
mkdir -p "$HOME/.local/share/applications"
cp "$DESKTOP_FILE" "$HOME/.local/share/applications/"

echo "========================================="
echo " OPcalc Installation Complete!"
echo " A shortcut has been added to your Desktop."
echo "========================================="
