@echo off
set POWERSHELL_SCRIPT_PATH=%CD%\WS.ps1

REM Display the current working directory
echo The current working directory is: %CD%

PowerShell -NoProfile -ExecutionPolicy Bypass -WindowStyle Maximized -File "%POWERSHELL_SCRIPT_PATH%"
exit
