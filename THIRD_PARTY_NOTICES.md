# Third-Party Components

This repository does not bundle AI model weights or runtime binaries.

The architecture references:

- **llama.cpp** — local LLM/VLM inference runtime
- **Qwen3 / Qwen2.5-Coder / Qwen3-VL / Qwen3-Embedding** — reference model families
- **whisper.cpp** — local speech-to-text
- **MuPDF / mutool** — PDF text extraction and page rendering
- **FFmpeg** — audio/video preprocessing
- **Pandoc** — document conversion
- **Typst** — planned PDF generation engine

Before redistributing any binary or model, review its current upstream license and model card.

Model files are intentionally excluded from Git so each user can download the exact version and quantization appropriate for their hardware.
