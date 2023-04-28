---
name: Setup playground
layout: default
---

# Client credentials - Opaque token

Here's how the diagram works:

 - The **Client** sends a request for a protected resource to the **ResourceServer**.
 - The **ResourceServer** responds with an unauthorized message.
 - The **Client** sends a request for an access token to the **OAuthServer**.
 - The **OAuthServer** responds with an access token.
 - The **Client** sends a request for the protected resource to the **ResourceServer**, along with the access token.
 - The **ResourceServer** sends a token introspection request to the **OAuthServer** to validate the token.
 - The **OAuthServer** responds with the token information.
 - The **ResourceServer** responds to the **Client** with the protected resource.

Note that the token introspection step is optional and may not be required in all implementations of the OAuth2 client credentials flow. Additionally, the specific format and implementation details of the opaque token and token introspection call may vary depending on the OAuth server and client used.

