# Reference Scripts

These scripts preserve the automation design.

They are **not claimed as production-tested** because the complete workstation implementation stopped after the core proof-of-concept.

- `preflight.ps1` — RAM/disk/runtime/model checks
- `launch-model.ps1` — single-model launcher with hardened localhost defaults
- `start-router.ps1` — multi-model router reference with `--models-max 1`
- `verify-assets.ps1` — checksum helper
- `capture-hardware.ps1` — host profile capture

Before using:

1. put llama.cpp under `runtime/llama-cpp/cpu/`,
2. put model files at paths in `config/models.example.json`,
3. tune RAM thresholds for the host,
4. test one model at a time.
