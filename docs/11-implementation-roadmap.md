# 11 — Implementation Roadmap

The proof-of-concept validated the core runtime. This roadmap preserves the path to the complete workstation.

## Phase 1 — Foundation ✅

- identify removable drive,
- verify filesystem,
- create portable folder structure,
- record host hardware,
- start evidence log.

## Phase 2 — Runtime ✅ / partial

Completed:

- llama.cpp CPU runtime,
- version verification,
- SHA-256 check.

Planned:

- Intel SYCL profile,
- whisper.cpp,
- FFmpeg,
- MuPDF,
- Pandoc,
- Typst.

## Phase 3 — Model layer

- Fast,
- Reasoning,
- Coding,
- Vision + mmproj,
- Embeddings,
- Whisper,
- manifest/checksums.

Only the first Fast model was loaded in the original experiment.

## Phase 4 — Controller

Build:

- launcher,
- preflight,
- model registry,
- process lifecycle,
- health checks,
- browser launch,
- logs.

Reference scripts are included but are not presented as production-tested software.

## Phase 5 — Text intelligence

Implement Fast, Reasoning and Coding modes.

## Phase 6 — Local RAG

Implement:

- PDF extraction,
- scanned-page detection,
- chunking,
- embeddings,
- local vector index,
- retrieval,
- page citations.

## Phase 7 — Document Studio

Implement Markdown-first generation plus HTML/DOCX/PDF export.

## Phase 8 — Multimodal

Implement screenshots, OCR, scanned PDFs and sampled-frame video analysis.

## Phase 9 — Speech

Implement audio normalization, Whisper transcription and transcript summarization.

## Phase 10 — Unified UI

The user chooses a task. The controller handles infrastructure.

## Phase 11 — Engineering controls

Add:

- RAM thresholds,
- one-model maximum,
- checksum verification,
- localhost/CORS hardening,
- optional API key,
- error handling,
- storage checks,
- benchmark logging.

## Phase 12 — Acceptance tests

V1 is complete when, on a suitably resourced Windows host:

```text
insert removable drive
       ↓
start launcher
       ↓
disconnect internet
       ↓
run all seven modes
       ↓
save outputs locally
```

Checklist:

- [ ] Fast chat
- [ ] Reasoning
- [ ] Coding
- [ ] PDF RAG
- [ ] Document export
- [ ] Vision/OCR
- [ ] Video analysis
- [ ] Voice transcription
- [ ] Benchmark logging
- [ ] Offline verification
- [ ] Security hardening
- [ ] Rebuild from documented sources

## Recommended restart point

When resumed on a stronger host:

1. restore runtime and fast model,
2. run preflight,
3. benchmark one small model,
4. validate secure localhost settings,
5. add one mode at a time.

Do not download every model first and discover the resource limit last.
