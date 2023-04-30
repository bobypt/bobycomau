---
name: Setup playground
layout: default
---

# Client authentication - Client secret basic
OAuth2 is an authorization framework widely used by applications to access resources on behalf of a user. To use OAuth2, a client application must be registered with the authorization server, and it is issued a client identifier and a client secret. The client identifier is public and identifies the client application to the authorization server, while the client secret is a confidential piece of information that is used to authenticate the client application to the authorization server. In the client-secret-basic authentication scheme, the client sends its client identifier and client secret as basic authentication credentials in the HTTP Authorization header when requesting an access token from the authorization server. This authentication scheme provides a simple and secure way for clients to authenticate themselves to the authorization server during the OAuth2 flow.

## Sample request

```
curl --location --request POST 'http://localhost:8085/ms-auth-server/oauth2/token?grant_type=client_credentials&scope=customer.read%20customer.write%20country.read' \
--header 'Authorization: Basic c2VydmljZS1jbGllbnQtand0OnNlcnZpY2UtY2xpZW50LWp3dC1zZWNyZXQ='
```

Please note that the **Authorization** header is base64 encoded **client-id:client-secret**

```
base64(service-client-jwt:service-client-jwt-secret) => c2VydmljZS1jbGllbnQtand0OnNlcnZpY2UtY2xpZW50LWp3dC1zZWNyZXQ=
```


## Sample response

```
{
    "access_token": "eyJraWQiOiJhMmY3N2Q3MC1kNjA5LTQzNWMtYWM2My1iMGI2YTk4OWI2Y2UiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJzZXJ2aWNlLWNsaWVudC1qd3QiLCJhdWQiOiJzZXJ2aWNlLWNsaWVudC1qd3QiLCJuYmYiOjE2ODI4ODM4NTYsInNjb3BlIjpbImN1c3RvbWVyLnJlYWQiLCJjdXN0b21lci53cml0ZSIsImNvdW50cnkucmVhZCJdLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwODUvbXMtYXV0aC1zZXJ2ZXIiLCJleHAiOjE2ODI4OTgyNTYsImlhdCI6MTY4Mjg4Mzg1Nn0.o-93YVXbrt3Fe57_EYVEEWQO8BxkOzqB1FgQbh76sBdK5KNKrBhjhWaXhCZUX6NUUuwq_6W0QltO0lQOn75mjIosY_ZA5XWTR-eaVV2haCrJGX5ow8Aqmw7H79NLfC-0QdR5gLL9736Z5aFXmWMgx4bAmTmBdqLpaO9FNXWoqSi5qmHEIGZLYETuE0Vx5nBIvx15129mz92VjPppLaJjxAMwTsH1P2zOgfuk_crUqn4-ASZHs017i0BONEVTvJHrD6EDScm2ExTkd6HHvti719lfEhKhlA9tL0X-lr_-0L-ra2-PNfEoTyKbAdo260cbNVkWkYLnCWIgQ9mb6u0ksQ",
    "scope": "customer.read customer.write country.read",
    "token_type": "Bearer",
    "expires_in": 14399
}
```