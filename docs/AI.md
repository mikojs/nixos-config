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
- `aliases`
    - `ccm`: Run `claude-code` with `mcp` servers.

### ccstatusline

ccstatusline is a highly customizable statusline for Claude Code CLI with powerline support, themes, and more.

- [Repository](https://github.com/sirmalloc/ccstatusline)

```
npx ccstatusline@latest
```

## MCP servers

[Here](../home-manager/ai/mcp-servers.nix) are the MCP servers supported by this flake.

- [memory](https://github.com/modelcontextprotocol/servers/tree/main/src/memory): A basic implementation of persistent memory using a local knowledge graph. This lets Claude remember information about the user across chats.
- [sequentialthinking](https://github.com/modelcontextprotocol/servers/tree/main/src/sequentialthinking): An MCP server implementation that provides a tool for dynamic and reflective problem-solving through a structured thinking process.
- [fetch](https://github.com/modelcontextprotocol/servers/tree/main/src/fetch): A Model Context Protocol server that provides web content fetching capabilities. This server enables LLMs to retrieve and process content from web pages, converting HTML to markdown for easier consumption.
- [github-mcp-server](https://github.com/github/github-mcp-server): A Model Context Protocol server for GitHub. This server provides access to GitHub repositories and issues, allowing LLMs to interact with GitHub content.
