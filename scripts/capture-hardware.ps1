$Root = Split-Path -Parent $PSScriptRoot
$out = Join-Path $Root "prototype\hardware-capture.txt"

"Portable Offline AI Workstation - Hardware Capture" | Set-Content $out
("Captured: " + (Get-Date -Format "yyyy-MM-dd HH:mm:ss zzz")) | Add-Content $out
"" | Add-Content $out

Get-CimInstance Win32_Processor |
Select-Object Name, NumberOfCores, NumberOfLogicalProcessors |
Format-List | Out-String | Add-Content $out

Get-CimInstance Win32_OperatingSystem |
Select-Object Caption, OSArchitecture,
@{N='TotalRAMGB';E={[math]::Round(($_.TotalVisibleMemorySize*1KB)/1GB,2)}},
@{N='FreeRAMGB';E={[math]::Round(($_.FreePhysicalMemory*1KB)/1GB,2)}} |
Format-List | Out-String | Add-Content $out

Get-CimInstance Win32_VideoController |
Select-Object Name, DriverVersion |
Format-List | Out-String | Add-Content $out

Get-CimInstance Win32_LogicalDisk |
Select-Object DeviceID, VolumeName, FileSystem,
@{N='SizeGB';E={[math]::Round($_.Size/1GB,1)}},
@{N='FreeGB';E={[math]::Round($_.FreeSpace/1GB,1)}} |
Format-Table -AutoSize | Out-String | Add-Content $out

Write-Host "Saved: $out"
