# Experiment Results

## Outcome

**Core local deployment: successful.**

**Usable interactive performance on the original 8 GB host: not achieved.**

| Test | Result |
|---|---|
| Removable drive detected | PASS |
| Folder structure created | PASS |
| llama.cpp executable starts | PASS |
| Runtime version read | PASS |
| Runtime ZIP SHA-256 captured | PASS |
| Model accepted and loaded | PASS |
| Local server started | PASS |
| Browser UI opened | PASS |
| Inference began | PASS |
| Adequate free RAM | FAIL |
| Practical response speed | FAIL on captured run |
| Full seven modes | NOT TESTED |

## Memory result

```text
In use:     7.6 GB
Available:  96.8 MB
Committed:  13.2 / 17.2 GB
```

## Generation result

Captured chat:

```text
6 generated tokens
9 min 20 sec
~0.01 token/s
```

This is evidence of host memory/paging pressure, not a general model benchmark.

## Decision

Stop implementation on this host and preserve:

- proof,
- bottleneck,
- architecture,
- optimized configuration,
- implementation roadmap.

Resume on a host with significantly more available memory.
