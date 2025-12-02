---
title: Architecture Overview
layout: agentic
permalink: /ai/architecture-overview
series: "Build and Maintain a Reliable Secure AI Agent in the Cloud"
sequence: 1
tags: [ai, architecture, cloud, agents]
status: published
short_summary: Understanding the microservices architecture for cloud-based AI agents
---

# Architecture Overview

This series walks through building a production-ready AI agent system deployed on Google Cloud Platform. We'll cover everything from architecture design to deployment, security, and monitoring.

## System Architecture

The system implements a microservices architecture with the following key components:

```mermaid
graph TD
    A[Web Client<br/>Next.js Frontend<br/>Firebase Auth] -->|Bearer Token<br/>User Firebase Token| B[Support Agent<br/>FastAPI<br/>Google ADK Agent<br/>Gemini 2.5 Flash<br/>Token Exchange: User → Service Token<br/>MCP Client JSON-RPC 2.0]
    
    B -->|MCP Calls| C[Product Catalogue MCP]
    B -->|MCP Calls| D[CRM MCP Server]
    B -->|MCP Calls| E[RAG MCP Server]
    
    C -->|Vector Search| F[LanceDB<br/>Vector Database]
    D -->|NoSQL Operations| G[Firestore<br/>NoSQL Database]
    E -->|Vector Operations| H[Vector Store]
    
    style A fill:#2563eb,stroke:#1e40af,stroke-width:2px,color:#fff
    style B fill:#f59e0b,stroke:#d97706,stroke-width:2px,color:#fff
    style C fill:#10b981,stroke:#059669,stroke-width:2px,color:#fff
    style D fill:#10b981,stroke:#059669,stroke-width:2px,color:#fff
    style E fill:#10b981,stroke:#059669,stroke-width:2px,color:#fff
    style F fill:#8b5cf6,stroke:#7c3aed,stroke-width:2px,color:#fff
    style G fill:#8b5cf6,stroke:#7c3aed,stroke-width:2px,color:#fff
    style H fill:#8b5cf6,stroke:#7c3aed,stroke-width:2px,color:#fff
    
    linkStyle 0 stroke:#ffffff,stroke-width:2px
    linkStyle 1 stroke:#ffffff,stroke-width:2px
    linkStyle 2 stroke:#ffffff,stroke-width:2px
    linkStyle 3 stroke:#ffffff,stroke-width:2px
    linkStyle 4 stroke:#ffffff,stroke-width:2px
    linkStyle 5 stroke:#ffffff,stroke-width:2px
```




## Key Design Patterns

### 1. Token Exchange Pattern

User Firebase tokens are validated, then the agent uses a service account token for MCP calls. This ensures:
- **User authentication**: End users authenticate via Firebase
- **Service-to-service security**: MCP servers verify service account tokens
- **Permission isolation**: User permissions are separate from service permissions

### 2. MCP (Model Context Protocol)

Standardized JSON-RPC 2.0 interface for agent-to-service communication:
- **Consistent interface**: All MCP servers follow the same protocol
- **Tool discovery**: Agents can discover available tools dynamically
- **Type safety**: Structured request/response formats

### 3. Microservice Architecture

Each MCP server is independently deployable and scalable:
- **Product Catalogue MCP**: Handles product search and retrieval
- **CRM MCP**: Manages customer data operations
- **Support Agent**: Orchestrates conversations and tool calls

### 4. FastMCP Integration

Uses Google ADK's FastMCP for tool definitions and protocol handling:
- **Type-safe tools**: Python decorators define tool schemas
- **Automatic protocol handling**: JSON-RPC 2.0 formatting handled automatically
- **Error handling**: Built-in error response formatting

## Technology Stack

- **Frontend**: Next.js with Firebase Authentication
- **Support Agent**: FastAPI + Google ADK (Gemini 2.5 Flash)
- **MCP Servers**: FastAPI + FastMCP
- **Databases**: 
  - LanceDB (vector database for product search)
  - Firestore (NoSQL for CRM data)
- **Cloud Platform**: Google Cloud Platform
  - Cloud Run (containerized services)
  - Firebase (authentication, hosting)
  - Secret Manager (service account keys)

## What You'll Learn

Throughout this series, you'll learn:

1. **Architecture Design**: How to structure a cloud-native agent system
2. **Authentication & Security**: Token exchange patterns and permission models
3. **MCP Protocol**: Implementing standardized agent-to-service communication
4. **Agent Development**: Building agents with Google ADK
5. **MCP Server Development**: Creating scalable backend services
6. **Deployment**: Deploying to Cloud Run with proper configuration
7. **Monitoring & Maintenance**: Observability and troubleshooting strategies

## Next Steps

In the next article, we'll dive into the **System Components**, exploring each service in detail and understanding their responsibilities.

