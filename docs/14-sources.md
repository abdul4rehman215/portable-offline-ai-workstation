# 14 — Technical Sources

## llama.cpp

- https://github.com/ggml-org/llama.cpp
- https://github.com/ggml-org/llama.cpp/releases
- https://github.com/ggml-org/llama.cpp/blob/master/tools/server/README.md
- https://github.com/ggml-org/llama.cpp/blob/master/tools/cli/README.md

Relevant features:

- local host/port,
- `--offline`,
- `--parallel`,
- CORS controls,
- API keys,
- embeddings,
- multimodal projector support,
- multi-model router,
- presets,
- model autoload,
- maximum loaded models,
- idle sleeping/unloading.

## Qwen

- https://huggingface.co/Qwen/Qwen3-1.7B-GGUF
- https://huggingface.co/Qwen/Qwen3-4B-GGUF
- https://huggingface.co/Qwen/Qwen2.5-Coder-3B-Instruct-GGUF
- https://huggingface.co/Qwen/Qwen3-VL-2B-Instruct-GGUF
- https://huggingface.co/Qwen/Qwen3-Embedding-0.6B-GGUF

## Speech

- https://github.com/ggml-org/whisper.cpp

## PDF handling

- https://mupdf.readthedocs.io/en/latest/tools/
- https://mupdf.readthedocs.io/en/latest/tools/mutool-convert.html
- https://mupdf.readthedocs.io/en/latest/tools/mutool-draw.html

## Document conversion

- https://pandoc.org/
- https://pandoc.org/MANUAL.html
- https://pandoc.org/installing.html
- https://typst.app/

## Evidence vs upstream sources

Upstream documentation supports what the tools/models can do.

The following come from this project's actual evidence:

- host hardware,
- runtime build/commit,
- runtime SHA-256 captured in the session,
- successful model load,
- localhost UI,
- first-run four slots,
- one-slot optimized launch,
- ~96.8 MB free RAM under load,
- severe generation slowdown.
