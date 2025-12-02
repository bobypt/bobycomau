---
title: Building MCP Servers
layout: agentic
permalink: /ai/building-mcp-servers
series: "Build and Maintain a Reliable Secure AI Agent in the Cloud"
sequence: 7
tags: [ai, mcp, servers, fastmcp, implementation]
status: published
short_summary: Implementation guide for building Product Catalogue and CRM MCP servers
---

# Building MCP Servers

This article covers building MCP servers using FastMCP, including the Product Catalogue MCP (with LanceDB) and CRM MCP (with Firestore).

## Product Catalogue MCP

### Project Structure

```
mcp-product-catalogue/
├── app/
│   ├── __init__.py
│   ├── main.py              # FastAPI application
│   ├── mcp_server.py       # FastMCP server
│   ├── database.py         # LanceDB connection
│   └── auth.py              # Authentication
├── requirements.txt
├── Dockerfile
└── README.md
```

### Dependencies

```txt
fastapi==0.104.1
uvicorn==0.24.0
fastmcp==0.1.0
lance==0.1.0
firebase-admin==6.2.0
python-dotenv==1.0.0
```

### FastMCP Server Implementation

```python
from fastmcp import FastMCP
from app.database import get_vector_db
from app.auth import verify_service_token

mcp = FastMCP("Product Catalogue")

@mcp.tool()
def search_products(query: str, limit: int = 10) -> str:
    """
    Search for products using semantic search.
    
    Args:
        query: Search query string (e.g., "organic products")
        limit: Maximum number of results (default: 10)
    
    Returns:
        Formatted product list
    """
    vector_db = get_vector_db()
    results = vector_db.search(query, limit=limit)
    
    if not results:
        return f"No products found matching '{query}'."
    
    formatted = f"Found {len(results)} product(s) matching '{query}':\n"
    formatted += "---\n"
    
    for product in results:
        formatted += f"ID: {product['id']}\n"
        formatted += f"Name: {product['name']}\n"
        formatted += f"Price: ${product['price']}\n"
        formatted += f"Category: {product['category']}\n"
        formatted += "---\n"
    
    return formatted

@mcp.tool()
def get_product(product_id: str) -> str:
    """
    Get detailed information about a specific product.
    
    Args:
        product_id: Product identifier (e.g., "FR001")
    
    Returns:
        Product details
    """
    vector_db = get_vector_db()
    product = vector_db.get_by_id(product_id)
    
    if not product:
        return f"Product '{product_id}' not found."
    
    return f"""Product Details:
ID: {product['id']}
Name: {product['name']}
Price: ${product['price']}
Category: {product['category']}
Description: {product.get('description', 'N/A')}
Stock: {product.get('stock', 'N/A')}
"""

@mcp.tool()
def list_products(limit: int = 20) -> str:
    """
    List all available products.
    
    Args:
        limit: Maximum number of results (default: 20)
    
    Returns:
        Formatted product list
    """
    vector_db = get_vector_db()
    products = vector_db.list_all(limit=limit)
    
    if not products:
        return "No products available."
    
    formatted = f"Available Products ({len(products)}):\n"
    formatted += "---\n"
    
    for product in products:
        formatted += f"ID: {product['id']} - {product['name']} (${product['price']})\n"
    
    return formatted
```

### FastAPI Integration

```python
from fastapi import FastAPI, Depends
from fastapi.middleware.cors import CORSMiddleware
from app.mcp_server import mcp
from app.auth import verify_service_token

app = FastAPI(title="Product Catalogue MCP")

@app.get("/health")
async def health_check():
    return {"status": "healthy", "service": "product-catalogue-mcp"}

@app.post("/mcp")
async def mcp_endpoint(
    request: dict,
    user: dict = Depends(verify_service_token)
):
    """Handle MCP JSON-RPC 2.0 requests."""
    return await mcp.handle_request(request)
```

### LanceDB Integration

```python
import lance
from typing import List, Dict

_vector_db = None

def get_vector_db():
    """Get or initialize vector database."""
    global _vector_db
    if _vector_db is None:
        _vector_db = lance.connect(
            os.getenv("LANCE_DB_PATH", "/data/products.lance")
        )
    return _vector_db

class VectorDB:
    def __init__(self, path: str):
        self.table = lance.open_table(path)
    
    def search(self, query: str, limit: int = 10) -> List[Dict]:
        """Semantic search using vector embeddings."""
        # Generate query embedding
        query_embedding = generate_embedding(query)
        
        # Search using cosine similarity
        results = self.table.search(query_embedding).limit(limit).to_pylist()
        return results
    
    def get_by_id(self, product_id: str) -> Dict:
        """Get product by ID."""
        results = self.table.search({"id": product_id}).limit(1).to_pylist()
        return results[0] if results else None
    
    def list_all(self, limit: int = 20) -> List[Dict]:
        """List all products."""
        return self.table.to_pylist()[:limit]
```

## CRM MCP

### Project Structure

```
mcp-crm/
├── app/
│   ├── __init__.py
│   ├── main.py              # FastAPI application
│   ├── mcp_server.py       # FastMCP server
│   ├── database.py         # Firestore connection
│   └── auth.py              # Authentication
├── requirements.txt
├── Dockerfile
└── README.md
```

### Dependencies

```txt
fastapi==0.104.1
uvicorn==0.24.0
fastmcp==0.1.0
google-cloud-firestore==2.13.0
firebase-admin==6.2.0
python-dotenv==1.0.0
```

### FastMCP Server Implementation

```python
from fastmcp import FastMCP
from app.database import get_firestore_db
from app.auth import verify_service_token

mcp = FastMCP("CRM")

@mcp.tool()
def search_customer_by_email(email: str, limit: int = 1) -> str:
    """
    Find customer records by email address.
    
    Args:
        email: Customer email address
        limit: Maximum number of results (default: 1)
    
    Returns:
        Customer record if found
    """
    db = get_firestore_db()
    customers_ref = db.collection("crm_contacts")
    query = customers_ref.where("email", "==", email).limit(limit)
    results = query.stream()
    
    customers = [doc.to_dict() for doc in results]
    
    if not customers:
        return f"No customers found matching '{email}'."
    
    customer = customers[0]
    return format_customer(customer)

@mcp.tool()
def get_customer_by_id(customer_id: str) -> str:
    """
    Get customer details by ID.
    
    Args:
        customer_id: Customer identifier
    
    Returns:
        Customer record
    """
    db = get_firestore_db()
    doc_ref = db.collection("crm_contacts").document(customer_id)
    doc = doc_ref.get()
    
    if not doc.exists:
        return f"Customer '{customer_id}' not found."
    
    return format_customer(doc.to_dict())

@mcp.tool()
def create_customer_in_crm(
    email: str,
    firstName: str = None,
    lastName: str = None,
    phone: str = None
) -> str:
    """
    Create a new customer record.
    
    Args:
        email: Customer email (required)
        firstName: First name
        lastName: Last name
        phone: Phone number
    
    Returns:
        Created customer record
    """
    db = get_firestore_db()
    now = datetime.utcnow()
    
    customer_data = {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "createdAt": now,
        "updatedAt": now,
        "metadata": {}
    }
    
    # Remove None values
    customer_data = {k: v for k, v in customer_data.items() if v is not None}
    
    doc_ref = db.collection("crm_contacts").add(customer_data)
    customer_id = doc_ref[1].id
    
    # Update with ID
    doc_ref[1].update({"id": customer_id})
    
    customer = doc_ref[1].get().to_dict()
    return f"Customer created successfully:\n{format_customer(customer)}"

@mcp.tool()
def update_customer_in_crm(
    customer_id: str,
    firstName: str = None,
    lastName: str = None,
    email: str = None,
    phone: str = None
) -> str:
    """
    Update an existing customer record.
    
    Args:
        customer_id: Customer identifier
        firstName: First name
        lastName: Last name
        email: Email address
        phone: Phone number
    
    Returns:
        Updated customer record
    """
    db = get_firestore_db()
    doc_ref = db.collection("crm_contacts").document(customer_id)
    doc = doc_ref.get()
    
    if not doc.exists:
        return f"Customer '{customer_id}' not found."
    
    update_data = {
        "updatedAt": datetime.utcnow()
    }
    
    if firstName is not None:
        update_data["firstName"] = firstName
    if lastName is not None:
        update_data["lastName"] = lastName
    if email is not None:
        update_data["email"] = email
    if phone is not None:
        update_data["phone"] = phone
    
    doc_ref.update(update_data)
    updated_customer = doc_ref.get().to_dict()
    
    return f"Customer updated successfully:\n{format_customer(updated_customer)}"

def format_customer(customer: dict) -> str:
    """Format customer record for display."""
    return f"""ID: {customer.get('id', 'N/A')}
Name: {customer.get('firstName', '')} {customer.get('lastName', '')}
First Name: {customer.get('firstName', 'N/A')}
Last Name: {customer.get('lastName', 'N/A')}
Email: {customer.get('email', 'N/A')}
Phone: {customer.get('phone', 'N/A')}
Created: {customer.get('createdAt', 'N/A')}
Updated: {customer.get('updatedAt', 'N/A')}
"""
```

### Firestore Integration

```python
from google.cloud import firestore
import os

_firestore_db = None

def get_firestore_db():
    """Get or initialize Firestore database."""
    global _firestore_db
    if _firestore_db is None:
        _firestore_db = firestore.Client(
            project=os.getenv("GOOGLE_CLOUD_PROJECT")
        )
    return _firestore_db
```

## Authentication

Both MCP servers use the same authentication pattern:

```python
from firebase_admin import auth
from fastapi import HTTPException, Depends
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials

security = HTTPBearer()

async def verify_service_token(
    credentials: HTTPAuthorizationCredentials = Depends(security)
):
    """Verify service account token."""
    try:
        token = credentials.credentials
        decoded_token = auth.verify_id_token(token)
        
        # Check if it's a service account token
        issuer = decoded_token.get("iss", "")
        if not issuer.endswith(".iam.gserviceaccount.com"):
            raise HTTPException(
                status_code=403,
                detail="Service account token required"
            )
        
        return decoded_token
    except Exception as e:
        raise HTTPException(
            status_code=401,
            detail=f"Invalid token: {str(e)}"
        )
```

## Testing

### Test Product Catalogue MCP

```bash
curl -X POST http://localhost:8000/mcp \
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

### Test CRM MCP

```bash
curl -X POST http://localhost:8000/mcp \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer SERVICE_ACCOUNT_TOKEN" \
  -d '{
    "jsonrpc": "2.0",
    "method": "tools/call",
    "params": {
      "name": "create_customer_in_crm",
      "arguments": {
        "email": "test@example.com",
        "firstName": "Test",
        "lastName": "User",
        "phone": "0412345678"
      }
    },
    "id": 1
  }'
```

## Next Steps

In the next article, we'll cover **Deployment Architecture**, including local Docker Compose setup and cloud deployment preparation.

