---
title: Building the Support Agent
layout: agentic
permalink: /ai/building-support-agent
series: "Build and Maintain a Reliable Secure AI Agent in the Cloud"
sequence: 6
tags: [ai, agents, implementation, google-adk, fastapi]
status: published
short_summary: Implementation guide for building the Support Agent with Google ADK and FastAPI
---

# Building the Support Agent

This article provides a step-by-step guide to building the Support Agent using Google ADK, FastAPI, and Firebase authentication.

## Project Structure

```
support-agent-adk/
├── app/
│   ├── __init__.py
│   ├── main.py              # FastAPI application
│   ├── agent.py             # Agent initialization
│   ├── auth.py              # Authentication & token management
│   ├── mcp_client.py        # MCP client implementation
│   └── models.py            # Request/response models
├── requirements.txt
├── Dockerfile
└── README.md
```

## Dependencies

```txt
fastapi==0.104.1
uvicorn==0.24.0
google-adk==0.1.0
firebase-admin==6.2.0
httpx==0.25.0
python-dotenv==1.0.0
```

## Core Components

### 1. FastAPI Application

```python
from fastapi import FastAPI, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
from app.models import ProcessRequest, ProcessResponse
from app.agent import get_agent
from app.auth import verify_token

app = FastAPI(title="Support Agent")

# CORS configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=os.getenv("CORS_ORIGINS", "").split(","),
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/health")
async def health_check():
    return {
        "status": "healthy",
        "agent": "agent_order_receiver",
        "agent_initialized": True,
        "model": "gemini-2.5-flash"
    }

@app.post("/process")
async def process_message(
    request: ProcessRequest,
    user: dict = Depends(verify_token)
):
    agent = get_agent()
    response = await agent.process(
        message=request.message,
        conversation_id=request.conversation_id,
        history=request.conversation_history
    )
    return ProcessResponse(
        response=response.text,
        conversation_id=response.conversation_id
    )
```

### 2. Authentication Module

```python
import os
from datetime import datetime, timedelta
from threading import Lock
from firebase_admin import auth, initialize_app, credentials
from fastapi import HTTPException, Depends
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials

# Initialize Firebase Admin
cred = credentials.Certificate(
    os.getenv("FIREBASE_SERVICE_ACCOUNT_PATH")
)
initialize_app(cred)

security = HTTPBearer()

# Token cache with thread-safe locking
_token_cache = {
    "token": None,
    "expires_at": None
}
_token_lock = Lock()

def get_service_account_token():
    """Get or refresh service account token."""
    with _token_lock:
        now = datetime.utcnow()
        refresh_needed = (
            not _token_cache["token"] or
            not _token_cache["expires_at"] or
            _token_cache["expires_at"] <= (now + timedelta(minutes=5))
        )
        
        if refresh_needed:
            # Generate new token
            custom_token = auth.create_custom_token(
                os.getenv("FIREBASE_SERVICE_ACCOUNT_UID")
            )
            _token_cache["token"] = custom_token
            _token_cache["expires_at"] = now + timedelta(hours=1)
        
        return _token_cache["token"]

async def verify_token(
    credentials: HTTPAuthorizationCredentials = Depends(security)
):
    """Verify user Firebase token."""
    try:
        token = credentials.credentials
        decoded_token = auth.verify_id_token(token)
        return decoded_token
    except Exception as e:
        raise HTTPException(
            status_code=401,
            detail=f"Invalid token: {str(e)}"
        )
```

### 3. MCP Client

```python
import httpx
import os
from typing import Dict, Any

async def call_mcp_tool(
    tool_name: str,
    arguments: Dict[str, Any],
    mcp_url: str
) -> Dict[str, Any]:
    """Call MCP tool via JSON-RPC 2.0."""
    token = get_service_account_token()
    
    request = {
        "jsonrpc": "2.0",
        "method": "tools/call",
        "params": {
            "name": tool_name,
            "arguments": arguments
        },
        "id": generate_request_id()
    }
    
    async with httpx.AsyncClient() as client:
        response = await client.post(
            f"{mcp_url}/mcp",
            json=request,
            headers={"Authorization": f"Bearer {token}"},
            timeout=30.0
        )
        response.raise_for_status()
        return response.json()
```

### 4. Agent Initialization

```python
from google.adk import Agent
from app.mcp_client import call_mcp_tool
import os

_agent = None

def get_agent():
    """Get or initialize agent."""
    global _agent
    if _agent is None:
        _agent = Agent(
            model="gemini-2.5-flash",
            tools=[
                create_mcp_tool_wrapper("search_products", "catalogue"),
                create_mcp_tool_wrapper("get_product", "catalogue"),
                create_mcp_tool_wrapper("list_products", "catalogue"),
                create_mcp_tool_wrapper("search_customer_by_email", "crm"),
                create_mcp_tool_wrapper("get_customer_by_id", "crm"),
                create_mcp_tool_wrapper("create_customer_in_crm", "crm"),
                create_mcp_tool_wrapper("update_customer_in_crm", "crm"),
            ],
            system_instruction=get_system_instruction()
        )
    return _agent

def create_mcp_tool_wrapper(tool_name: str, mcp_type: str):
    """Create a tool wrapper that calls MCP server."""
    mcp_url = {
        "catalogue": os.getenv("CATALOGUE_MCP_URL"),
        "crm": os.getenv("CRM_MCP_URL")
    }[mcp_type]
    
    async def tool_wrapper(**kwargs):
        result = await call_mcp_tool(tool_name, kwargs, mcp_url)
        if "error" in result:
            raise Exception(result["error"]["message"])
        return result["result"]["content"][0]["text"]
    
    return tool_wrapper

def get_system_instruction():
    return """You are a helpful support agent for an online grocery store.
Your role is to:
1. Help customers find products using semantic search
2. Collect order information (products, customer details, delivery address)
3. Confirm orders before processing
4. Update customer records in the CRM system

Always be friendly, clear, and concise. Ask for information one piece at a time."""
```

## Environment Configuration

```bash
# .env
FIREBASE_PROJECT_ID=<PROJECT_ID>
FIREBASE_SERVICE_ACCOUNT_PATH=/app/common/auth/firebase-service-account.json
CATALOGUE_MCP_URL=https://mcp-product-catalogue-xxx.run.app
CRM_MCP_URL=https://mcp-crm-xxx.run.app
CORS_ORIGINS=https://<PROJECT_ID>.web.app,https://<PROJECT_ID>.firebaseapp.com
PORT=8000
DEBUG_HTTP=false
```

## Dockerfile

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ ./app/

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

## Testing Locally

### 1. Start the Agent

```bash
# Install dependencies
pip install -r requirements.txt

# Set environment variables
export FIREBASE_PROJECT_ID=<PROJECT_ID>
export CATALOGUE_MCP_URL=http://localhost:8001
export CRM_MCP_URL=http://localhost:8002

# Run the server
uvicorn app.main:app --reload --port 8000
```

### 2. Test Health Check

```bash
curl http://localhost:8000/health
```

### 3. Test Message Processing

```bash
curl -X POST http://localhost:8000/process \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_FIREBASE_TOKEN" \
  -d '{
    "message": "Do you sell organic products?",
    "conversation_history": []
  }'
```

## Error Handling

### Token Refresh Errors

```python
def get_service_account_token():
    try:
        # Token generation logic
        ...
    except Exception as e:
        logger.error(f"Failed to generate service account token: {e}")
        raise HTTPException(
            status_code=500,
            detail="Authentication service unavailable"
        )
```

### MCP Call Errors

```python
async def call_mcp_tool(...):
    try:
        response = await client.post(...)
        response.raise_for_status()
        return response.json()
    except httpx.HTTPError as e:
        logger.error(f"MCP call failed: {e}")
        raise HTTPException(
            status_code=502,
            detail="Backend service unavailable"
        )
```

## Monitoring

### Logging

```python
import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

# Log all requests
@app.middleware("http")
async def log_requests(request, call_next):
    logger.info(f"{request.method} {request.url}")
    response = await call_next(request)
    logger.info(f"Status: {response.status_code}")
    return response
```

### Metrics

Track:
- Request count
- Response times
- Error rates
- Token refresh frequency
- MCP call success rate

## Next Steps

In the next article, we'll cover **Building MCP Servers**, implementing the Product Catalogue and CRM MCP servers with FastMCP.

