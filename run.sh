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

# Find the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# 1. Fallback for Xwayland/Plasma systems if DISPLAY variable is missing
if [ -z "$DISPLAY" ]; then
    export DISPLAY=:0
fi

# 2. Check if the virtual environment exists
if [ ! -d ".venv" ]; then
    echo "[ERROR] Virtual environment (.venv) not found!"
    echo "Please run ./install.sh first."
    exit 1
fi

# 3. Activate environment and launch the software
echo "Launching OPcalc..."
source .venv/bin/activate
python opcalc3.0.0.py