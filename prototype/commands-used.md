# Commands Used in the Prototype

## Identify removable drives

```powershell
Get-CimInstance Win32_LogicalDisk |
Select-Object DeviceID, VolumeName, FileSystem,
@{N='SizeGB';E={[math]::Round($_.Size/1GB,1)}},
@{N='FreeGB';E={[math]::Round($_.FreeSpace/1GB,1)}}
```

## Verify llama.cpp

```powershell
cd "D:\Portable-AI-Workstation\runtime\llama-cpp\cpu"
.\llama-server.exe --version
```

Observed:

```text
version: 0.1.0-dev (build 10437, commit 16d222fc5)
built with Clang 20.1.8 for Windows x86_64
```

## Runtime ZIP SHA-256

```powershell
Get-FileHash ".\llama-b10437-bin-win-cpu-x64.zip" -Algorithm SHA256
```

Observed:

```text
35CD7E1A132FAF669F4D2392AA8C53E2FB78834CE7BAE53E68F7DE1CB35090E0
```

## First model launch

```powershell
.\llama-server.exe `
-m "D:\Portable-AI-Workstation\models\fast\Qwen3-1.7B-Q8_0.gguf" `
--host 127.0.0.1 `
--port 8080 `
--ctx-size 4096 `
--threads 4 `
--offline
```

## Reduced-memory launch

```powershell
.\llama-server.exe `
-m "D:\Portable-AI-Workstation\models\fast\Qwen3-1.7B-Q8_0.gguf" `
--host 127.0.0.1 `
--port 8080 `
--ctx-size 2048 `
--parallel 1 `
--threads 4 `
--offline
```

Observed:

```text
n_slots = 1
n_ctx_slot = 2048
```

## Hardened future profile

Add:

```text
--cors-origins localhost
```

Optionally add an API key through an environment variable or key file.

## Portability improvement

The original command shows `D:` because that was the test drive letter.

Future automation should resolve the USB/repository root dynamically.
