---
name: Setup playground
layout: default
---


# Client authentication - Mutual TLS and TLS bound access tokens


### Sequence Diagram
![Mutual TLS and TLS bound access tokens](/diagrams/oauth2/sequence_diagrams/mutual_tls/mutual_tls.png){:class="img-responsive"}


The sequence of steps is as follows:

 - The client initiates an authorization request to the authorization server.
 - The authorization server responds with an authorization challenge that includes the required scope and other parameters.
 - The client requests an access token from the authorization server, including its mutual TLS certificate.
 - The authorization server authenticates the mutual TLS certificate provided by the client.
 - The authorization server responds with an access token that is bound to the client's TLS certificate.
 - The client requests a protected resource from the resource server, including the access token in the request.
 - The resource server extracts the client's TLS certificate from the request.
 - The resource server validates the access token and its binding to the client's TLS certificate.
 - The resource server responds with the requested protected resource.

This flow provides strong security guarantees by using mutual TLS to authenticate the client to the authorization server, and TLS bound access tokens to ensure that **only the authorized client** can access protected resources.