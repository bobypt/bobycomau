---
name: Setup playground
layout: default
---
# Grant type - client credentials

## Client credentials - JWT token (Self contained token)

### Sequence Diagram
![Client credentials - Opaque token](/diagrams/oauth2/sequence_diagrams/client_credentials_jwt_token/client_credentials_jwt_token.png){:class="img-responsive"}

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

 - The **Client** sends a request for an access token to the **OAuthServer**. Http request can be **client-secret baisc** or **client-secret-post** etc. In the below example, clien-secret-post is used.
```
curl --location --request POST 'http://localhost:8085/ms-auth-server/oauth2/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=client_credentials' \
--data-urlencode 'client_id=service-client-jwt' \
--data-urlencode 'client_secret=service-client-jwt-secret' \
--data-urlencode 'scope=country.read customer.read customer.write'
```
 - The **OAuthServer** responds with an access token.
```
{
    "access_token": "eyJraWQiOiI2Mjg0OWJlYS04M2E0LTRlYzYtYWJjZS1lYjVmMDk4OWVjMzYiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJzZXJ2aWNlLWNsaWVudC1qd3QiLCJhdWQiOiJzZXJ2aWNlLWNsaWVudC1qd3QiLCJuYmYiOjE2ODI3MzE2NTksInNjb3BlIjpbImN1c3RvbWVyLnJlYWQiLCJjdXN0b21lci53cml0ZSIsImNvdW50cnkucmVhZCJdLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwODUvbXMtYXV0aC1zZXJ2ZXIiLCJleHAiOjE2ODI3NDYwNTksImlhdCI6MTY4MjczMTY1OX0.YbA2jmbtr8wixUWrkKTqQcrWj5fceL-VjQba1vcsBSzR-ct-Yg7XR5gY1vc4DX5viRN6gvfvOIuvVVUceV50B046CsFmik9nJT3vLFsQOudN0UEWHvE2Wz-3BUNhxZ9dcXkBKL7Q5yVt9qboGE82c4dkufy1yCaKbwPyWK1SjRL7CF8ivqfw9mrhQuku1HJ4QhAKWE60ajzpSAzNNgPClY2rlELBmqeInvOJr3EsfTt8DbiwdE5l1_9OM9L9Ge_IYCetwfOK0kqjEVcfSJy9H-WpI9a6Cj3GxSqEQ5a5M3jLYnCWP_Vq10uFNIeNyyv0ZwNzQdS6ITyZWxkgc4oi3A",
    "scope": "customer.read customer.write country.read",
    "token_type": "Bearer",
    "expires_in": 14399
}
```
 - The **Client** sends a request for the protected resource to the **ResourceServer**, along with the access token.
```
curl --location --request GET 'http://localhost:8091/ms-system/country/code/AUS' \
--header 'Authorization: Bearer eyJraWQiOiI2Mjg0OWJlYS04M2E0LTRlYzYtYWJjZS1lYjVmMDk4OWVjMzYiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJzZXJ2aWNlLWNsaWVudC1qd3QiLCJhdWQiOiJzZXJ2aWNlLWNsaWVudC1qd3QiLCJuYmYiOjE2ODI3MzE2NTksInNjb3BlIjpbImN1c3RvbWVyLnJlYWQiLCJjdXN0b21lci53cml0ZSIsImNvdW50cnkucmVhZCJdLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwODUvbXMtYXV0aC1zZXJ2ZXIiLCJleHAiOjE2ODI3NDYwNTksImlhdCI6MTY4MjczMTY1OX0.YbA2jmbtr8wixUWrkKTqQcrWj5fceL-VjQba1vcsBSzR-ct-Yg7XR5gY1vc4DX5viRN6gvfvOIuvVVUceV50B046CsFmik9nJT3vLFsQOudN0UEWHvE2Wz-3BUNhxZ9dcXkBKL7Q5yVt9qboGE82c4dkufy1yCaKbwPyWK1SjRL7CF8ivqfw9mrhQuku1HJ4QhAKWE60ajzpSAzNNgPClY2rlELBmqeInvOJr3EsfTt8DbiwdE5l1_9OM9L9Ge_IYCetwfOK0kqjEVcfSJy9H-WpI9a6Cj3GxSqEQ5a5M3jLYnCWP_Vq10uFNIeNyyv0ZwNzQdS6ITyZWxkgc4oi3A'
```

 - The **ResourceServer** sends jwks url request to the **OAuthServer** to get public key for the JWT key id.
```
curl --location --request GET 'http://localhost:8085/ms-auth-server/oauth2/jwks'
```


 - The **OAuthServer** responds with the list of active keys(key IDs) and corresponding public key modulus and exponent.
```
{
    "keys": [
        {
            "kty": "RSA",
            "e": "AQAB",
            "kid": "bc777501-7e88-4f58-9016-4ea71a9455fb",
            "n": "2NMJVk86ifyl-TipMOB-N1Km_6ki-MZgYO-StDMCQKnA7EfrveWbD3O6p0XRuHxO_1Sz3SZAi9XqTKYtu3MstpKJ35-pRos6tTxRg_tUm0bPDU2OmflgaORjGtB3ufFTyCWDVw6U63lFavrZq1HLN9dXr132mmZ952q9PEPxSWx7UsrkFcX_mdgFrmPZJ6BZKMuLMcN2TQVZBih5bj7tFl93Gh6CkiXb8IczoJcJD4d78x8d8wx9Xd6MNqu5LPgO5FllN-QpsYzERqmEe3rVuEaNk3VcS9UCu5fTLDKAa59VmMrndg_u3FzqceywYsoPpSE15aLnGNe1sXc-LXg1dw"
        }
    ]
}
```

 - The **ResourceServer** cache the key IDs and corresponding public keys for future use..


 - The **ResourceServer** validate the JWT using the public key for the key ID. Also validate the claims (eg: scope) to make sure client has permission to access the requested resource.

 - The **ResourceServer** responds to the **Client** with the protected resource.
```
{
    "code": "AUS",
    "name": "AUSTRALIA"
}
```

Note that the token introspection step is optional and may not be required in all implementations of the OAuth2 client credentials flow. Additionally, the specific format and implementation details of the opaque token and token introspection call may vary depending on the OAuth server and client used.

