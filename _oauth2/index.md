---
title: OAuth2
layout: default
permalink: /oauth2
redirect_from: /oauth2/index.html
redirect_from: /oauth2/home
---


# OAuth 2.0 for Java Developers: Explore, Learn, and Experiment!
Java Security Playground: Learn and Experiment with OAuth 2.0!" is a hands-on learning experience that allows developers to explore and experiment with OAuth 2.0 security concepts in a local playground environment. This includes diving under the hood of OAuth 2.0, studying real-world examples, and implementing OAuth 2.0 security with Spring Boot and Spring Authorization Server. With this playground, Java developers can gain practical experience in securing their applications with OAuth 2.0, all in a safe and controlled environment.

## 01 - Introduction
  - [Introduction](/oauth2/1-1-intro)
  - [Objective](/oauth2/1-2-objective)


## 02 - Playground
  - [Start playground](/oauth2/2-1-playground)
  - [Hello Token example](/oauth2/2-2-hello-token)
  - Playground architecture
  

## 03 - Tokens
 - Access tokens
 - Refresh Tokens
 - Scope
 - ID Token vs Access Tokens


## 04 - OAuth Grant types
 - Authorization code
 - PKCE
 - [Client credentials](/oauth2/4-3-client-credentials)
 - Device token
 - Rehresh Token
 - JWT bearer
 - Implicit flow (Legacy)
 - Password grant (Legacy)


## 04 - Clients
 - confidential clients
 - public clients


## 05 - Client Authentication
 - Client ID / Secret
 - Private key JWT
 - mutual TLS
 

## 06 - Token management
 - Token introspection
 - Token revocation


## 07 - Demonstate proof of possession (DPoP)
 - tls-bound-token

## 08 - Auth2 vs OpenID


<!-- ## Index
    {% for oauth in site.oauth2 %}
    <h2>
      <a href="{{ oauth.url }}">
        {{ oauth.name }}
      </a>
    </h2>
    {% endfor %} -->
