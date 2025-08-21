# AI

[Here](../home-manager/ai/) are the specific packages for each AI supported by this flake.

## Gemini CLI

Gemini CLI is an AI agent that brings the power of Gemini directly into your terminal.

- [Configuration](../home-manager/ai/gemini.nix)
- [Repository](https://github.com/google-gemini/gemini-cli)

## Claude Code

Claude Code is an AI agent that brings the power of Claude directly into your code.

- [Configuration](../home-manager/ai/claude.nix)
- [Repository](https://github.com/anthropics/claude-code)

## MCP servers

[Here](../home-manager/ai/mcpServers.json) are the MCP servers supported by this flake.

- [modelcontextprotocol/server-memory](https://github.com/modelcontextprotocol/servers/tree/main/src/memory): A basic implementation of persistent memory using a local knowledge graph. This lets Claude remember information about the user across chats.
- [@modelcontextprotocol/server-sequential-thinking](https://github.com/modelcontextprotocol/servers/tree/main/src/sequentialthinking): An MCP server implementation that provides a tool for dynamic and reflective problem-solving through a structured thinking process.
