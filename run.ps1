@echo off
# ==============================================================================
#  OPcalc project
#  Copyright (C) 2026 OPcalc project Contributors
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
# ==============================================================================

title OPcalc Runner

:: Move to the directory where this script is executed
cd /d "%~dp0"

:: 1. Check if the virtual environment exists
if not exist ".venv" (
    echo [ERROR] Virtual environment ^(.venv^) not found!
    echo Please run the install script first.
    pause
    exit /b 1
)

:: 2. Activate environment and launch the software cleanly without leaving a stray cmd prompt
echo Launching OPcalc...
call .venv\Scripts\activate.bat
start "" pythonw opcalc3.0.0.py
