# 10 — Privacy & Security

## Local inference is a privacy advantage, not a magic security label

A normal local GGUF inference request does not need to send the prompt to a hosted AI provider.

But the surrounding application still has:

- an HTTP server,
- a browser UI,
- local files,
- possible tools,
- operating-system permissions.

Those parts still need controls.

## Warning observed in the prototype

The llama.cpp console displayed a warning that:

- CORS allowed all origins,
- no API key was configured.

This warning came from the local web server configuration.

It did **not** show that the model was uploading prompts to the internet.

## CORS in simple terms

A website in your browser can try to send requests to services on `localhost`.

CORS controls which website origins are allowed to interact with the server.

If the server accepts `*`, it is permissive.

Use:

```text
--cors-origins localhost
```

## Bind to loopback

Use:

```text
--host 127.0.0.1
```

Do not change to `0.0.0.0` unless remote access is deliberate and additional controls are added.

## Offline mode

Use:

```text
--offline
```

Current llama.cpp documents this as forcing cached/local use and preventing network access by the runtime.

Offline mode does **not** replace:

- firewall rules,
- CORS,
- API authentication,
- file permissions.

## API key

llama.cpp supports:

```text
--api-key
--api-key-file
```

A key can provide defence in depth for local API integrations. Store it outside Git.

## Tool execution

llama.cpp can expose built-in tools such as file access and shell commands.

This design keeps tools off by default.

Safer coding flow:

```text
AI generates code
      ↓
save to workspace/code
      ↓
user reviews
      ↓
user explicitly runs it
```

## Asset integrity

Record:

```text
name
version
source
file size
SHA-256
license
purpose
download date
```

If a checksum changes unexpectedly, stop and investigate.

## Local data limitations

“Local” does not protect against:

- malware already on the host,
- another user with file access,
- loss/theft of the removable drive,
- insecure backups,
- intentionally enabled remote access.

For sensitive data, add encryption and strong host security.
