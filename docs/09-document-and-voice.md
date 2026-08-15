# 09 — Document Studio & Voice

## Document Studio

```text
Prompt or RAG research
        ↓
Local text model
        ↓
Structured Markdown
        ↓
Pandoc
  ┌─────┼────────┐
 HTML  DOCX     Typst
               ↓
              PDF
```

## Why Markdown first

Markdown is easy to generate, review, diff in Git and convert later.

Keep the Markdown source even when the user exports DOCX or PDF.

## Output structure

```text
workspace/outputs/
├── markdown/
├── docx/
├── pdf/
├── ocr/
└── transcripts/
```

## Document use cases

- technical report,
- project case study,
- README,
- research summary,
- study notes,
- meeting minutes,
- SOP,
- interview notes,
- article,
- project documentation.

## Voice / audio mode

```text
audio / recording / video
        ↓
FFmpeg normalization
        ↓
whisper.cpp
        ↓
local transcript
        ↓
text model
   ┌────┼────────┐
summary notes action items
```

## Why keep transcription separate

Speech-to-text and text reasoning have different resource profiles.

On a low-memory host:

1. run Whisper,
2. save the transcript,
3. release Whisper memory,
4. load the text model,
5. summarize.

## Privacy note

Voice recordings can be sensitive.

Store transcripts on removable storage and make deletion easy. Do not upload recordings to a cloud transcription API from an offline mode.
