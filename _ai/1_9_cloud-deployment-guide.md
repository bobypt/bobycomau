---
title: Cloud Deployment Guide
layout: agentic
permalink: /ai/cloud-deployment-guide
series: "Build and Maintain a Reliable Secure AI Agent in the Cloud"
sequence: 9
tags: [ai, deployment, gcp, cloud-run, firebase]
status: published
short_summary: Step-by-step guide for deploying AI agents to Google Cloud Platform
---

# Cloud Deployment Guide

This article provides a comprehensive step-by-step guide for deploying the entire AI agent system to Google Cloud Platform.

## Prerequisites

- Google Cloud Platform account
- `gcloud` CLI installed and configured
- Docker installed locally
- Firebase project created
- Service account with appropriate permissions

## Step 1: Set Up Firebase

### 1.1 Create Firebase Project

```bash
# Create Firebase project
firebase projects:create <PROJECT_ID>

# Set as default project
firebase use <PROJECT_ID>
```

### 1.2 Enable Firebase Authentication

1. Go to Firebase Console → Authentication
2. Enable Email/Password authentication
3. Configure authorized domains

### 1.3 Create Firestore Database

```bash
# Initialize Firestore
firebase init firestore

# Create database in production mode
# Select region (e.g., australia-southeast1)
```

### 1.4 Create Service Account

1. Go to Firebase Console → Project Settings → Service Accounts
2. Click "Generate New Private Key"
3. Save the JSON file securely
4. Upload to Secret Manager (see Step 2)

## Step 2: Set Up Secret Manager

### 2.1 Create Secret

```bash
# Create secret for Firebase service account
gcloud secrets create firebase-service-account \
  --data-file=./firebase-service-account.json \
  --project=<PROJECT_ID>
```

### 2.2 Grant Access

```bash
# Grant Cloud Run access to secret
gcloud secrets add-iam-policy-binding firebase-service-account \
  --member="serviceAccount:PROJECT_NUMBER-compute@developer.gserviceaccount.com" \
  --role="roles/secretmanager.secretAccessor" \
  --project=<PROJECT_ID>
```

## Step 3: Build and Push Docker Images

### 3.1 Configure Docker for GCP

```bash
# Configure Docker to use gcloud as credential helper
gcloud auth configure-docker
```

### 3.2 Build Images

```bash
# Build Product Catalogue MCP
cd mcp/mcp-product-catalogue
docker build -t gcr.io/<PROJECT_ID>/mcp-product-catalogue:latest .

# Build CRM MCP
cd ../mcp-crm
docker build -t gcr.io/<PROJECT_ID>/mcp-crm:latest .

# Build Support Agent
cd ../../agents/support-agent-adk
docker build -t gcr.io/<PROJECT_ID>/support-agent-adk:latest .
```

### 3.3 Push Images

```bash
# Push all images
docker push gcr.io/<PROJECT_ID>/mcp-product-catalogue:latest
docker push gcr.io/<PROJECT_ID>/mcp-crm:latest
docker push gcr.io/<PROJECT_ID>/support-agent-adk:latest
```

## Step 4: Deploy MCP Servers

### 4.1 Deploy Product Catalogue MCP

```bash
gcloud run deploy mcp-product-catalogue \
  --image gcr.io/<PROJECT_ID>/mcp-product-catalogue:latest \
  --platform managed \
  --region australia-southeast1 \
  --allow-unauthenticated \
  --set-env-vars FIREBASE_PROJECT_ID=<PROJECT_ID> \
  --set-env-vars GOOGLE_CLOUD_PROJECT=<PROJECT_ID> \
  --set-secrets FIREBASE_SERVICE_ACCOUNT=firebase-service-account:latest \
  --memory 512Mi \
  --cpu 1 \
  --min-instances 0 \
  --max-instances 10
```

**Note the service URL** from the output (e.g., `https://mcp-product-catalogue-xxx.run.app`)

### 4.2 Deploy CRM MCP

```bash
gcloud run deploy mcp-crm \
  --image gcr.io/<PROJECT_ID>/mcp-crm:latest \
  --platform managed \
  --region australia-southeast1 \
  --allow-unauthenticated \
  --set-env-vars FIREBASE_PROJECT_ID=<PROJECT_ID> \
  --set-env-vars GOOGLE_CLOUD_PROJECT=<PROJECT_ID> \
  --set-secrets FIREBASE_SERVICE_ACCOUNT=firebase-service-account:latest \
  --memory 512Mi \
  --cpu 1 \
  --min-instances 0 \
  --max-instances 10
```

**Note the service URL** from the output (e.g., `https://mcp-crm-xxx.run.app`)

## Step 5: Deploy Support Agent

```bash
gcloud run deploy agent-order-receiver \
  --image gcr.io/<PROJECT_ID>/support-agent-adk:latest \
  --platform managed \
  --region australia-southeast1 \
  --allow-unauthenticated \
  --set-env-vars FIREBASE_PROJECT_ID=<PROJECT_ID> \
  --set-env-vars CATALOGUE_MCP_URL=https://mcp-product-catalogue-xxx.run.app \
  --set-env-vars CRM_MCP_URL=https://mcp-crm-xxx.run.app \
  --set-env-vars CORS_ORIGINS=https://<PROJECT_ID>.web.app,https://<PROJECT_ID>.firebaseapp.com \
  --set-secrets FIREBASE_SERVICE_ACCOUNT=firebase-service-account:latest \
  --memory 1Gi \
  --cpu 2 \
  --min-instances 0 \
  --max-instances 10
```

**Note the service URL** from the output (e.g., `https://agent-order-receiver-xxx.run.app`)

## Step 6: Configure CORS

CORS is automatically configured via environment variables. Verify:

```bash
# Check Support Agent CORS
curl -H "Origin: https://<PROJECT_ID>.web.app" \
  -H "Access-Control-Request-Method: POST" \
  -H "Access-Control-Request-Headers: authorization" \
  -X OPTIONS \
  https://agent-order-receiver-xxx.run.app/process
```

## Step 7: Set Up Cloud Storage (for LanceDB)

### 7.1 Create Bucket

```bash
# Create bucket for LanceDB data
gsutil mb -p <PROJECT_ID> -c STANDARD -l australia-southeast1 gs://<PROJECT_ID>-lancedb
```

### 7.2 Upload Data

```bash
# Upload LanceDB data
gsutil -m cp -r ./data/lancedb/* gs://<PROJECT_ID>-lancedb/
```

## Step 8: Deploy Frontend (Optional)

### 8.1 Build Next.js App

```bash
cd frontend
npm run build
```

### 8.2 Deploy to Firebase Hosting

```bash
firebase deploy --only hosting
```

## Step 9: Test Deployment

### 9.1 Health Checks

```bash
# Test Support Agent
curl https://agent-order-receiver-xxx.run.app/health

# Test Product Catalogue MCP
curl https://mcp-product-catalogue-xxx.run.app/health

# Test CRM MCP
curl https://mcp-crm-xxx.run.app/health
```

### 9.2 Test Authentication Flow

```bash
# Get Firebase token (from frontend)
FIREBASE_TOKEN="your-firebase-token"

# Test message processing
curl -X POST https://agent-order-receiver-xxx.run.app/process \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $FIREBASE_TOKEN" \
  -d '{
    "message": "Do you sell organic products?",
    "conversation_history": []
  }'
```

### 9.3 Test MCP Calls

```bash
# Get service account token (from Support Agent logs)
SERVICE_TOKEN="service-account-token"

# Test Product Catalogue MCP
curl -X POST https://mcp-product-catalogue-xxx.run.app/mcp \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $SERVICE_TOKEN" \
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

## Step 10: Set Up Monitoring

### 10.1 Enable Cloud Monitoring

```bash
# Enable Cloud Monitoring API
gcloud services enable monitoring.googleapis.com
```

### 10.2 Create Alert Policies

```bash
# Create alert for high error rate
gcloud alpha monitoring policies create \
  --notification-channels=CHANNEL_ID \
  --display-name="High Error Rate" \
  --condition-threshold-value=0.05 \
  --condition-threshold-duration=300s
```

### 10.3 Set Up Logging

```bash
# View logs
gcloud logging read "resource.type=cloud_run_revision" --limit 50

# Export logs
gcloud logging export logs.json \
  --log-filter='resource.type=cloud_run_revision'
```

## Troubleshooting

### Common Issues

1. **Service Not Starting**
   - Check Cloud Run logs: `gcloud run services logs read SERVICE_NAME`
   - Verify environment variables
   - Check secret access permissions

2. **Authentication Failures**
   - Verify Firebase project ID matches
   - Check service account key is valid
   - Verify token expiration

3. **CORS Errors**
   - Check CORS_ORIGINS environment variable
   - Verify frontend URL is included
   - Check Cloud Run CORS configuration

4. **MCP Call Failures**
   - Verify MCP URLs are correct
   - Check service account token is valid
   - Verify network connectivity

## Cost Optimization

- **Cloud Run**: Use min instances = 0 for cost savings
- **Firestore**: Use on-demand pricing for low traffic
- **Cloud Storage**: Use standard storage class
- **Monitoring**: Set up budget alerts

## Security Checklist

- [ ] Secrets stored in Secret Manager
- [ ] Service accounts have minimal permissions
- [ ] CORS configured correctly
- [ ] HTTPS enforced on all endpoints
- [ ] Token validation implemented
- [ ] Error messages don't leak sensitive info

## Next Steps

In the final article, we'll cover **Monitoring, Security & Maintenance**, including observability, troubleshooting, and best practices for maintaining production AI agents.

