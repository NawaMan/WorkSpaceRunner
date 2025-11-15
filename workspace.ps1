#!/usr/bin/env pwsh

# A PowerShell wrapper of the workspace runner.

# Ensure Bash is available
$bash = ""
try {
    $bash = (Get-Command bash -ErrorAction Stop).Source
} catch {
    Write-Host "❌ Bash is required to run WorkSpace." -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install one of the following:" -ForegroundColor Yellow
    Write-Host "  - Git for Windows (includes Git Bash)" 
    Write-Host "  - Windows Subsystem for Linux (WSL)" 
    Write-Host "  - MSYS2 / MinGW / Cygwin (with bash installed)"
    exit 1
}

# Path to the bash runner (this file is next to workspace)
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$runner = Join-Path $scriptDir "workspace"

if (!(Test-Path $runner)) {
    Write-Host "❌ Missing workspace runner script: $runner" -ForegroundColor Red
    Write-Host "Please reinstall or run update."
    exit 1
}

# Pass all arguments to the bash runner
& $bash "$runner" @args
exit $LASTEXITCODE
