---
name: Setup playground
layout: default
---


# Client authentication - Client secret post
OAuth2 is an authorization framework that allows clients to access resources on behalf of a user. In OAuth2, a client application is issued a client identifier and a client secret when it is registered with the authorization server. The client identifier is public and identifies the client application to the authorization server, while the client secret is a confidential piece of information that is used to authenticate the client application to the authorization server. In the client-secret-post authentication scheme, the client sends its client identifier and client secret in the request body as form-encoded parameters when requesting an access token from the authorization server. This authentication scheme provides a more secure way for clients to authenticate themselves to the authorization server during the OAuth2 flow, as the credentials are not exposed in the HTTP headers. However, this authentication scheme may require additional configuration on the client and server side to support.


## Sample request

```
curl --location --request POST 'http://localhost:8085/ms-auth-server/oauth2/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=client_credentials' \
--data-urlencode 'client_id=service-client-jwt' \
--data-urlencode 'client_secret=service-client-jwt-secret' \
--data-urlencode 'scope=country.read customer.read customer.write'
```



## Sample response

```
{
    "access_token": "eyJraWQiOiJhMmY3N2Q3MC1kNjA5LTQzNWMtYWM2My1iMGI2YTk4OWI2Y2UiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJzZXJ2aWNlLWNsaWVudC1qd3QiLCJhdWQiOiJzZXJ2aWNlLWNsaWVudC1qd3QiLCJuYmYiOjE2ODI4ODM5MDksInNjb3BlIjpbImN1c3RvbWVyLnJlYWQiLCJjdXN0b21lci53cml0ZSIsImNvdW50cnkucmVhZCJdLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwODUvbXMtYXV0aC1zZXJ2ZXIiLCJleHAiOjE2ODI4OTgzMDksImlhdCI6MTY4Mjg4MzkwOX0.EwE33ozkA-iv0ja0OhD45NfnDPBS04wFqvXNQrEiUIvBvg04j8wI4SuojR4aELdreechpQio2gGGIR6xCyhiWDVXjXVZnLOO_Yojoj8eqHztbiy3YI_UqZIspUsqPJ6wOy_eD-zdPS7Nmx93CPwJRxKvjXet9s7BvcHsj_8Hk86fOlMYlRIY3w2UQPQ5fE3WttLV9_4RnQRZzeQYTcyrhA_2QdSfLSgGyaPkxUZM12verRI7NxAwBuYLgpePQTw7Q1-nQpgcpTVIQzrQvFIshv9MMClRYJqCw866X3JubZkzS159s_M0HO3NZAbwiyLGIrjkTWgMtFZtYekdPLI-dg",
    "scope": "customer.read customer.write country.read",
    "token_type": "Bearer",
    "expires_in": 14399
}
```
