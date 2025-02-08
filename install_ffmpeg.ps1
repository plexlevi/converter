# Function to run the script as administrator
function Run-AsAdmin {
    param (
        [string]$ScriptPath
    )
    
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$ScriptPath`"" -Verb RunAs
    exit
}

# Get the path of the current script
$scriptPath = $MyInvocation.MyCommand.Path

# Check if running as administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    # Run the script as administrator
    Run-AsAdmin -ScriptPath $scriptPath
}

# Check if winget is installed
if (Get-Command winget -ErrorAction SilentlyContinue) {
    Write-Host "WinGet is installed."

    # Check the current version of winget
    $version = winget --version
    Write-Host "Current WinGet version: $version"

    # Check for updates
    winget upgrade
    if ($LASTEXITCODE -eq 0) {
        Write-Host "WinGet is up to date."
    } else {
        Write-Host "WinGet is not up to date."
    }
} else {
    Write-Host "WinGet is not installed. Installing WinGet..."

    # Download the latest WinGet installer
    $wingetInstallerUrl = "https://aka.ms/get-winget"
    $installerPath = "$env:TEMP\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle"

    Invoke-WebRequest -Uri $wingetInstallerUrl -OutFile $installerPath

    # Install WinGet
    Add-AppxPackage -Path $installerPath

    # Verify installation
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "WinGet has been successfully installed."
    } else {
        Write-Host "WinGet installation failed."
        exit
    }
}

# Check if FFmpeg is installed
if (Get-Command ffmpeg -ErrorAction SilentlyContinue) {
    Write-Host "FFmpeg is installed. Upgrading FFmpeg using winget..."
    winget upgrade ffmpeg
} else {
    Write-Host "FFmpeg is not installed. Installing FFmpeg using winget..."
    winget install ffmpeg
}

# Pause for a moment to allow the command line aliases to be registered
Start-Sleep -Seconds 5

# Verify FFmpeg installation
if (Get-Command ffmpeg -ErrorAction SilentlyContinue) {
    Write-Host "FFmpeg has been successfully installed or upgraded."
} else {
    Write-Host "FFmpeg installation or upgrade failed."
}

# Wait before closing the window
Write-Host "The script will close in 5 seconds..."
Start-Sleep -Seconds 5
