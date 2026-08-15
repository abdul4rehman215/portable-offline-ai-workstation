param([string]$Manifest = "")

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot

if (-not $Manifest) {
    $Manifest = Join-Path $Root "config\assets-manifest.json"
    if (-not (Test-Path $Manifest)) {
        $Manifest = Join-Path $Root "config\assets-manifest.example.json"
    }
}

$data = Get-Content $Manifest -Raw | ConvertFrom-Json

foreach ($asset in $data.assets) {
    Write-Host ""
    Write-Host $asset.name
    if ($asset.sha256) {
        Write-Host ("  Expected SHA-256: {0}" -f $asset.sha256)
    } else {
        Write-Host "  SHA-256: not recorded in manifest"
    }
}

Write-Host ""
Write-Host "Use Get-FileHash <path> -Algorithm SHA256 and compare before use."
