---
title: Monitoring, Security & Maintenance
layout: agentic
permalink: /ai/monitoring-security-maintenance
series: "Build and Maintain a Reliable Secure AI Agent in the Cloud"
sequence: 10
tags: [ai, monitoring, security, maintenance, observability]
status: published
short_summary: Observability, troubleshooting, and best practices for Cloud AI agents
---

# Monitoring, Security & Maintenance

This final article covers monitoring, security best practices, and maintenance strategies for Cloud AI agents.

## Monitoring

### Cloud Monitoring Setup

Track key metrics:
- Request count and latency
- Error rates
- Token refresh frequency
- MCP call success rates
- Database query performance

### Logging

**Local Development:**
```bash
docker-compose logs -f support-agent-adk
docker-compose logs -f mcp-crm
docker-compose logs -f mcp-product-catalogue
```

**Cloud:**
```bash
# View logs
gcloud logging read "resource.type=cloud_run_revision" --limit 50

# Filter by service
gcloud logging read "resource.labels.service_name=agent-order-receiver"
```

### Health Checks

All services expose `/health` endpoints:
```bash
curl https://agent-order-receiver-xxx.run.app/health
```

### Debug Mode

Set `DEBUG_HTTP=true` to enable:
- Request/response logging
- Authentication debug logs
- MCP protocol debug logs

## Security Best Practices

### 1. Secrets Management

- Never commit secrets to git
- Use Secret Manager for all sensitive data
- Rotate secrets regularly
- Store service account keys in GCP Secret Manager

### 2. Authentication

- Always validate Firebase tokens
- Use service account tokens for service-to-service calls
- Implement rate limiting
- Check token expiration

### 3. Network Security

- Use HTTPS for all endpoints
- Configure CORS properly
- Use VPC connector for private services (optional)
- Implement rate limiting

### 4. Error Handling

- Don't leak sensitive information in errors
- Log authentication failures
- Implement proper error codes
- Return generic error messages to clients

## Troubleshooting

### Common Issues

**1. Token Expired**
- Service account tokens auto-refresh
- Check `MCP_AUTH_TOKEN` is set in environment
- Verify `FIREBASE_PROJECT_ID` is configured

**2. MCP Call Fails**
- Check MCP server is running
- Verify service account token is valid
- Check network connectivity between services

**3. Permission Denied**
- Verify user has required permissions
- Check token includes permission claims
- Service accounts have full access by default

**4. CORS Errors**
- Verify `CORS_ORIGINS` includes frontend URL
- Check Cloud Run CORS configuration
- Ensure frontend sends correct headers

## Maintenance

### Regular Tasks

1. **Monitor Error Rates**: Set up alerts for high error rates
2. **Review Logs**: Check for authentication failures or unusual patterns
3. **Update Dependencies**: Keep packages up to date
4. **Rotate Secrets**: Regularly rotate service account keys
5. **Backup Data**: Regular Firestore backups

### Cost Optimization

- **Cloud Run**: Use min instances = 0 for cost savings
- **Firestore**: Use on-demand pricing for low traffic
- **Cloud Storage**: Use standard storage class
- **Monitoring**: Set up budget alerts

## Best Practices Summary

1. **Architecture**: Microservices with clear separation of concerns
2. **Security**: Token exchange pattern, proper authentication
3. **Protocol**: Standardized MCP JSON-RPC 2.0 communication
4. **Deployment**: Cloud-native with auto-scaling
5. **Monitoring**: Comprehensive logging and metrics
6. **Maintenance**: Regular updates and security checks

## Conclusion

This series covered building, deploying, and maintaining production-ready AI agents in the cloud. Key takeaways:

- **Architecture matters**: Microservices enable scalability and maintainability
- **Security is critical**: Proper authentication and authorization are essential
- **Standard protocols**: MCP provides consistent agent-to-service communication
- **Cloud-native**: Leverage managed services for reliability
- **Observability**: Monitor and log everything for troubleshooting

For more details, refer to the implementation documentation and code examples throughout this series.

