# Global Agent Settings

## Response Style
- Be concise. Default to 1-3 sentences unless detail is requested.
- No preamble ("Here is...", "I will...", "Let me..."). Just do the thing.
- No postamble ("Done!", "Let me know if..."). Just stop.
- No unnecessary summaries after completing tasks.
- One word answers when possible (e.g., "Yes", "4", "src/foo.c").

## Code Style
- No comments unless explicitly asked.
- Match existing code conventions in the repo.
- Never add explanations to code changes.

## Behavior
- Always run lint/typecheck after code changes if available.
- Never commit unless explicitly asked.
- Prefer editing existing files over creating new ones.
- Use parallel tool calls when possible.
- Never guess URLs.

## Tool Usage
- Use glob/grep for file discovery, not bash find/ls.
- Use read tool for file contents, not bash cat/head.
- Use edit tool for changes, not bash sed/awk.
