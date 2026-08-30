$ErrorActionPreference = "Stop"

$InstallDir = "$env:LOCALAPPDATA\0xlab"
$ExePath = "$InstallDir\0xlab.exe"
$DownloadUrl = "https://shakhawat.me/labs/windows/amd64/0xlab.exe"

try {

    Write-Host ""
    Write-Host "0xLAB" -ForegroundColor Cyan
    Write-Host "Installing..." -ForegroundColor Cyan
    Write-Host ""

    # Create installation directory
    New-Item `
        -ItemType Directory `
        -Path $InstallDir `
        -Force | Out-Null

    Write-Host "[1/3] Downloading 0xlab.exe..."

    Invoke-WebRequest `
        -Uri $DownloadUrl `
        -OutFile $ExePath `
        -UseBasicParsing

    if (-not (Test-Path $ExePath)) {
        throw "0xlab.exe was not downloaded."
    }

    Write-Host "      Done." -ForegroundColor Green

    # Add to User PATH
    Write-Host "[2/3] Updating User PATH..."

    $UserPath = [Environment]::GetEnvironmentVariable("Path", "User")

    if ([string]::IsNullOrEmpty($UserPath)) {
        $UserPath = ""
    }

    $Entries = $UserPath -split ";" |
        Where-Object { $_ -and $_.Trim() }

    $Exists = $Entries | Where-Object {
        $_.TrimEnd("\") -ieq $InstallDir.TrimEnd("\")
    }

    if (-not $Exists) {

        if ($UserPath -and -not $UserPath.EndsWith(";")) {
            $UserPath += ";"
        }

        $UserPath += $InstallDir

        [Environment]::SetEnvironmentVariable(
            "Path",
            $UserPath,
            "User"
        )

        Write-Host "      Added to User PATH." -ForegroundColor Green

    } else {

        Write-Host "      Already in User PATH." -ForegroundColor Green
    }

    Write-Host "[3/3] Installation complete." -ForegroundColor Green

    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "          0xlab is ready!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""

    Write-Host "Installed:"
    Write-Host "  $ExePath"
    Write-Host ""

    Write-Host "IMPORTANT: Close this PowerShell window"
    Write-Host "and open a new one. "
    Write-Host ""

    Write-Host "Then run:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  0xlab help"
    Write-Host ""

}
catch {

    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "          0xlab installation failed" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""

    Write-Host $_.Exception.Message -ForegroundColor Red

    Write-Host ""
}
