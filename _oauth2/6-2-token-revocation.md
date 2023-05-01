---
name: Token revocation
layout: default
---



# Token revocation
## Request - Get token

## Request
```
curl --location --request POST 'http://localhost:8085/ms-auth-server/oauth2/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=client_credentials' \
--data-urlencode 'client_id=user-client-opaque' \
--data-urlencode 'client_secret=user-client-secret' \
--data-urlencode 'scope=country.read customer.read customer.write'
```

## Response

```
{
    "access_token": "j53P_5JCitAmidCtdS1BIgnEtcprhF3H0sw3Ys5c6bHgE1Mj2YXKZZtFU3_urcUI4qynLRXM4YAUiFxz1KHGN_XApAQR_oSDpGMJFtYpSVPhV1fNezuNLKtU0FBMOx8w",
    "scope": "customer.read customer.write country.read",
    "token_type": "Bearer",
    "expires_in": 14399
}
```
## Introspect
### Request

```
curl --location --request POST 'http://localhost:8085/ms-auth-server/oauth2/introspect' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'client_id=service-client-jwt' \
--data-urlencode 'client_secret=service-client-jwt-secret' \
--data-urlencode 'token=j53P_5JCitAmidCtdS1BIgnEtcprhF3H0sw3Ys5c6bHgE1Mj2YXKZZtFU3_urcUI4qynLRXM4YAUiFxz1KHGN_XApAQR_oSDpGMJFtYpSVPhV1fNezuNLKtU0FBMOx8w'
```

### Response sample
```
{
    "active": true,
    "sub": "user-client-opaque",
    "aud": [
        "user-client-opaque"
    ],
    "nbf": 1682926001,
    "scope": "customer.read customer.write country.read",
    "iss": "http://localhost:8085/ms-auth-server",
    "exp": 1682940401,
    "iat": 1682926001,
    "jti": "0add9828-bc96-47ea-8b7a-24e84ccb24aa",
    "client_id": "user-client-opaque",
    "token_type": "Bearer"
}
```

## Revoke token

### Request
```
curl --location --request POST 'http://localhost:8085/ms-auth-server/oauth2/revoke' \
--header 'content-type: application/x-www-form-urlencoded' \
--data-urlencode 'client_id=user-client-opaque' \
--data-urlencode 'client_secret=user-client-secret' \
--data-urlencode 'token=j53P_5JCitAmidCtdS1BIgnEtcprhF3H0sw3Ys5c6bHgE1Mj2YXKZZtFU3_urcUI4qynLRXM4YAUiFxz1KHGN_XApAQR_oSDpGMJFtYpSVPhV1fNezuNLKtU0FBMOx8w'
```

### Response

```
http 200 
```

## Introspect after revoke

### Request

```
curl --location --request POST 'http://localhost:8085/ms-auth-server/oauth2/introspect' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'client_id=service-client-jwt' \
--data-urlencode 'client_secret=service-client-jwt-secret' \
--data-urlencode 'token=j53P_5JCitAmidCtdS1BIgnEtcprhF3H0sw3Ys5c6bHgE1Mj2YXKZZtFU3_urcUI4qynLRXM4YAUiFxz1KHGN_XApAQR_oSDpGMJFtYpSVPhV1fNezuNLKtU0FBMOx8w'
```

### Response

```
{
    "active": false
}
```


