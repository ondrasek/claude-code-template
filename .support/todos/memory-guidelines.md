Agents are using memory mcp server, but it seems that persistence is not working well, because keywords/relations/etc do not match. I.e. one agent makes deliberate choice about naming and the retrieving agent expects different naming, finding nothing in the memory.

We shall probably split memory into long-term and short-term memory. Long term memory protocol will use memories folder and short-term will reply on the MCP server. We will not do any export/import and rather create custom long term memory protocol.

May be create long-term memory retrieval agent?