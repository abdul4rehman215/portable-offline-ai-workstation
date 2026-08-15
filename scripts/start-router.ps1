$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
$server = Join-Path $Root "runtime\llama-cpp\cpu\llama-server.exe"
$preset = Join-Path $Root "config\models-router.example.ini"

if (-not (Test-Path $server)) { throw "llama-server.exe not found: $server" }
if (-not (Test-Path $preset)) { throw "Router preset not found: $preset" }

Push-Location $Root
try {
    $args = @(
        "--models-preset", $preset,
        "--models-max", "1",
        "--models-autoload",
        "--host", "127.0.0.1",
        "--port", "8080",
        "--cors-origins", "localhost",
        "--offline"
    )

    if ($env:PORTABLE_AI_API_KEY) {
        $args += @("--api-key", $env:PORTABLE_AI_API_KEY)
    }

    Write-Host "Starting llama.cpp router mode."
    Write-Host "Maximum loaded models: 1"
    Write-Host "Reference design; not tested in the original proof-of-concept."
    & $server @args
}
finally {
    Pop-Location
}
