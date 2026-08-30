$ErrorActionPreference = "Stop"

$InstallDir = Join-Path $env:LOCALAPPDATA "0xlab"
$ExePath = Join-Path $InstallDir "0xlab.exe"
$DownloadUrl = "https://0xshakhawat.com/labs/windows/amd64/0xlab.exe"

Write-Host ""
Write-Host "0xLAB Starter" -ForegroundColor Cyan
Write-Host "────────────────────────────────────"
Write-Host ""

try {
    # Create installation directory
    if (-not (Test-Path $InstallDir)) {
        New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
    }

    Write-Host "Downloading 0xlab..." -ForegroundColor Yellow

    # Download executable
    Invoke-WebRequest `
        -Uri $DownloadUrl `
        -OutFile $ExePath `
        -UseBasicParsing

    # Verify that the executable exists
    if (-not (Test-Path $ExePath)) {
        throw "0xlab.exe was not downloaded."
    }

    Write-Host "✓ Downloaded 0xlab" -ForegroundColor Green

    # Get current User PATH
    $UserPath = [Environment]::GetEnvironmentVariable("Path", "User")

    if ([string]::IsNullOrWhiteSpace($UserPath)) {
        $UserPath = ""
    }

    # Add installation directory to User PATH if it isn't already there
    $PathEntries = $UserPath -split ";" | Where-Object {
        -not [string]::IsNullOrWhiteSpace($_)
    }

    $AlreadyInPath = $PathEntries | Where-Object {
        $_.TrimEnd("\") -ieq $InstallDir.TrimEnd("\")
    }

    if (-not $AlreadyInPath) {
        if ($UserPath.Length -gt 0 -and -not $UserPath.EndsWith(";")) {
            $UserPath += ";"
        }

        $UserPath += $InstallDir

        [Environment]::SetEnvironmentVariable(
            "Path",
            $UserPath,
            "User"
        )

        Write-Host "✓ Added 0xlab to User PATH" -ForegroundColor Green
    }
    else {
        Write-Host "✓ 0xlab is already in User PATH" -ForegroundColor Green
    }

    Write-Host ""
    Write-Host "0xLab is ready" -ForegroundColor Green
    Write-Host ""
    Write-Host "Path to:"
    Write-Host "  $ExePath"
    Write-Host ""
    Write-Host "Close this PowerShell window and open a new one."
    Write-Host ""
    Write-Host "Then run:"
    Write-Host ""
    Write-Host "  0xlab version" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Example:"
    Write-Host ""
    Write-Host "  0xlab dbms q1 --copy" -ForegroundColor Cyan
    Write-Host ""
}
catch {
    Write-Host ""
    Write-Host "✗ Installation failed." -ForegroundColor Red
    Write-Host ""
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host ""
    exit 1
}
