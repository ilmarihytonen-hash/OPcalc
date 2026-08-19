<#
==============================================================================
 OPcalc project
 Copyright (C) 2026 OPcalc project Contributors

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
==============================================================================
#>

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host " Starting OPcalc Installation..." -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

# 1. Check if Python is installed globally
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] Python was not found on this system!" -ForegroundColor Red
    Write-Host "Please install Python 3 from python.org and try again." -ForegroundColor Yellow
    Exit
}

# 2. Create local virtual environment
Write-Host "[1/4] Creating isolated Python virtual environment (.venv)..." -ForegroundColor Green
python -m venv .venv

# 3. Activate the environment and upgrade pip
Write-Host "[2/4] Activating virtual environment..." -ForegroundColor Green
.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip --quiet

# 4. Install SymPy
Write-Host "[3/4] Installing Python package dependencies via pip..." -ForegroundColor Green
pip install sympy

# 5. Create Windows Desktop Shortcut mapping to your .ico container asset
Write-Host "[4/4] Creating Desktop Shortcut..." -ForegroundColor Green
$TargetDir = Get-Location
$DesktopPath = [Environment]::GetFolderPath("Desktop")
$ShortcutPath = Join-Path $DesktopPath "OPcalc.lnk"

# Call Windows Shell COM object to compile the desktop item metadata
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = Join-Path $TargetDir "run.bat"
$Shortcut.WorkingDirectory = $TargetDir
$Shortcut.IconLocation = Join-Path $TargetDir "icon.ico"
$Shortcut.Description = "OPcalc - Symbolic Math Calculator"
$Shortcut.Save()

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host " OPcalc Installation Complete!" -ForegroundColor Cyan
Write-Host " A shortcut has been added to your Desktop." -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Cyan
