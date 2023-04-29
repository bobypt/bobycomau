---
name: Setup playground
layout: default
---

# Client authentication - private key JWT


Private key JWT (JSON Web Token) client authentication is a method of authenticating clients in OAuth2 using a private key instead of a shared secret or password. It is based on the JSON Web Token (JWT) standard, which defines a compact and secure way of transmitting information between parties as a JSON object.

In this method, the client generates a JWT containing its client ID, the OAuth2 token endpoint URL, and a timestamp. The JWT is signed using the client's private key, which is kept securely on the client's server. The client then sends the JWT to the authorization server as part of the OAuth2 token request.

The authorization server uses the client's public key to verify the signature on the JWT. If the signature is valid and the JWT contains the required information, the authorization server issues an access token to the client. The client can then use the access token to access protected resources on behalf of the user.

The advantages of using private key JWT client authentication include improved security, as the private key is not shared with anyone else and is not transmitted over the network, and reduced complexity, as there is no need for the client to maintain a shared secret or password. However, it requires more setup and configuration than other authentication methods and is not widely supported by all OAuth2 implementations.

### Sequence Diagram
![Client authentication - private key JWT](/diagrams/oauth2/sequence_diagrams/private_key_jwt/private_key_jwt.png){:class="img-responsive"}

#### Step 1: Send token request with JWT
In this sequence diagram, the Client actor sends a token request to the OAuth2 Authorization Server with a JSON Web Token (JWT) that contains the client's ID, token endpoint URL, and a timestamp. The JWT is signed using the client's private key. 

#### client jwt token
```
eyJraWQiOiJjbGllbnQiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJwcml2YXRla2V5LWp3dC1jbGllbnQtb3BhcXVlIiwic3ViIjoicHJpdmF0ZWtleS1qd3QtY2xpZW50LW9wYXF1ZSIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODA4NS9tcy1hdXRoLXNlcnZlci9vYXV0aDIvdG9rZW4iLCJleHAiOjE2ODI3NzM4Nzl9.LJpbqrlhI68fYra_KKtzfq8LYz4Y4aAFvXqXH0OPfGYidKVQr59snLfRykIVrKabBGGIkIi3krfpezuG5CbaCR2kDOzGZiOyq-1iB4X-JjnOC1X88uItkjUIceD0TirT_Znyk5tzzaLYWL11I1qpHEaailrT739lCRdS6emKWnovyQkCHJIOJlhPCWtlHfs4WnBnZqi1JTkOkX4I8FMlD5-X6UTUjP6xrO8sxyAFT69xZ_F_AwZ1xgKdtp-jSHKGEHk5uneZA4bst9sFIm8Qv6_U2Sfux3FNI6lqzsfhmsmIk-dxwaiaMVYqtOVT4d1lcj0ZHsGx03imzmwkuo2P4w
```

#### Client token claims
```
{
    "iss": "privatekey-jwt-client-opaque",
    "sub": "privatekey-jwt-client-opaque",
    "aud": "http://localhost:8085/ms-auth-server/oauth2/token",
    "exp": 1682773879
}
```

#### Token request
```
curl --location --request POST 'http://localhost:8085/ms-auth-server/oauth2/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=client_credentials' \
--data-urlencode 'client_id=privatekey-jwt-client-opaque' \
--data-urlencode 'scope=country.read customer.read customer.write' \
--data-urlencode 'client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer' \
--data-urlencode 'client_assertion=eyJraWQiOiJjbGllbnQiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJwcml2YXRla2V5LWp3dC1jbGllbnQtb3BhcXVlIiwic3ViIjoicHJpdmF0ZWtleS1qd3QtY2xpZW50LW9wYXF1ZSIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODA4NS9tcy1hdXRoLXNlcnZlci9vYXV0aDIvdG9rZW4iLCJleHAiOjE2ODI3NzM4Nzl9.LJpbqrlhI68fYra_KKtzfq8LYz4Y4aAFvXqXH0OPfGYidKVQr59snLfRykIVrKabBGGIkIi3krfpezuG5CbaCR2kDOzGZiOyq-1iB4X-JjnOC1X88uItkjUIceD0TirT_Znyk5tzzaLYWL11I1qpHEaailrT739lCRdS6emKWnovyQkCHJIOJlhPCWtlHfs4WnBnZqi1JTkOkX4I8FMlD5-X6UTUjP6xrO8sxyAFT69xZ_F_AwZ1xgKdtp-jSHKGEHk5uneZA4bst9sFIm8Qv6_U2Sfux3FNI6lqzsfhmsmIk-dxwaiaMVYqtOVT4d1lcj0ZHsGx03imzmwkuo2P4w'

```


#### Step 2: Request public key from client
```
curl --location --request GET 'http://localhost:8095/ms-auth-client/oauth2/jwks'
```

#### Step 3: Return public keys
```
{
    "keys": [
        {
            "kty": "RSA",
            "x5t#S256": "KC-imO2jWIFO-ByoLIi8AmiTpiE06DtiW_6dgjINAe0",
            "e": "AQAB",
            "kid": "client",
            "x5c": [
                "MIIDijCCAnKgAwIBAgIIA5HbLPE2D/QwDQYJKoZIhvcNAQELBQAwazELMAkGA1UEBhMCQVUxDDAKBgNVBAgTA1FMRDERMA8GA1UEBxMIQnJpc2JhbmUxETAPBgNVBAoTCEJvYnkgSW5jMQ0wCwYDVQQLEwRCb2J5MRkwFwYDVQQDExBiYW5rLmJvYnkuY29tLmF1MB4XDTIzMDQyOTExMjM1NloXDTIzMDcyODExMjM1NlowazELMAkGA1UEBhMCQVUxDDAKBgNVBAgTA1FMRDERMA8GA1UEBxMIQnJpc2JhbmUxETAPBgNVBAoTCEJvYnkgSW5jMQ0wCwYDVQQLEwRCb2J5MRkwFwYDVQQDExBiYW5rLmJvYnkuY29tLmF1MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtvQBGHyxyxsCJ7uvNIrJNOhoG8LsTt4JH7X/Pxqw5EiBU1HqoamL99UhaE/BATut6r4mkMD3QDsMAzefWFQNy1mnZ0ZPbCpDSTWpb1NdTNepQ71cQWDoA4cV0NQOxvdeRyMJKgiscqHwTT0SaFlxS0BfstHhaRlHVKYrVyw+VsjVQK4O3+jYYWT+VXoBANrpTeRA9bpvyPBSfWRMLxZFEXr8hI4RJia6KoCS7YKWJZuTQUTKnWKed/ZsiYDZDVjD9EBUwWKXBOnkxXKHEtfQL2pkGNmiD1WDqABg5q16x5cK6g+aWVf6FK3TmSDRBwjtg6FVlG2NCQudgavd8KmwgQIDAQABozIwMDAdBgNVHQ4EFgQUJZ+uarsk1YhGlnmw3CIYbPN50IIwDwYDVR0RBAgwBocEfwAAATANBgkqhkiG9w0BAQsFAAOCAQEAazledGStMKZgAtKVr5a8wwjpZC8dNyVNztw4n9EVU0XpzvL89I6I2Dnx+iQvETVpKSpwgHwdrT2V4ucVzQEmSJKWsh4jry21XxHfc2I9tb18j31stEYGZ0ALDTnNKAhB8gBFEssfewmIaa1tNNdBG8RPE/L2hXzC2gJezBr1bSj2hu1JQ9/cjWbZDKwPwaJnBDjTNGTVptu2EPd7cCnNGETLYkIhs0O3KYNjtB+FkDKUItCnyo4mfLvQDOGcUXhjYXUFtgrFmhY6+HufgdtnZttCPq+o7ewZi30MkHIylivUBtrSS7D37fAha1VUifQU6INUbmn4ixuUSye+gnomPg=="
            ],
            "n": "tvQBGHyxyxsCJ7uvNIrJNOhoG8LsTt4JH7X_Pxqw5EiBU1HqoamL99UhaE_BATut6r4mkMD3QDsMAzefWFQNy1mnZ0ZPbCpDSTWpb1NdTNepQ71cQWDoA4cV0NQOxvdeRyMJKgiscqHwTT0SaFlxS0BfstHhaRlHVKYrVyw-VsjVQK4O3-jYYWT-VXoBANrpTeRA9bpvyPBSfWRMLxZFEXr8hI4RJia6KoCS7YKWJZuTQUTKnWKed_ZsiYDZDVjD9EBUwWKXBOnkxXKHEtfQL2pkGNmiD1WDqABg5q16x5cK6g-aWVf6FK3TmSDRBwjtg6FVlG2NCQudgavd8KmwgQ"
        }
    ]
}
```

#### Step 4: Verify JWT

The OAuth2 Authorization Server verifies the JWT signature using the client's public key. 

#### Step 5: Issue access token

```
{
    "access_token": "ONMvfkQNCbK-RgvSO_A7N152kbtlAkcor7i_7HfXcvjAensxAV28qKrfQcNBSWFZesuiwhPMp2Si0DlZbHm9jKQM6-rLPaa4ybZQ_SATffI_1ySp85TRFG7NPMo9GOou",
    "scope": "customer.read customer.write country.read",
    "token_type": "Bearer",
    "expires_in": 14399
}
```

#### Step 6: Use token to access resource.

The client can then use the access token to access protected resources.

If you introspect the token, then you get below response.

```
curl --location --request POST 'http://localhost:8085/ms-auth-server/oauth2/introspect' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'client_id=service-client-jwt' \
--data-urlencode 'client_secret=service-client-jwt-secret' \
--data-urlencode 'token=ONMvfkQNCbK-RgvSO_A7N152kbtlAkcor7i_7HfXcvjAensxAV28qKrfQcNBSWFZesuiwhPMp2Si0DlZbHm9jKQM6-rLPaa4ybZQ_SATffI_1ySp85TRFG7NPMo9GOou'
```

```
{
    "active": true,
    "sub": "privatekey-jwt-client-opaque",
    "aud": [
        "privatekey-jwt-client-opaque"
    ],
    "nbf": 1682770776,
    "scope": "customer.read customer.write country.read",
    "iss": "http://localhost:8085/ms-auth-server",
    "exp": 1682785176,
    "iat": 1682770776,
    "jti": "0d60b0b5-cdab-4d4f-a5f2-e675322cc478",
    "client_id": "privatekey-jwt-client-opaque",
    "token_type": "Bearer"
}
```