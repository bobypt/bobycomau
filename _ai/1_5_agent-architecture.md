---
title: Agent Architecture
layout: agentic
permalink: /ai/agent-architecture
series: "Build and Maintain a Reliable Secure AI Agent in the Cloud"
sequence: 5
tags: [ai, agents, architecture, tools, prompts]
status: published
short_summary: Agent tools, prompt design, and interaction patterns
---

# Agent Architecture

This article covers the architecture of the Support Agent, including available tools, prompt design, and interaction patterns.

## Agent Tools

The support agent has access to the following tools, organized by MCP server:

### Product Catalogue Tools

#### `search_products(query, limit)`
Semantic search for products using vector embeddings.

**Parameters:**
- `query` (string, required): Search query (e.g., "organic products")
- `limit` (integer, optional): Maximum number of results (default: 10)

**Returns:** Formatted list of matching products

**Example:**
```python
search_products("organic fruits", limit=5)
```

#### `get_product(product_id)`
Get detailed information about a specific product.

**Parameters:**
- `product_id` (string, required): Product identifier (e.g., "FR001")

**Returns:** Product details including name, price, description

**Example:**
```python
get_product("FR001")
```

#### `list_products(limit)`
List all available products.

**Parameters:**
- `limit` (integer, optional): Maximum number of results (default: 20)

**Returns:** Formatted list of products

**Example:**
```python
list_products(limit=20)
```

### CRM Tools

#### `search_customer_by_email(email, limit)`
Find customer records by email address.

**Parameters:**
- `email` (string, required): Customer email address
- `limit` (integer, optional): Maximum number of results (default: 1)

**Returns:** Customer record if found, empty if not found

**Example:**
```python
search_customer_by_email("bobypt@gmail.com", limit=1)
```

#### `get_customer_by_id(customer_id)`
Get customer details by ID.

**Parameters:**
- `customer_id` (string, required): Customer identifier

**Returns:** Complete customer record

**Example:**
```python
get_customer_by_id("gsl5K9oSni09Lf8DFoGF")
```

#### `create_customer_in_crm(email, firstName, lastName, phone)`
Create a new customer record.

**Parameters:**
- `email` (string, required): Customer email
- `firstName` (string, optional): First name
- `lastName` (string, optional): Last name
- `phone` (string, optional): Phone number

**Returns:** Created customer record with ID

**Example:**
```python
create_customer_in_crm(
    email="bobypt@gmail.com",
    firstName="Boby",
    lastName="Thomas",
    phone="041234512345"
)
```

#### `update_customer_in_crm(customer_id, firstName, lastName, email, phone)`
Update an existing customer record.

**Parameters:**
- `customer_id` (string, required): Customer identifier
- `firstName` (string, optional): First name
- `lastName` (string, optional): Last name
- `email` (string, optional): Email address
- `phone` (string, optional): Phone number

**Returns:** Updated customer record

**Example:**
```python
update_customer_in_crm(
    customer_id="gsl5K9oSni09Lf8DFoGF",
    firstName="Boby",
    lastName="Thomas",
    phone="041234512345"
)
```

## Agent Prompt Flow

The agent follows a structured conversation flow for order processing:

### 1. Product Discovery

**User asks about products:**
- User: "Do you sell organic products?"
- Agent uses `search_products` tool
- Presents results to user with product details

**Example Interaction:**
```
User: "Do you sell organic products?"
Agent: [Calls search_products("organic products", limit=10)]
Agent: "Yes, we do! We have a variety of organic products including:
       - Organic Gala Apples (FR001)
       - Organic Carrots 1kg (VG002)
       ..."
```

### 2. Order Collection

**User selects products:**
- User: "can I have a Kg of Organic Gala Apples?"
- Agent adds product to order
- Shows current order summary

**Agent collects customer details one by one:**
- Email (required)
- First name
- Last name
- Phone number
- Delivery address

**Example Flow:**
```
Agent: "I've added 1kg of Organic Gala Apples to your order. 
        Would you like to add anything else?"
User: "no"
Agent: "Great! To complete your order, I'll need some information.
        What's your email address?"
User: "bobypt@gmail.com"
Agent: "Thanks! What's your first name?"
User: "Boby"
Agent: "And your last name?"
User: "Thomas"
Agent: "What's your phone number?"
User: "041234512345"
Agent: "Finally, what's your delivery address?"
User: "123 some street, Melbourne, VIC-3000"
```

### 3. Order Confirmation

**Agent shows final summary:**
- Lists all products in order
- Shows customer details
- Displays delivery address
- Asks for confirmation

**Example:**
```
Agent: "Here's your order summary:
        
        Products:
        - 1kg Organic Gala Apples
        
        Customer Details:
        - Name: Boby Thomas
        - Email: bobypt@gmail.com
        - Phone: 041234512345
        
        Delivery Address:
        123 some street, Melbourne, VIC-3000
        
        Would you like to confirm this order?"
```

### 4. CRM Update (after confirmation)

**Agent searches for customer:**
- Calls `search_customer_by_email` with customer email
- If found: Updates customer record with `update_customer_in_crm`
- If not found: Creates new customer with `create_customer_in_crm`

**Example:**
```
User: "yes" (confirms order)
Agent: [Calls search_customer_by_email("bobypt@gmail.com")]
Agent: [Customer not found]
Agent: [Calls create_customer_in_crm(...)]
Agent: "Perfect! Your order has been confirmed and your customer 
        information has been saved. Your order ID is ORD-12345."
```

## Agent Configuration

### Google ADK Setup

```python
from google.adk import Agent

agent = Agent(
    model="gemini-2.5-flash",
    tools=[
        search_products,
        get_product,
        list_products,
        search_customer_by_email,
        get_customer_by_id,
        create_customer_in_crm,
        update_customer_in_crm
    ],
    system_instruction="You are a helpful support agent for an online grocery store..."
)
```

### System Instruction

The agent uses a system instruction that defines:
- Role and personality
- Available tools and their purposes
- Conversation flow guidelines
- Error handling instructions

**Example System Instruction:**
```
You are a helpful support agent for an online grocery store. 
Your role is to:
1. Help customers find products using semantic search
2. Collect order information (products, customer details, delivery address)
3. Confirm orders before processing
4. Update customer records in the CRM system

Always be friendly, clear, and concise. Ask for information one piece at a time.
```

## Session Management

### Conversation State

The agent maintains conversation state:
- **Conversation ID**: Unique identifier per conversation
- **Order State**: Current products in order
- **Customer State**: Collected customer information
- **Conversation History**: Previous messages for context

### State Management

```python
class ConversationState:
    conversation_id: str
    order_items: List[OrderItem]
    customer_email: Optional[str]
    customer_first_name: Optional[str]
    customer_last_name: Optional[str]
    customer_phone: Optional[str]
    delivery_address: Optional[str]
    conversation_history: List[Message]
```

## Error Handling

### Tool Execution Errors

When a tool call fails:
1. Agent receives error response from MCP server
2. Agent explains error to user in friendly terms
3. Agent suggests alternative actions

**Example:**
```
Agent: [Calls search_products("invalid query")]
MCP Server: [Returns error: "Invalid query format"]
Agent: "I'm sorry, I couldn't search for that. Could you try 
        rephrasing your search? For example, 'organic fruits' 
        or 'fresh vegetables'."
```

### Network Errors

When MCP server is unavailable:
1. Agent detects connection failure
2. Agent informs user of temporary issue
3. Agent suggests retrying later

## Best Practices

1. **Clear Tool Descriptions**: Each tool should have a clear description of its purpose
2. **Progressive Information Gathering**: Collect information one piece at a time
3. **Confirmation Steps**: Always confirm orders before processing
4. **Error Recovery**: Provide helpful error messages and suggestions
5. **Context Preservation**: Maintain conversation history for context
6. **Tool Selection**: Use the most appropriate tool for each task

## Next Steps

In the next article, we'll dive into **Building the Support Agent**, covering implementation details with Google ADK, FastAPI, and token management.

