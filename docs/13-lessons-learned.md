# 13 — Lessons Learned

## 1. Compatibility and usability are different

The model loaded and the UI opened.

That proved compatibility.

The near-zero free RAM proved the configuration was not practically usable on the test host.

Both can be true.

## 2. Resource management is AI engineering

Model choice includes:

- RAM,
- context,
- concurrency,
- load time,
- storage speed,
- latency,
- target hardware.

## 3. “Fast” means fast on the target host

The first Fast profile used Qwen3-1.7B Q8.

On this 8 GB machine, a smaller profile would be a better engineering choice.

## 4. Automatic defaults are not always deployment defaults

The first run created multiple slots.

A single-user workstation should explicitly request one unless concurrency is needed.

## 5. Offline and secure are different properties

Local inference reduces cloud data sharing.

The local server still needs loopback binding, CORS control, optional authentication and careful permissions.

## 6. Removable storage changes performance

Model load time depends on storage I/O.

That should be measured separately from generation speed.

## 7. Documentation preserves unfinished engineering work

The complete seven-mode system did not need to be forced onto unsuitable hardware.

The proof, bottleneck, architecture and next steps are now reusable.
