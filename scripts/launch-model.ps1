param(
    [ValidateSet("fast","reasoning","coding","vision","embeddings")]
    [string]$Mode
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot

$configPath = Join-Path $Root "config\models.json"
if (-not (Test-Path $configPath)) {
    $configPath = Join-Path $Root "config\models.example.json"
}

$config = Get-Content $configPath -Raw | ConvertFrom-Json

if (-not $Mode) {
    Write-Host ""
    Write-Host "PORTABLE OFFLINE AI WORKSTATION"
    Write-Host "--------------------------------"
    Write-Host "[1] Fast Assistant"
    Write-Host "[2] Deep Reasoning"
    Write-Host "[3] Coding Assistant"
    Write-Host "[4] Vision / OCR"
    Write-Host "[5] Embeddings service"
    Write-Host ""
    Write-Host "RAG, Document Studio and Voice are architecture modules"
    Write-Host "not implemented in the original proof-of-concept."
    Write-Host ""

    $choice = Read-Host "Choose 1-5"
    $Mode = switch ($choice) {
        "1" {"fast"}
        "2" {"reasoning"}
        "3" {"coding"}
        "4" {"vision"}
        "5" {"embeddings"}
        default { throw "Invalid selection." }
    }
}

$profile = $config.models.$Mode
if (-not $profile) { throw "Model profile '$Mode' not found." }

$modelPath = Join-Path $Root $profile.relativePath
$server = Join-Path $Root "runtime\llama-cpp\cpu\llama-server.exe"

$preflight = & (Join-Path $PSScriptRoot "preflight.ps1") `
    -ModelPath $modelPath `
    -MinFreeRamGB ([double]$profile.minFreeRamGB)

if (-not $preflight.Safe) {
    throw "Preflight blocked this launch. Free resources or choose a smaller profile."
}

$args = @(
    "-m", $modelPath,
    "--host", "127.0.0.1",
    "--port", "8080",
    "--ctx-size", ([string]$profile.ctxSize),
    "--parallel", ([string]$profile.parallel),
    "--threads", ([string]$profile.threads),
    "--cors-origins", "localhost",
    "--offline"
)

if ($profile.reasoning -eq "on")  { $args += @("--reasoning", "on") }
if ($profile.reasoning -eq "off") { $args += @("--reasoning", "off") }

if ($profile.serviceMode -eq "embedding") { $args += "--embedding" }

if ($profile.mmprojRelativePath) {
    $mmproj = Join-Path $Root $profile.mmprojRelativePath
    if (-not (Test-Path $mmproj)) { throw "Multimodal projector missing: $mmproj" }
    $args += @("--mmproj", $mmproj)
}

if ($env:PORTABLE_AI_API_KEY) {
    $args += @("--api-key", $env:PORTABLE_AI_API_KEY)
}

Write-Host ""
Write-Host ("Starting: {0}" -f $profile.displayName)
Write-Host "Server: http://127.0.0.1:8080"
Write-Host ""

& $server @args
