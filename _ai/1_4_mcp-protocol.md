---
title: MCP Protocol Implementation
layout: agentic
permalink: /ai/mcp-protocol
series: "Build and Maintain a Reliable Secure AI Agent in the Cloud"
sequence: 4
tags: [ai, mcp, protocol, json-rpc, communication]
status: published
short_summary: JSON-RPC 2.0 implementation, tool definitions, and MCP communication patterns
---

# MCP Protocol Implementation

The Model Context Protocol (MCP) provides a standardized way for AI agents to communicate with backend services. This article covers the JSON-RPC 2.0 implementation used in our system.

## JSON-RPC 2.0 Format

All MCP communication uses JSON-RPC 2.0 protocol, ensuring consistent request/response handling across all services.

### Request Format

```json
{
  "jsonrpc": "2.0",
  "method": "tools/call",
  "params": {
    "name": "tool_name",
    "arguments": {
      "arg1": "value1",
      "arg2": "value2"
    }
  },
  "id": 1
}
```

**Fields:**
- `jsonrpc`: Always `"2.0"`
- `method`: MCP method name (e.g., `tools/call`, `tools/list`)
- `params`: Method-specific parameters
- `id`: Request identifier for matching responses

### Response Format

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": {
    "content": [
      {
        "type": "text",
        "text": "Tool execution result..."
      }
    ]
  }
}
```

**Fields:**
- `jsonrpc`: Always `"2.0"`
- `id`: Matches the request ID
- `result`: Tool execution result with content array

### Error Format

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "error": {
    "code": -32603,
    "message": "Internal error: ..."
  }
}
```

**Error Codes:**
- `-32700`: Parse error
- `-32600`: Invalid Request
- `-32601`: Method not found
- `-32602`: Invalid params
- `-32603`: Internal error
- `-32000`: Server error (custom)

## MCP Methods

### 1. `initialize`

Initialize MCP connection and exchange capabilities.

**Request:**
```json
{
  "jsonrpc": "2.0",
  "method": "initialize",
  "params": {
    "protocolVersion": "2024-11-05",
    "capabilities": {},
    "clientInfo": {
      "name": "support-agent",
      "version": "1.0.0"
    }
  },
  "id": 1
}
```

### 2. `tools/list`

List all available tools on the MCP server.

**Request:**
```json
{
  "jsonrpc": "2.0",
  "method": "tools/list",
  "params": {},
  "id": 2
}
```

**Response:**
```json
{
  "jsonrpc": "2.0",
  "id": 2,
  "result": {
    "tools": [
      {
        "name": "search_products",
        "description": "Search for products using semantic search",
        "inputSchema": {
          "type": "object",
          "properties": {
            "query": {
              "type": "string",
              "description": "Search query"
            },
            "limit": {
              "type": "integer",
              "description": "Maximum number of results"
            }
          },
          "required": ["query"]
        }
      }
    ]
  }
}
```

### 3. `tools/call`

Execute a specific tool with arguments.

**Request:**
```json
{
  "jsonrpc": "2.0",
  "method": "tools/call",
  "params": {
    "name": "search_products",
    "arguments": {
      "query": "organic products",
      "limit": 10
    }
  },
  "id": 3
}
```

**Response:**
```json
{
  "jsonrpc": "2.0",
  "id": 3,
  "result": {
    "content": [
      {
        "type": "text",
        "text": "Found 10 product(s) matching 'organic products':\n---\nID: VG002\nName: Organic Carrots 1kg\n..."
      }
    ]
  }
}
```

### 4. `resources/list`

List available resources (optional).

### 5. `prompts/list`

List available prompts (optional).

## MCP Endpoints

All MCP servers expose:

- `POST /mcp` - Main JSON-RPC 2.0 endpoint
- `GET /mcp` - Server discovery (optional auth)
- `GET /health` - Health check

## FastMCP Implementation

Google ADK's FastMCP simplifies MCP server implementation:

### Tool Definition

```python
from fastmcp import FastMCP

mcp = FastMCP("Product Catalogue")

@mcp.tool()
def search_products(query: str, limit: int = 10) -> str:
    """
    Search for products using semantic search.
    
    Args:
        query: Search query string
        limit: Maximum number of results
    
    Returns:
        Formatted product list
    """
    # Implementation
    results = vector_db.search(query, limit=limit)
    return format_results(results)
```

### Protocol Handling

FastMCP automatically:
- Generates JSON-RPC 2.0 request/response formatting
- Validates tool arguments against schemas
- Handles error responses
- Provides tool discovery via `tools/list`

## Agent Tool Wrapper

The Support Agent wraps MCP calls:

```python
async def _call_mcp_tool_jsonrpc(
    tool_name: str, 
    arguments: Dict[str, Any], 
    mcp_url: str = None
) -> Dict[str, Any]:
    """
    Call MCP tool via JSON-RPC 2.0.
    
    Args:
        tool_name: Name of the tool to call
        arguments: Tool arguments
        mcp_url: MCP server URL
    
    Returns:
        Tool execution result
    """
    # Get MCP_AUTH_TOKEN from environment
    token = os.getenv("MCP_AUTH_TOKEN")
    
    # Format JSON-RPC 2.0 request
    request = {
        "jsonrpc": "2.0",
        "method": "tools/call",
        "params": {
            "name": tool_name,
            "arguments": arguments
        },
        "id": generate_request_id()
    }
    
    # Call MCP server /mcp endpoint
    response = await http_client.post(
        f"{mcp_url}/mcp",
        json=request,
        headers={"Authorization": f"Bearer {token}"}
    )
    
    # Parse JSON-RPC 2.0 response
    return response.json()
```

## Error Handling

### JSON-RPC 2.0 Error Codes

```python
# Parse error
-32700: "Parse error"

# Invalid Request
-32600: "Invalid Request"

# Method not found
-32601: "Method not found"

# Invalid params
-32602: "Invalid params"

# Internal error
-32603: "Internal error"

# Server error (custom)
-32000: "Server error"
```

### Error Response Example

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "error": {
    "code": -32602,
    "message": "Invalid params: 'limit' must be a positive integer"
  }
}
```

## Tool Examples

### Product Catalogue Tools

**Search Products:**
```bash
curl -X POST https://mcp-product-catalogue-xxx.run.app/mcp \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer SERVICE_ACCOUNT_TOKEN" \
  -d '{
    "jsonrpc": "2.0",
    "method": "tools/call",
    "params": {
      "name": "search_products",
      "arguments": {
        "query": "organic products",
        "limit": 10
      }
    },
    "id": 1
  }'
```

**Get Product:**
```bash
curl -X POST https://mcp-product-catalogue-xxx.run.app/mcp \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer SERVICE_ACCOUNT_TOKEN" \
  -d '{
    "jsonrpc": "2.0",
    "method": "tools/call",
    "params": {
      "name": "get_product",
      "arguments": {
        "product_id": "FR001"
      }
    },
    "id": 2
  }'
```

### CRM Tools

**Search Customer:**
```bash
curl -X POST https://mcp-crm-xxx.run.app/mcp \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer SERVICE_ACCOUNT_TOKEN" \
  -d '{
    "jsonrpc": "2.0",
    "method": "tools/call",
    "params": {
      "name": "search_customer_by_email",
      "arguments": {
        "email": "bobypt@gmail.com",
        "limit": 1
      }
    },
    "id": 3
  }'
```

**Create Customer:**
```bash
curl -X POST https://mcp-crm-xxx.run.app/mcp \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer SERVICE_ACCOUNT_TOKEN" \
  -d '{
    "jsonrpc": "2.0",
    "method": "tools/call",
    "params": {
      "name": "create_customer_in_crm",
      "arguments": {
        "email": "bobypt@gmail.com",
        "firstName": "Boby",
        "lastName": "Thomas",
        "phone": "041234512345"
      }
    },
    "id": 4
  }'
```

## Best Practices

1. **Always include request IDs** for matching responses
2. **Validate tool arguments** before execution
3. **Return structured error messages** with appropriate codes
4. **Use type-safe tool definitions** with FastMCP
5. **Handle network errors** with retries and timeouts
6. **Log all MCP calls** for debugging and monitoring

## Next Steps

In the next article, we'll explore **Agent Architecture**, covering tool definitions, prompt design, and agent interaction patterns.

