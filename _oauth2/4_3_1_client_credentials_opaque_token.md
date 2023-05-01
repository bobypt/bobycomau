---
name: Setup playground
layout: default
---
# Grant type - Client credentials - Resource access using opaque tokens

## Client credentials - Resource access using Opaque token

### Sequence Diagram
![Client credentials - Opaque token](/diagrams/oauth2/sequence_diagrams/client_credentials_opaque_token/client_credentials_opaque_token.png){:class="img-responsive"}

Here's how the diagram works:

 - The **Client** sends a request for a protected resource to the **ResourceServer**.
```
curl -v --request GET 'http://localhost:8091/ms-system/country/code/AUS'
```

 - The **ResourceServer** responds with an unauthorized message.
```
HTTP/1.1 401
WWW-Authenticate: Bearer
```

 - The **Client** sends a request for an access token to the **OAuthServer**.
```
curl --location --request POST 'http://localhost:8085/ms-auth-server/oauth2/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=client_credentials' \
--data-urlencode 'client_id=user-client-opaque' \
--data-urlencode 'client_secret=user-client-secret' \
--data-urlencode 'scope=country.read'
```
 - The **OAuthServer** responds with an access token.
```
{
    "access_token": "fm8DH_ofCQnIhhbnoaMEN9SNZFYgAscQwmNpOLrsFLoXhgd2hD4Q7vUXbudKJc03S-d5v_1eM_3PX2lKKotrp1m1efH8en72YOdzay6f15MoVU7YlajDxH-A234ePMBU",
    "scope": "country.read",
    "token_type": "Bearer",
    "expires_in": 14399
}
```
 - The **Client** sends a request for the protected resource to the **ResourceServer**, along with the access token.
```
curl --location --request GET 'http://localhost:8091/ms-system/country/code/AUS' \
--header 'Authorization: Bearer fm8DH_ofCQnIhhbnoaMEN9SNZFYgAscQwmNpOLrsFLoXhgd2hD4Q7vUXbudKJc03S-d5v_1eM_3PX2lKKotrp1m1efH8en72YOdzay6f15MoVU7YlajDxH-A234ePMBU' 
```

 - The **ResourceServer** sends a token introspection request to the **OAuthServer** to validate the token.
```
curl --location --request POST 'http://localhost:8085/ms-auth-server/oauth2/introspect' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'client_id=service-client-jwt' \
--data-urlencode 'client_secret=service-client-jwt-secret' \
--data-urlencode 'token=fm8DH_ofCQnIhhbnoaMEN9SNZFYgAscQwmNpOLrsFLoXhgd2hD4Q7vUXbudKJc03S-d5v_1eM_3PX2lKKotrp1m1efH8en72YOdzay6f15MoVU7YlajDxH-A234ePMBU'
```


 - The **OAuthServer** responds with the token information.
```
{
    "active": true,
    "sub": "user-client-opaque",
    "aud": [
        "user-client-opaque"
    ],
    "nbf": 1682724215,
    "scope": "country.read",
    "iss": "http://localhost:8085/ms-auth-server",
    "exp": 1682738615,
    "iat": 1682724215,
    "jti": "4df7aa1c-96be-4653-a7bd-fe34b5fcc51a",
    "client_id": "user-client-opaque",
    "token_type": "Bearer"
}
```

 - The **ResourceServer** responds to the **Client** with the protected resource.
```
{
    "code": "AUS",
    "name": "AUSTRALIA"
}
```

Note that the token introspection step is optional and may not be required in all implementations of the OAuth2 client credentials flow. Additionally, the specific format and implementation details of the opaque token and token introspection call may vary depending on the OAuth server and client used.

