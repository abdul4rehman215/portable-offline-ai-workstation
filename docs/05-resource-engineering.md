# 05 — Resource Engineering

## Main lesson

The test laptop had 8 GB RAM, but the important number was **free RAM at launch time**, not installed RAM.

Before the AI workload:

```text
Available: ~927 MB
```

During the model test:

```text
Available: 96.8 MB
Committed: 13.2 / 17.2 GB
```

That is the real reason the machine became almost unusable.

## Memory is shared by the whole system

```text
Windows
+ background apps
+ model weights
+ KV cache
+ context
+ server slots
+ runtime buffers
+ browser UI
+ integrated-GPU shared memory
```

A model file fitting on disk does not guarantee a good runtime experience.

## Initial configuration

```text
Qwen3-1.7B Q8
ctx-size = 4096
threads = 4
parallel = automatic
```

The server log showed four slots.

That was unnecessary for a single-user workstation.

## Resource-aware profile

The second run changed to:

```text
ctx-size = 2048
parallel = 1
threads = 4
```

The server confirmed one slot.

Design rule:

> Start with the smallest configuration that meets the task. Scale up only when the host has headroom.

## Preflight policy

Before launching a model:

```text
1. Read installed RAM
2. Read currently available RAM
3. Check model file
4. Check removable-drive free space
5. Check runtime
6. Compare available RAM with model profile
7. Warn/refuse when the safety margin is too small
```

Example:

```text
SYSTEM PREFLIGHT

Installed RAM:      8.0 GB
Available RAM:      1.1 GB
Selected mode:      Reasoning
Recommended free:   5.0 GB

STATUS: NOT SAFE
```

## Host planning guide

| RAM | Expected use |
|---|---|
| 8 GB | very small models, short context, one slot, proof-of-concept |
| 16 GB | practical small-model target |
| 24–32 GB | comfortable local workflows and larger headroom |

These are planning tiers, not fixed requirements.

## Approximate workload planning ranges

| Workload | Planning range |
|---|---:|
| sub-2B general model | ~2–4 GB |
| 3B coding model | ~4–6 GB |
| 4B Q4 reasoning model | ~5–7 GB |
| 2B vision workflow | ~4–6 GB |
| small embedding model | ~1–2 GB |
| Whisper Small | ~1 GB class |

Do not add these numbers together when the lifecycle manager runs one workload at a time.


## Alternative host note

The core architecture is not tied to the original laptop. A later CPU-only remote host could start around **4 vCPU and 16 GB RAM** for these small-model workflows, then be benchmarked and right-sized.

That is only a planning starting point, not a tested requirement. A remote host also changes the project from an offline portable workstation into a network service, so it is intentionally outside the main scope of this repository.

## Storage speed matters

The captured removable-drive load took around four minutes.

That makes storage speed part of the user experience.

For slow removable storage:

- keep the active model loaded while useful,
- avoid very aggressive unload timers,
- use smaller model files,
- benchmark the actual device,
- separate model-load time from generation speed.

## Benchmark fields

```text
timestamp
model
quantization
model_size
context
threads
parallel_slots
load_time
ram_before
ram_peak
time_to_first_token
tokens_per_second
total_response_time
storage_device
errors
```

See `prototype/benchmark-template.csv`.
