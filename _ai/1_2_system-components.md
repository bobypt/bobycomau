---
title: System Components
layout: agentic
permalink: /ai/system-components
series: "Build and Maintain a Reliable Secure AI Agent in the Cloud"
sequence: 2
tags: [ai, components, microservices, architecture]
status: published
short_summary: Deep dive into Support Agent, Product Catalogue MCP, and CRM MCP
---

# System Components

This article explores the three main components of our AI agent system: the Support Agent and two MCP servers (Product Catalogue and CRM).

## 1. Support Agent (`support-agent-adk`)

The Support Agent is the orchestrator that handles user conversations and coordinates with backend services.

### Technology Stack

- **Framework**: FastAPI (Python web framework)
- **AI Engine**: Google ADK (Agent Development Kit)
- **LLM Model**: Gemini 2.5 Flash
- **Authentication**: Firebase Admin SDK

### Key Features

#### Conversational AI Agent
- Processes natural language user messages
- Maintains conversation context across multiple turns
- Uses Gemini 2.5 Flash for reasoning and response generation

#### Token Exchange
- Validates user Firebase tokens
- Generates service account tokens for MCP calls
- Auto-refreshes tokens when expiring (within 5 minutes)

#### MCP Client
- Makes JSON-RPC 2.0 calls to MCP servers
- Handles tool discovery and execution
- Manages error responses and retries

#### Session Management
- Tracks conversation state per user
- Maintains conversation history
- Generates unique conversation IDs

### Location
`agents/support-agent-adk/`

### API Endpoints

**Base URL:**
- Local: `http://localhost:8000`
- Cloudrun url: `https://agent-order-receiver-bd66ql2x7q-ts.a.run.app`

**Key Endpoints:**
- `GET /health` - Health check
- `POST /process` - Process user message

## 2. Product Catalogue MCP (`mcp-product-catalogue`)

The Product Catalogue MCP provides semantic search and product retrieval capabilities.

### Technology Stack

- **Framework**: FastAPI
- **MCP Protocol**: FastMCP (Google ADK)
- **Database**: LanceDB (vector database)
- **Authentication**: Firebase Admin SDK

### Key Features

#### Semantic/Vector Search
- Uses embeddings for natural language product queries
- Returns relevant products based on semantic similarity
- Supports queries like "organic products" or "fresh vegetables"

#### Product Operations
- `search_products(query, limit)` - Semantic search
- `get_product(product_id)` - Get product details
- `list_products(limit)` - List all products

#### JSON-RPC 2.0 Protocol
- Standardized MCP protocol implementation
- Tool discovery via `tools/list`
- Tool execution via `tools/call`

### Location
`mcp/mcp-product-catalogue/`

### API Endpoints

**Base URL:**
- Local: `http://localhost:8000`
- Cloud: `https://mcp-product-catalogue-bd66ql2x7q-ts.a.run.app`

**Key Endpoints:**
- `GET /health` - Health check
- `POST /mcp` - MCP JSON-RPC 2.0 endpoint

## 3. CRM MCP (`mcp-crm`)

The CRM MCP manages customer data operations.

### Technology Stack

- **Framework**: FastAPI
- **MCP Protocol**: FastMCP (Google ADK)
- **Database**: Google Firestore (NoSQL database)
- **Authentication**: Firebase Admin SDK

### Key Features

#### Customer CRUD Operations
- `search_customer_by_email(email, limit)` - Find customer by email
- `get_customer_by_id(customer_id)` - Get customer details
- `create_customer_in_crm(email, firstName, lastName, phone)` - Create customer
- `update_customer_in_crm(customer_id, firstName, lastName, email, phone)` - Update customer

#### Customer Search
- Search by email, phone, or name
- Returns matching customer records
- Supports pagination via limit parameter

#### JSON-RPC 2.0 Protocol
- Standardized MCP protocol implementation
- Consistent error handling
- Type-safe tool definitions

### Location
`mcp/mcp-crm/`

### API Endpoints

**Base URL:**
- Local: `http://localhost:8000`
- Cloud: `https://mcp-crm-bd66ql2x7q-ts.a.run.app`

**Key Endpoints:**
- `GET /health` - Health check
- `POST /mcp` - MCP JSON-RPC 2.0 endpoint

## Component Interaction Flow

<img src="{{ '/images/ai/component_interaction.svg' | relative_url }}" alt="Component interaction" class="ai-hero" />

```mermaid
graph TD
    A[User Message] --> B[Support Agent<br/>Validates User Token]
    B --> C[Support Agent<br/>Generates Service Account Token]
    C --> D[MCP Server<br/>Validates Service Account Token]
    D --> E[MCP Server<br/>Executes Tool, Queries Database]
    E --> F[MCP Server<br/>Returns JSON-RPC 2.0 Response]
    F --> G[Support Agent<br/>Processes Response, Generates Reply]
    G --> H[User Receives Response]
    
    P1[POST /process<br/>Authorization: Bearer token<br/>Body: message, conversation_id] 
    P2[POST /mcp<br/>Authorization: Bearer service_token<br/>JSON-RPC 2.0: tools/call]
    P3[200 OK<br/>JSON-RPC 2.0 Response<br/>result with content]
    P4[200 OK<br/>Response: message<br/>conversation_id]
    
    B -.->|HTTP Request| P1
    C -.->|HTTP Request| P2
    F -.->|HTTP Response| P3
    G -.->|HTTP Response| P4
    
    style A fill:#2563eb,stroke:#1e40af,stroke-width:2px,color:#fff
    style B fill:#f59e0b,stroke:#d97706,stroke-width:2px,color:#fff
    style C fill:#f59e0b,stroke:#d97706,stroke-width:2px,color:#fff
    style D fill:#10b981,stroke:#059669,stroke-width:2px,color:#fff
    style E fill:#10b981,stroke:#059669,stroke-width:2px,color:#fff
    style F fill:#10b981,stroke:#059669,stroke-width:2px,color:#fff
    style G fill:#f59e0b,stroke:#d97706,stroke-width:2px,color:#fff
    style H fill:#2563eb,stroke:#1e40af,stroke-width:2px,color:#fff
    
    style P1 fill:#f9fafb,stroke:#6b7280,stroke-width:2px,stroke-dasharray: 5 5,color:#000
    style P2 fill:#f9fafb,stroke:#6b7280,stroke-width:2px,stroke-dasharray: 5 5,color:#000
    style P3 fill:#f9fafb,stroke:#6b7280,stroke-width:2px,stroke-dasharray: 5 5,color:#000
    style P4 fill:#f9fafb,stroke:#6b7280,stroke-width:2px,stroke-dasharray: 5 5,color:#000
    
    linkStyle 0 stroke:#ffffff,stroke-width:2px
    linkStyle 1 stroke:#ffffff,stroke-width:2px
    linkStyle 2 stroke:#ffffff,stroke-width:2px
    linkStyle 3 stroke:#ffffff,stroke-width:2px
    linkStyle 4 stroke:#ffffff,stroke-width:2px
    linkStyle 5 stroke:#ffffff,stroke-width:2px
    linkStyle 6 stroke:#ffffff,stroke-width:2px
    linkStyle 7 stroke:#999999,stroke-width:1px,stroke-dasharray: 3 3
    linkStyle 8 stroke:#999999,stroke-width:1px,stroke-dasharray: 3 3
    linkStyle 9 stroke:#999999,stroke-width:1px,stroke-dasharray: 3 3
    linkStyle 10 stroke:#999999,stroke-width:1px,stroke-dasharray: 3 3
```

### HTTP Payload Examples

**1. User Request to Support Agent:**
```bash
curl -X POST https://agent-order-receiver-xxx.run.app/process \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer USER_FIREBASE_TOKEN" \
  -d '{
    "message": "Do you sell organic products?",
    "conversation_id": "conv-123",
    "conversation_history": []
  }'
```

**2. Support Agent to MCP Server (JSON-RPC 2.0):**
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

**3. MCP Server Response (JSON-RPC 2.0):**
```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": {
    "content": [
      {
        "type": "text",
        "text": "Found 10 product(s) matching 'organic products':\n---\nID: FR001\nName: Organic Gala Apples\n..."
      }
    ]
  }
}
```

**4. Support Agent Response to User:**
```json
{
  "response": "Yes, we do! We have a variety of organic products including:\n- Organic Gala Apples (FR001)\n- Organic Carrots 1kg (VG002)\n...",
  "conversation_id": "conv-123"
}
```

**ASCII Flow (for reference):**

```
User Message
    ↓
Support Agent (validates user token)
    ↓
Support Agent (generates service account token)
    ↓
Support Agent (calls MCP server via JSON-RPC 2.0)
    ↓
MCP Server (validates service account token)
    ↓
MCP Server (executes tool, queries database)
    ↓
MCP Server (returns JSON-RPC 2.0 response)
    ↓
Support Agent (processes response, generates user reply)
    ↓
User receives response
```

## Database Schemas

### Firestore (CRM)
**Collection:** `crm_contacts`

```json
{
  "id": "gsl5K9oSni09Lf8DFoGF",
  "email": "bobypt@gmail.com",
  "firstName": "Boby",
  "lastName": "Thomas",
  "phone": "041234512345",
  "createdAt": "2025-12-02T03:19:48.421779+00:00",
  "updatedAt": "2025-12-02T03:19:48.421779+00:00",
  "metadata": {}
}
```

### LanceDB (Product Catalogue)
**Table:** `products`

- Vector embeddings for semantic search
- Product metadata (name, price, category, etc.)
- Similarity search using cosine distance

## Next Steps

In the next article, we'll explore **Authentication & Authorization**, covering token exchange patterns, permission models, and security best practices.

