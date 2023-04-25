---
layout:     default
title:      "OAuth2 playground using Java and spring boot"
subtitle:   "TODO - subtitle"
description: "TODO2"
date:       2023-04-08 12:00:00
author:     "Boby Thomas"
header-img: "images/logo_black.png"
categories: technical
---

# Reference architecture to deploy microservices to AWS
## Goals
 - OAuth2 playground in java
 - Understand oauth by looking under the hood.
 - Send postman / curl requests and see the responses.
 - View behind the scene http logs. 
 - Configure various oAuth clients. 
 - ...

## Pre-requistes
 - Java 17
 - Docker

## Start the playground

```
./demo.sh build

docker-compose up
```

## Test the health

You have successfully completed the local setup. Its time to explore oAuth2. 



Introduction to OAuth 2.1
OAuth 2.1 actors and terminology
OAuth 2.1 flows and grants
OAuth 2.1 tokens and token types
OAuth 2.1 client registration and metadata
OAuth 2.1 endpoints and response types
OAuth 2.1 security considerations
OAuth 2.1 best practices
OAuth 2.1 extensions
OAuth 2.1 migration from previous versions



OAuth 2.1 defines several actors and terminologies that are important to understand when implementing the protocol. Here's a brief explanation of some of the key actors and terminologies:

Resource Owner: The Resource Owner is the user who owns the resource, which is protected by OAuth. For example, the Resource Owner could be a person who owns a photo on a photo-sharing website.

Resource Server: The Resource Server is the server that hosts the protected resources that the client wants to access. For example, the Resource Server could be the server hosting the photo the client wants to access.

Client: The Client is the application that wants to access the protected resources on behalf of the Resource Owner. For example, the client could be a mobile app that wants to access the Resource Owner's photo on the photo-sharing website.

Authorization Server: The Authorization Server is the server that authenticates the Resource Owner and issues access tokens to the client. The access tokens are used by the client to access the protected resources on the Resource Server.

Access Token: The Access Token is a credential that the client uses to access the protected resources on the Resource Server. The Access Token represents the authorization granted to the client by the Resource Owner.

Scope: Scope is a parameter that is used to limit the scope of access that the client has to the protected resources. For example, a photo-sharing website might define a scope called "read_photos" that only allows the client to read photos, but not delete them.

Refresh Token: A Refresh Token is a credential that can be used to obtain a new Access Token without having to re-authenticate the Resource Owner. This can be useful to allow long-lived access to resources.

Understanding these actors and terminologies is essential for implementing OAuth 2.1 correctly and securely.




OAuth 2.1 uses tokens to provide access to protected resources on the Resource Server. Tokens are issued by the Authorization Server, and they represent the authorization granted to the client by the Resource Owner. Tokens can be issued in different types depending on the use case and requirements of the system.

Here are some of the most common token types used in OAuth 2.1:

Access Token: Access Tokens are the most common type of token used in OAuth 2.1. They are issued by the Authorization Server and are used by the client to access protected resources on the Resource Server. Access Tokens are typically short-lived and are used to provide temporary access to resources.

Refresh Token: Refresh Tokens are used to obtain new Access Tokens without requiring the user to re-authenticate. They are typically long-lived and are used to provide persistent access to resources. When an Access Token expires, the client can use the Refresh Token to obtain a new Access Token without requiring the user to provide their credentials again.

ID Token: ID Tokens are used to provide information about the authenticated user to the client. They contain information such as the user's name, email address, and other profile information. ID Tokens are typically short-lived and are used to provide temporary access to user information.

JWT (JSON Web Token): JWT is a token format that can be used to represent any type of information. JWTs can be used as Access Tokens, ID Tokens, or any other type of token. They are typically signed and encrypted to provide additional security.

MAC Token: MAC Tokens are used in cases where symmetric cryptography is preferred over asymmetric cryptography. They are similar to Access Tokens, but they are signed using a shared secret between the client and the Resource Server.

Understanding the different types of tokens used in OAuth 2.1 is important when designing and implementing an OAuth 2.1 system. The type of token used depends on the requirements of the system and the level of security needed for the protected resources.


Here is an outline for "Learn OAuth 2.1 in 10 days":

Day 1: Introduction to OAuth 2.1

What is OAuth 2.1?
Why is OAuth 2.1 important?
How does OAuth 2.1 work?
Day 2: Actors and Terminology

Resource Owner
Resource Server
Client
Authorization Server
Access Token
Scope
Refresh Token
Day 3: OAuth 2.1 Flows and Grants

Authorization Code Grant
Implicit Grant
Resource Owner Password Credentials Grant
Client Credentials Grant
Day 4: OAuth 2.1 Tokens

Access Tokens
Refresh Tokens
ID Tokens
JWTs
MAC Tokens
Day 5: Client Registration and Metadata

Client Registration
Client Metadata
Client Authentication
Day 6: OAuth 2.1 Endpoints and Response Types

Authorization Endpoint
Token Endpoint
Redirect URIs
Response Types
Day 7: Security Considerations

Threats and Vulnerabilities
Best Practices
Token Revocation
Token Refresh
Day 8: Best Practices

Client Security
Authorization Server Security
Resource Server Security
Day 9: OAuth 2.1 Extensions

OpenID Connect
Token Exchange
Token Binding
Day 10: Migration from Previous Versions

OAuth 1.0 to OAuth 2.0 Migration
OAuth 2.0 to OAuth 2.1 Migration
This outline is just a starting point and can be customized based on individual learning needs and pace. It's important to remember that OAuth 2.1 is a complex protocol, so it may take more than 10 days to become an expert in it.