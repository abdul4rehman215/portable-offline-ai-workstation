# 12 — Troubleshooting

## Server starts but browser does not open

Look for:

```text
listening on http://127.0.0.1:8080
```

Open:

```text
http://127.0.0.1:8080
```

## Model loads but generation is extremely slow

Check Task Manager.

If available RAM is close to zero:

1. stop the model,
2. close memory-heavy applications,
3. restart if needed,
4. reduce context,
5. set `--parallel 1`,
6. choose a smaller model/quantization,
7. run preflight before retrying.

## Machine becomes almost frozen

Stop the server:

```text
Ctrl + C
```

Restart Windows if memory pressure does not recover.

## Four slots on a single-user machine

Set:

```text
--parallel 1
```

## Path works on one PC but not another

Do not hard-code `D:`.

Use paths relative to the launcher.

## CORS warning

Use:

```text
--cors-origins localhost
--host 127.0.0.1
```

Add an API key when useful.

## Checksum mismatch

Do not ignore it.

Re-download from the official source and recalculate SHA-256.

## Slow model load

Try:

- faster removable storage,
- faster USB port,
- smaller GGUF,
- fewer model switches,
- longer idle lifetime before unloading.

Model-load time and generation speed are different metrics.

## Vision model will not load

Multimodal GGUFs often require the matching `mmproj`.

Do not mix a projector from a different model family.

## RAG answers are weak

Test each stage:

1. extraction,
2. page metadata,
3. chunk size,
4. embeddings,
5. retrieval,
6. final generation.

Do not blame the final LLM until retrieval is checked.
