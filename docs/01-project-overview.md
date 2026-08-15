# 01 — Project Overview

## Project question

Can a removable drive carry everything needed to run a useful, private AI workstation on a compatible Windows computer?

The goal was not to build one chatbot. The goal was to design a portable system with multiple local AI capabilities while keeping models, tools, documents and outputs on removable storage.

## Design goals

The workstation should be:

- **offline-first** — normal inference should not require an internet connection,
- **portable** — avoid fixed drive letters and machine-specific install paths,
- **private** — keep prompts and local documents on the host instead of sending them to a cloud AI API,
- **resource-aware** — check RAM before loading a model and avoid unnecessary concurrency,
- **modular** — swap one model without redesigning the whole workstation,
- **reproducible** — keep setup instructions, checksums and source links,
- **observable** — log failures and benchmark real performance.

## Target experience

```text
Insert removable drive
        ↓
Start-Offline-AI.bat
        ↓
System preflight
        ↓
Choose a mode
        ↓
Load only the required model
        ↓
Use the local UI/API
        ↓
Save outputs back to the removable drive
```

## Seven modes

### 1. Fast AI Assistant
Normal chat, rewriting, summaries, notes and brainstorming.

### 2. Deep Reasoning
Planning, technical reasoning, logic and harder analysis.

### 3. Coding Assistant
Code generation, explanation, refactoring and debugging.

### 4. Local RAG
Questions about local PDFs/documents with source/page references.

### 5. Document & Report Studio
Markdown, HTML, DOCX and PDF outputs from local prompts or RAG research.

### 6. Vision / OCR / Screenshot / Video
Images, error screenshots, scanned pages and sampled video frames.

### 7. Voice / Audio / Transcription
Local transcription followed by summaries, notes or action items.

## What the first experiment covered

The first experiment focused on the common foundation:

1. prepare the removable drive,
2. create the portable folder structure,
3. install the llama.cpp Windows CPU runtime,
4. verify the runtime,
5. load a local Qwen GGUF model,
6. start a loopback server,
7. open the local browser UI,
8. observe real memory and performance behaviour.

That common foundation worked.

The experiment then stopped because the 8 GB test laptop had too little free RAM for a useful interactive experience with the selected configuration.

## Why that still matters

A deployment project is not only about getting software to launch.

It is also about answering:

- What is the bottleneck?
- What does the host actually have available?
- Which parameters control memory?
- What should happen when resources are insufficient?
- How do we prevent one feature from taking down the whole workstation?

Those questions produced the resource-aware architecture documented in this repository.
