```powershell
$ErrorActionPreference = "Stop"

$InstallDir = "$env:LOCALAPPDATA\0xlab"
$ExePath = "$InstallDir\0xlab.exe"
$DownloadUrl = "https://0xshakhawat.com/labs/windows/amd64/0xlab.exe"

Write-Host ""
Write-Host "Installing 0xlab..." -ForegroundColor Cyan
Write-Host ""

# Create installation directory
New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null

Write-Host "Downloading 0xlab.exe..."

Invoke-WebRequest `
    -Uri $DownloadUrl `
    -OutFile $ExePath `
    -UseBasicParsing

Write-Host "Download complete." -ForegroundColor Green

# Check that the file exists
if (-not (Test-Path $ExePath)) {
    throw "0xlab.exe was not downloaded."
}

# Add installation directory to USER PATH
$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")

if ([string]::IsNullOrEmpty($UserPath)) {
    $UserPath = ""
}

$PathEntries = $UserPath -split ";" |
    Where-Object { $_ -and $_.Trim() }

$AlreadyExists = $PathEntries | Where-Object {
    $_.TrimEnd("\") -ieq $InstallDir.TrimEnd("\")
}

if (-not $AlreadyExists) {

    if ($UserPath -and -not $UserPath.EndsWith(";")) {
        $UserPath += ";"
    }

    $UserPath += $InstallDir

    [Environment]::SetEnvironmentVariable(
        "Path",
        $UserPath,
        "User"
    )

    Write-Host "Added 0xlab to User PATH." -ForegroundColor Green
}
else {
    Write-Host "0xlab is already in User PATH." -ForegroundColor Green
}

Write-Host ""
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "       0xlab installed!" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Location:"
Write-Host "  $ExePath"
Write-Host ""

Write-Host "Close this PowerShell window and open a new one."
Write-Host ""

Write-Host "Then try:"
Write-Host ""
Write-Host "  0xlab help" -ForegroundColor Cyan
Write-Host "  0xlab dbms q1 --copy" -ForegroundColor Cyan
Write-Host ""
```
