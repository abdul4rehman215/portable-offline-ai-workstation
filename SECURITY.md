# Security

This project is designed for **local, privacy-first inference**, but local software still needs security controls.

## Threat model

The main design assumes:

- one user,
- one Windows host,
- the AI server bound to loopback,
- models and documents stored locally,
- no public network exposure,
- no automatic shell execution.

## Safe server defaults

Use loopback:

```text
--host 127.0.0.1
```

Restrict browser cross-origin requests:

```text
--cors-origins localhost
```

Prevent llama.cpp from fetching remote model assets during normal offline operation:

```text
--offline
```

For a single-user low-memory machine:

```text
--parallel 1
```

## API authentication

llama.cpp supports `--api-key` and `--api-key-file`.

An API key is optional for a loopback-only personal setup, but it is useful defence in depth when another local application uses the API. Never commit a real key to this repository.

The reference launcher reads an optional key from:

```powershell
$env:PORTABLE_AI_API_KEY
```

## CORS warning seen in the prototype

The prototype console warned that CORS allowed all origins (`*`) and no API key was configured.

This did **not** mean the model was uploading prompts to a cloud service. It meant the local HTTP server accepted cross-origin browser requests too broadly.

The hardened design changes that server configuration rather than claiming that “offline” automatically equals “secure.”

## Do not enable agent tools by default

Current llama.cpp can expose built-in tools including file access and shell execution.

This project keeps those tools **off by default**.

Model inference and permission to modify the computer are separate capabilities. If tool execution is added later:

- require explicit user approval,
- restrict file-system scope,
- prefer a sandbox/container,
- log tool calls,
- and never expose the tool-enabled server to an untrusted network.

## Documents and local RAG

Local RAG can still expose sensitive information to anyone who can use the workstation. Protect the removable drive physically and consider encryption when storing private documents.

## Reporting security issues

If this repository is published publicly, use GitHub's private vulnerability reporting feature rather than posting sensitive exploit details in a public issue.
