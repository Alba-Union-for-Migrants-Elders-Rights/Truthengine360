# Claude Code installer wrapper for Windows PowerShell.
#
# Runs the official installer from claude.ai, then ensures the install
# directory is on PATH so `claude` works in new terminals without manual
# fixes. No admin rights required.
#
# Usage:
#   irm https://raw.githubusercontent.com/<org>/<repo>/main/install.ps1 | iex
# or after cloning:
#   .\install.ps1

$ErrorActionPreference = 'Stop'

Write-Host "==> Downloading and running the official Claude Code installer..."
irm https://claude.ai/install.ps1 | iex

$installDir = Join-Path $env:USERPROFILE '.local\bin'

if (-not (Test-Path $installDir)) {
    Write-Warning "Expected install directory not found: $installDir"
    Write-Warning "The installer may have placed claude elsewhere. Run 'where.exe claude' to locate it."
    return
}

$userPath = [Environment]::GetEnvironmentVariable('PATH', [EnvironmentVariableTarget]::User)
if (-not $userPath -or ($userPath -split ';' -notcontains $installDir)) {
    Write-Host "==> Adding $installDir to your user PATH (persistent)..."
    $newPath = if ([string]::IsNullOrEmpty($userPath)) { $installDir } else { "$userPath;$installDir" }
    [Environment]::SetEnvironmentVariable('PATH', $newPath, [EnvironmentVariableTarget]::User)
} else {
    Write-Host "==> $installDir already on user PATH."
}

if (($env:PATH -split ';') -notcontains $installDir) {
    $env:PATH = "$env:PATH;$installDir"
    Write-Host "==> Updated PATH for the current session."
}

Write-Host ""
Write-Host "Install complete. Verify with:"
Write-Host "  claude --version"
Write-Host "  claude doctor"
Write-Host ""
Write-Host "Open a fresh PowerShell window if 'claude' is not recognized."
