# Publishing Checklist

Use this before making the repository public.

## Content check

- [ ] Read the main `README.md` once from top to bottom.
- [ ] Confirm the project name and author/license details.
- [ ] Confirm every **Tested** claim has matching evidence.
- [ ] Keep architecture-only features marked **Designed / Not Tested**.
- [ ] Make sure no personal documents, RAG indexes, logs or secrets are included.
- [ ] Make sure no `.gguf` model files or runtime binaries are committed.
- [ ] Review `SECURITY.md`.
- [ ] Test the reference PowerShell scripts on the next Windows host before calling them production-ready.

## Suggested GitHub settings

**Repository name**

`portable-offline-ai-workstation`

**Short description**

> Resource-aware proof-of-concept and architecture for a private, multi-model AI workstation running from removable storage.

**Suggested topics**

`llama-cpp`, `local-llm`, `gguf`, `qwen`, `offline-ai`, `rag`, `multimodal-ai`, `powershell`, `ai-engineering`, `privacy`

## First Git commit

```powershell
git init
git add .
git status
git commit -m "Document portable offline AI workstation proof of concept"
```

Before `git add .`, check `.gitignore` and confirm large model/runtime files are not inside the repository.

## Final public-repo rule

The repository should tell one accurate story:

**A working core local-LLM proof-of-concept was validated on an 8 GB Windows laptop. The experiment exposed a real RAM bottleneck. The complete seven-mode workstation is preserved as a resource-aware architecture and implementation roadmap for a better-resourced host.**
