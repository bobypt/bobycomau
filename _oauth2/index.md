---
title: OAuth2
layout: default
permalink: /oauth2
redirect_from: /oauth2/index.html
redirect_from: /oauth2/home
---


# OAuth 2.0 for Java Developers: Explore, Learn, and Experiment!

![Playground](/diagrams/oauth2/gifs/oauth2-playground-commandline.gif){:class="w-75"}


![Security](/images/oAuth2/security1.png){:class="w-25"}


Java Security Playground: Learn and Experiment with OAuth 2.0!" is a hands-on learning experience that allows developers to explore and experiment with OAuth 2.0 security concepts in a local playground environment. This includes diving under the hood of OAuth 2.0, studying real-world examples, and implementing OAuth 2.0 security with Spring Boot and Spring Authorization Server. With this playground, Java developers can gain practical experience in securing their applications with OAuth 2.0, all in a safe and controlled environment.

## 01 - Introduction
  - [Introduction](/oauth2/1-1-intro)
  - [Objective](/oauth2/1-2-objective)


## 02 - Playground
  - [Start playground](/oauth2/2-1-playground)
  - [Hello Token example](/oauth2/2-2-hello-token)
  - [Playground architecture](/oauth2/2-3-playground-architecture)
  - [User journeys](/oauth2/2-4-user-journey-http-logs)  

## 03 - Tokens
 - Access tokens
 - Refresh Tokens
 - Scope
 - ID Token vs Access Tokens


## 04 - OAuth Grant types
 - Authorization code
 - PKCE
 - [Client credentials - Resource access using opaque tokens](/oauth2/4-3-1-client-credentials-opaque-token) 
 - [Client credentials - Resource access using self contained tokens (JWT)](/oauth2/4-3-2-client-credentials-jwt-token)
 - Device token
 - Refresh Token
 - JWT bearer
 - Implicit flow (Legacy)
 - Password grant (Legacy)


## 04 - Client Types
 - confidential clients
 - public clients


## 05 - Client Authentication
 - [Client secret basic (Client ID / Secret)](/oauth2/5-1-client-secret-basic)
 - [Client secret post (Client ID / Secret)](/oauth2/5-2-client-secret-post)
 - [Client secret basic vs Client secret post](/oauth2/5-2-1-basic-vs-post)
 - [Private key JWT](/oauth2/5-3-private-key-jwt)
 - [mutual TLS](/oauth2/5-4-mutual-tls)
 - [Mutual TLS (TLS bound token) VS Client secret post](/oauth2/5-4-1-mutual-tls-vs-client-secret-post) 
 

## 06 - Token management
 - [Token introspection](/oauth2/6-1-token-introspection)
 - [Token revocation](/oauth2/6-2-token-revocation)


## 07 - Proof of possession
 - tls-bound-token (mTLS)
 - Demonstration of Proof-of-Possession(DPoP)
 
## 08 - Auth2 vs OpenID


<!-- ## Index
    {% for oauth in site.oauth2 %}
    <h2>
      <a href="{{ oauth.url }}">
        {{ oauth.name }}
      </a>
    </h2>
    {% endfor %} -->
