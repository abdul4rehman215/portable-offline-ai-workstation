# 02 — Proof of Concept

## Test environment

**Experiment date:** 15 August 2026

| Component | Observed setup |
|---|---|
| CPU | Intel Core i5-1135G7 |
| CPU topology | 4 cores / 8 logical processors |
| RAM | 8 GB LPDDR4 |
| GPU | Intel Iris Xe integrated graphics |
| Storage target | 29.7 GB exFAT removable drive |
| Runtime | llama.cpp Windows CPU build |
| Runtime build | 10437 |
| Runtime commit | `16d222fc5` |
| Model | `Qwen3-1.7B-Q8_0.gguf` |
| Web endpoint | `http://127.0.0.1:8080` |

## Drive preparation

The removable drive was identified in PowerShell before any files were created.

```text
DeviceID   : D:
FileSystem : exFAT
SizeGB     : 29.7
FreeGB     : 29.7
```

The project was then organized into separate areas for runtimes, models, documents, outputs, logs and evidence.

## Runtime verification

The installed server reported:

```text
version: 0.1.0-dev (build 10437, commit 16d222fc5)
built with Clang 20.1.8 for Windows x86_64
```

The runtime ZIP was also hashed with SHA-256:

```text
35CD7E1A132FAF669F4D2392AA8C53E2FB78834CE7BAE53E68F7DE1CB35090E0
```

That hash is preserved as evidence from this experiment. It should not be treated as the checksum for future llama.cpp builds.

## First server run

```powershell
.\llama-server.exe `
  -m "D:\Portable-AI-Workstation\models\fast\Qwen3-1.7B-Q8_0.gguf" `
  --host 127.0.0.1 `
  --port 8080 `
  --ctx-size 4096 `
  --threads 4 `
  --offline
```

The server successfully:

- loaded the GGUF model,
- created inference slots,
- and listened on `http://127.0.0.1:8080`.

The log showed four slots in the first run.

The model load took roughly four minutes from the removable storage in the captured log. That is an observed result for this device, not a general llama.cpp benchmark.

## Local UI

The browser opened the built-in llama.cpp interface at:

```text
127.0.0.1:8080
```

This confirmed:

```text
removable drive
    ↓
llama.cpp runtime
    ↓
GGUF model
    ↓
localhost server
    ↓
browser UI
```

## Resource bottleneck

The host was already under memory pressure before the model test. An earlier Task Manager capture showed only about 927 MB available.

During the inference test:

```text
In use     : 7.6 GB
Available  : 96.8 MB
Committed  : 13.2 / 17.2 GB
```

A captured response showed only a few generated tokens after several minutes, at approximately:

```text
0.01 token/s
```

The system was heavily paging and felt almost frozen.

## Root-cause interpretation

The prototype had multiple simultaneous pressures:

- Windows was already using most of the 8 GB RAM,
- the Q8 model added model memory,
- context/KV cache required additional memory,
- automatic server parallelism created four slots,
- the browser and background processes still needed memory,
- the integrated GPU shared system memory.

The model was compatible. The host simply had too little practical headroom for that configuration.

## Optimization attempted

The next launch changed:

```text
context: 4096 → 2048
parallel slots: auto/4 → 1
```

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

The log confirmed:

```text
n_slots = 1
n_ctx_slot = 2048
```

The project was intentionally stopped at this point rather than forcing the remaining seven-mode implementation onto a memory-starved host.

## What the proof establishes

The proof validates:

- portable runtime execution,
- local GGUF loading,
- local HTTP serving,
- browser access,
- basic local inference,
- and the need for resource-aware controls.

It does **not** claim that the full workstation was completed or that the tested 8 GB system delivered acceptable production performance.
