@echo off
REM Claude Code installer wrapper for Windows CMD.
REM Downloads and runs the official installer from claude.ai.
REM Use this if you are stuck in cmd.exe instead of PowerShell.

setlocal

echo ==^> Downloading the official Claude Code installer...
curl -fsSL https://claude.ai/install.cmd -o "%TEMP%\claude-install.cmd"
if errorlevel 1 (
    echo Failed to download installer. Check your network connection.
    exit /b 1
)

echo ==^> Running installer...
call "%TEMP%\claude-install.cmd"
set INSTALL_EXIT=%ERRORLEVEL%
del "%TEMP%\claude-install.cmd" >nul 2>&1

if not "%INSTALL_EXIT%"=="0" (
    echo Installer exited with code %INSTALL_EXIT%.
    exit /b %INSTALL_EXIT%
)

echo.
echo Install complete. Open a NEW terminal window, then verify with:
echo   claude --version
echo   claude doctor
echo.
echo If 'claude' is not recognized, add %USERPROFILE%\.local\bin to your PATH.

endlocal
