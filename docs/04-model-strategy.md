# 04 — Model Strategy

## Why multiple models

One local model does not need to do every job.

A portable workstation can be more efficient by using smaller, specialized models for specific tasks.

## Reference model set

| Function | Reference choice | Approx. storage snapshot | Role |
|---|---|---:|---|
| Fast assistant | Qwen3-1.7B Q8_0 | 1.83 GB | everyday text work |
| Reasoning | Qwen3-4B Q4_K_M | 2.50 GB | deeper analysis |
| Coding | Qwen2.5-Coder-3B-Instruct Q4_K_M | 2.10 GB | code work |
| Vision/OCR | Qwen3-VL-2B-Instruct Q4_K_M | 1.11 GB | images, scans, screenshots, video frames |
| Vision projector | Qwen3-VL mmproj Q8_0 | 445 MB | visual encoder/projector |
| Embeddings | Qwen3-Embedding-0.6B Q8_0 | 639 MB | local semantic retrieval |
| Speech | Whisper Small multilingual | 466 MiB | transcription |

The reference model set is roughly **9.1 GB** before runtime binaries, indexes, documents and outputs. These figures are a design snapshot; verify the current upstream file before rebuilding the workstation.

## Tested vs selected

Only the fast model was used in the first proof-of-concept.

The other entries are **architecture selections**, not claims of successful testing on the original laptop.

## Quantization is a resource choice

GGUF quantization trades model size and memory pressure against quality.

A portable system should not assume that a larger precision is always better.

The original “fast” model used Q8, but the experiment showed that the host had very little memory headroom. On an 8 GB machine, a smaller model or a more aggressive quantization may be the better engineering choice.

## Context is part of the model profile

```json
{
  "id": "fast",
  "model": "Qwen3-1.7B-Q8_0.gguf",
  "ctxSize": 2048,
  "parallel": 1,
  "threads": 4,
  "minFreeRamGB": 3.0
}
```

The model registry is a **runtime profile**, not just a download list.

## Do not lock the project to one generation of models

The architecture should survive model changes.

A future user may replace any reference model while keeping the same roles:

```text
Fast
Reasoning
Coding
Vision
Embedding
Speech
```

## Storage planning

The original V1 blueprint estimated roughly 9 GB for the selected model set and around 10.5–12 GB for the base workstation including runtimes/tools.

Treat those values as a planning snapshot, not a permanent bill of materials.

## Model download policy

For a reproducible build:

1. store the upstream model repository,
2. store the exact file/quantization,
3. record file size,
4. calculate SHA-256 after download,
5. record the model license,
6. never commit multi-GB model files to GitHub.

Use `config/assets-manifest.example.json` as the starting format.
