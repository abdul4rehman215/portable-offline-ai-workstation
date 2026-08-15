param(
    [string]$ModelPath,
    [double]$MinFreeRamGB = 0
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot

$os = Get-CimInstance Win32_OperatingSystem
$totalRamGB = [math]::Round(($os.TotalVisibleMemorySize * 1KB) / 1GB, 2)
$freeRamGB  = [math]::Round(($os.FreePhysicalMemory * 1KB) / 1GB, 2)

$rootItem = Get-Item $Root
$drive = Get-PSDrive -Name $rootItem.PSDrive.Name
$freeDiskGB = [math]::Round($drive.Free / 1GB, 2)

$modelExists = if ($ModelPath) { Test-Path $ModelPath } else { $true }
$runtime = Join-Path $Root "runtime\llama-cpp\cpu\llama-server.exe"
$runtimeExists = Test-Path $runtime
$safe = $runtimeExists -and $modelExists -and ($freeRamGB -ge $MinFreeRamGB)

Write-Host ""
Write-Host "PORTABLE AI PREFLIGHT"
Write-Host "---------------------"
Write-Host ("Installed RAM : {0} GB" -f $totalRamGB)
Write-Host ("Available RAM : {0} GB" -f $freeRamGB)
Write-Host ("Drive free    : {0} GB" -f $freeDiskGB)
Write-Host ("Runtime       : {0}" -f $(if ($runtimeExists) {"PASS"} else {"MISSING"}))
if ($ModelPath) {
    Write-Host ("Model         : {0}" -f $(if ($modelExists) {"PASS"} else {"MISSING"}))
}
Write-Host ("RAM target    : {0} GB free" -f $MinFreeRamGB)
Write-Host ("Launch status : {0}" -f $(if ($safe) {"SAFE"} else {"BLOCKED"}))
Write-Host ""

[pscustomobject]@{
    TotalRamGB = $totalRamGB
    FreeRamGB = $freeRamGB
    FreeDiskGB = $freeDiskGB
    RuntimeExists = $runtimeExists
    ModelExists = $modelExists
    Safe = $safe
}
