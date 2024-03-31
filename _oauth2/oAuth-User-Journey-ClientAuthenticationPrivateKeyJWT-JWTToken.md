---
name: Collection runner report
layout: default
---

# Collection runner report

**This is an automated report generated on [Thu, 28 Mar 2024 02:07:10 GMT] **

- [Collection runner report](#collection-runner-report)
  - [01\_accessResourceNoToken](#01_accessresourcenotoken)
    - [Request](#request)
    - [Response](#response)
  - [02\_createClientAssertion](#02_createclientassertion)
    - [Request](#request-1)
    - [Response](#response-1)
  - [03\_requestJwtToken](#03_requestjwttoken)
    - [Request](#request-2)
    - [Response](#response-2)
  - [04\_validateClientAssertion-Jwks](#04_validateclientassertion-jwks)
    - [Request](#request-3)
    - [Response](#response-3)
  - [05\_IntrospectToken](#05_introspecttoken)
    - [Request](#request-4)
    - [Response](#response-4)
  - [06\_accessResourceValidToken](#06_accessresourcevalidtoken)
    - [Request](#request-5)
    - [Response](#response-5)
  - [07\_revoke-token](#07_revoke-token)
    - [Request](#request-6)
    - [Response](#response-6)
  - [08\_IntrospectTokenWithRoveokedToken](#08_introspecttokenwithroveokedtoken)
    - [Request](#request-7)
    - [Response](#response-7)
  - [09\_accessResourceRevokedToken](#09_accessresourcerevokedtoken)
    - [Request](#request-8)
    - [Response](#response-8)


## 01_accessResourceNoToken
### Request

```javascript

GET http://localhost:8091/ms-system/country/code/AUS 


User-Agent: PostmanRuntime/7.37.1
Accept: */*
Cache-Control: no-cache
Postman-Token: f25f67c9-38bc-486a-b578-5cd54e1f4a9a
Host: localhost:8091
Accept-Encoding: gzip, deflate, br
Connection: keep-alive

```

### Response

```javascript


HTTP 401

Set-Cookie: JSESSIONID=329F1F130E025EB2DF4334CDF1B470E9; Path=/ms-system; HttpOnly
WWW-Authenticate: Bearer
X-Content-Type-Options: nosniff
X-XSS-Protection: 0
Cache-Control: no-cache, no-store, max-age=0, must-revalidate
Pragma: no-cache
Expires: 0
X-Frame-Options: DENY
Content-Length: 0
Date: Thu, 28 Mar 2024 02:07:10 GMT
Keep-Alive: timeout=60
Connection: keep-alive



```

## 02_createClientAssertion
### Request

```javascript

POST http://localhost:8095/ms-auth-client/utilities/createJwt 


Content-Type: application/json
User-Agent: PostmanRuntime/7.37.1
Accept: */*
Cache-Control: no-cache
Postman-Token: afe77484-7fb4-4668-8950-3d1deddb5973
Host: localhost:8095
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
Content-Length: 163


{
    "sub": "privatekeyjwt_jwt_client",
    "iss": "privatekeyjwt_jwt_client",
    "aud": "http://localhost:8085/ms-auth-server/oauth2/token",
    "test": "abc"
}
```

### Response

```javascript


HTTP 200

X-Content-Type-Options: nosniff
X-XSS-Protection: 0
Cache-Control: no-cache, no-store, max-age=0, must-revalidate
Pragma: no-cache
Expires: 0
X-Frame-Options: DENY
Content-Type: application/json
Transfer-Encoding: chunked
Date: Thu, 28 Mar 2024 02:07:10 GMT
Keep-Alive: timeout=60
Connection: keep-alive


{
    "data": "eyJraWQiOiJraWQtMTAwMDAwMDEiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJwcml2YXRla2V5and0X2p3dF9jbGllbnQiLCJzdWIiOiJwcml2YXRla2V5and0X2p3dF9jbGllbnQiLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjgwODUvbXMtYXV0aC1zZXJ2ZXIvb2F1dGgyL3Rva2VuIiwidGVzdCI6ImFiYyIsImV4cCI6MTcxMTU5NTIzMH0.bPAZubo8gz4mWdcYlo_i5jWN9mGi1fUCikxx_grHmmXkuQcyIFg5OV1HGawbyZ2J1noplLN6bgb2v6HOng8muLNmImeQ3as9J1d-ToJ-XFpvirQ9yEP7pZhKu4h0Q-KbfqO8T42TdPGPTT6kmEnrN7R8s0Zcjfbfg3bvwhIeqqsxCldrCeZSOd5IMtPaCSYhFwgJYBKgyeqtESvazTkOOqQKYttyd8w79PA1tJw3CbpCA9SWDWPPlPMwlB8wf4oJ2PkxwAmuLH4CthDayp2SGsgGPQTo5HxjGwlpUmaaccx1_XUsGWVkb8Vn3PUzHXMg8pkHamb2HGmORskn0Uo0AA"
}
```

## 03_requestJwtToken
### Request

```javascript

POST http://localhost:8085/ms-auth-server/oauth2/token 


Content-Type: application/x-www-form-urlencoded
User-Agent: PostmanRuntime/7.37.1
Accept: */*
Cache-Control: no-cache
Postman-Token: ae33b496-b44c-42f6-8bd0-9aeebcf01fd0
Host: localhost:8085
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
Content-Length: 820


grant_type=client_credentials&client_id=privatekeyjwt_jwt_client&scope=country.read customer.read customer.write&client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer&client_assertion=eyJraWQiOiJraWQtMTAwMDAwMDEiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJwcml2YXRla2V5and0X2p3dF9jbGllbnQiLCJzdWIiOiJwcml2YXRla2V5and0X2p3dF9jbGllbnQiLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjgwODUvbXMtYXV0aC1zZXJ2ZXIvb2F1dGgyL3Rva2VuIiwidGVzdCI6ImFiYyIsImV4cCI6MTcxMTU5NTIzMH0.bPAZubo8gz4mWdcYlo_i5jWN9mGi1fUCikxx_grHmmXkuQcyIFg5OV1HGawbyZ2J1noplLN6bgb2v6HOng8muLNmImeQ3as9J1d-ToJ-XFpvirQ9yEP7pZhKu4h0Q-KbfqO8T42TdPGPTT6kmEnrN7R8s0Zcjfbfg3bvwhIeqqsxCldrCeZSOd5IMtPaCSYhFwgJYBKgyeqtESvazTkOOqQKYttyd8w79PA1tJw3CbpCA9SWDWPPlPMwlB8wf4oJ2PkxwAmuLH4CthDayp2SGsgGPQTo5HxjGwlpUmaaccx1_XUsGWVkb8Vn3PUzHXMg8pkHamb2HGmORskn0Uo0AA
```

### Response

```javascript


HTTP 200

X-Content-Type-Options: nosniff
X-XSS-Protection: 0
Cache-Control: no-cache, no-store, max-age=0, must-revalidate
Pragma: no-cache
Expires: 0
X-Frame-Options: DENY
Content-Type: application/json;charset=UTF-8
Transfer-Encoding: chunked
Date: Thu, 28 Mar 2024 02:07:11 GMT
Keep-Alive: timeout=60
Connection: keep-alive


{
    "access_token": "eyJraWQiOiI4NzgwZGY3ZC05YjhiLTQ4OTQtYWNhZi03MWFhZTRlMzA4NWUiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJwcml2YXRla2V5and0X2p3dF9jbGllbnQiLCJhdWQiOiJwcml2YXRla2V5and0X2p3dF9jbGllbnQiLCJuYmYiOjE3MTE1OTE2MzEsInNjb3BlIjpbImN1c3RvbWVyLnJlYWQiLCJjdXN0b21lci53cml0ZSIsImNvdW50cnkucmVhZCJdLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwODUvbXMtYXV0aC1zZXJ2ZXIiLCJleHAiOjE3MTE2MDYwMzEsImlhdCI6MTcxMTU5MTYzMX0.CQp-AdknNlDB0yhX7JSGNf0N1x43YkMklGt-fuAA_DZDZ4t2ZrQGj9aDH1bmGhfxSq6wsPjIGF7pRFJqkvDwKYZGoKkUe0galjvBSEhXTnFFY4QfHAYZ3brghwxgdOiITB0rEQYFYt_XZEb50YZ-MCb7FjCt17dheCUpIxpnnPbMweF9fWbW7ozmcqfzrPHlGTs1QX8PqpTdrQ_zdjysyDQpIcqKFZeY-5artYKAOT6C42lr88CYxHXQLKmfFn7iY1XVdnEFNCOmXZF5Pexgkz9biWsSLm2itJebC18wypRH-PsZKZwSzi5c0l3OqfpxvUF8yIN3d2YHPFmezYTNeQ",
    "scope": "customer.read customer.write country.read",
    "token_type": "Bearer",
    "expires_in": 14399
}
```

## 04_validateClientAssertion-Jwks
### Request

```javascript

GET http://localhost:8095/ms-auth-client/oauth2/jwks 


User-Agent: PostmanRuntime/7.37.1
Accept: */*
Cache-Control: no-cache
Postman-Token: 9cac7a81-3c3a-476f-bffd-5970231e5e4b
Host: localhost:8095
Accept-Encoding: gzip, deflate, br
Connection: keep-alive

```

### Response

```javascript


HTTP 200

X-Content-Type-Options: nosniff
X-XSS-Protection: 0
Cache-Control: no-cache, no-store, max-age=0, must-revalidate
Pragma: no-cache
Expires: 0
X-Frame-Options: DENY
Content-Type: application/json;charset=ISO-8859-1
Content-Length: 1689
Date: Thu, 28 Mar 2024 02:07:10 GMT
Keep-Alive: timeout=60
Connection: keep-alive


{
    "keys": [
        {
            "kty": "RSA",
            "x5t#S256": "s8j3rlQimrc94Z5yndQJ0SMYauDNanb9r75DuAIOh5E",
            "e": "AQAB",
            "kid": "kid-10000001",
            "x5c": [
                "MIIDizCCAnOgAwIBAgIJAL0TBni0g8DYMA0GCSqGSIb3DQEBCwUAMGsxCzAJBgNVBAYTAkFVMQwwCgYDVQQIEwNRTEQxETAPBgNVBAcTCEJyaXNiYW5lMREwDwYDVQQKEwhCb2J5IEluYzENMAsGA1UECxMEQm9ieTEZMBcGA1UEAxMQYmFuay5ib2J5LmNvbS5hdTAeFw0yNDAyMDMwMzExNTVaFw0yNDA1MDMwMzExNTVaMGsxCzAJBgNVBAYTAkFVMQwwCgYDVQQIEwNRTEQxETAPBgNVBAcTCEJyaXNiYW5lMREwDwYDVQQKEwhCb2J5IEluYzENMAsGA1UECxMEQm9ieTEZMBcGA1UEAxMQYmFuay5ib2J5LmNvbS5hdTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAN6/FaIyQnqq9Ai7sagVBnZeHoLj8jLRjBQz7NfuQwNKPmscKJxEUmD1LDYvw7+cUwCcYAcnzBGcBpkcnymbv2NUaPEwM6WgZiCiFfB7z+S3noMI7s4jPuTzdT2q99q5ML10wE8UWSThDyq53Ht374B3bOnEpf1CVUJlTgF6ArGsc+ZvvFbFjN3yETo1H8knihXpeZ57tildyp+rzoYYq0R3q0PQeKgbHOVfGTqgOf/9eSv2EnbWs0nNJgJw+lgVPFwuLCvHMaY7qKYQCph/jbuA87x0tGLlUI2yzr56JoMm6IBaqZgVMZygK+ENyTiL9GLcptovFCAqPZVKFBvXfcUCAwEAAaMyMDAwHQYDVR0OBBYEFDeHOia6juE0h+AUIw/9ja6bVQ9KMA8GA1UdEQQIMAaHBH8AAAEwDQYJKoZIhvcNAQELBQADggEBAKzs2UWd0epa8HtCi6HNS9/Ik3ATu03mvRXEbnux1oocwF0+VJHMwwj3wei3CAkeV9M1BPYWnAP/JKn1WzqKI0hjYba12WpQoB/chw0BnytupDE/JZLMjmZw7HgkmZKoWWqOLPPYvteijAJv0IJ18HlXqUDoKFV1Aa7q777fz98exXZ14OszL44WYhlnJtRUSL9w48la6+Mt6YITAhckN9xWQxlXsmgKmkhcHvdvqlw6of+5QRqNp49NTvlsFTPfAURSZsIAJ8uuFrtFMs8VchYn3y3lLENmDDEUXy+POAWAWYjMqzgB+rlvqErXVW5GRXZDvHhYJ+cnyxgUAr4Zoqc="
            ],
            "n": "3r8VojJCeqr0CLuxqBUGdl4eguPyMtGMFDPs1-5DA0o-axwonERSYPUsNi_Dv5xTAJxgByfMEZwGmRyfKZu_Y1Ro8TAzpaBmIKIV8HvP5LeegwjuziM-5PN1Par32rkwvXTATxRZJOEPKrnce3fvgHds6cSl_UJVQmVOAXoCsaxz5m-8VsWM3fIROjUfySeKFel5nnu2KV3Kn6vOhhirRHerQ9B4qBsc5V8ZOqA5__15K_YSdtazSc0mAnD6WBU8XC4sK8cxpjuophAKmH-Nu4DzvHS0YuVQjbLOvnomgybogFqpmBUxnKAr4Q3JOIv0Ytym2i8UICo9lUoUG9d9xQ"
        }
    ]
}
```

## 05_IntrospectToken
### Request

```javascript

POST http://localhost:8085/ms-auth-server/oauth2/introspect 


Content-Type: application/x-www-form-urlencoded
User-Agent: PostmanRuntime/7.37.1
Accept: */*
Cache-Control: no-cache
Postman-Token: b35f84cc-86db-40c9-ac6c-39389dd8ddbb
Host: localhost:8085
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
Content-Length: 801


client_id=client_secret_jwt_client&client_secret=client_secret_jwt_password&token=eyJraWQiOiI4NzgwZGY3ZC05YjhiLTQ4OTQtYWNhZi03MWFhZTRlMzA4NWUiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJwcml2YXRla2V5and0X2p3dF9jbGllbnQiLCJhdWQiOiJwcml2YXRla2V5and0X2p3dF9jbGllbnQiLCJuYmYiOjE3MTE1OTE2MzEsInNjb3BlIjpbImN1c3RvbWVyLnJlYWQiLCJjdXN0b21lci53cml0ZSIsImNvdW50cnkucmVhZCJdLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwODUvbXMtYXV0aC1zZXJ2ZXIiLCJleHAiOjE3MTE2MDYwMzEsImlhdCI6MTcxMTU5MTYzMX0.CQp-AdknNlDB0yhX7JSGNf0N1x43YkMklGt-fuAA_DZDZ4t2ZrQGj9aDH1bmGhfxSq6wsPjIGF7pRFJqkvDwKYZGoKkUe0galjvBSEhXTnFFY4QfHAYZ3brghwxgdOiITB0rEQYFYt_XZEb50YZ-MCb7FjCt17dheCUpIxpnnPbMweF9fWbW7ozmcqfzrPHlGTs1QX8PqpTdrQ_zdjysyDQpIcqKFZeY-5artYKAOT6C42lr88CYxHXQLKmfFn7iY1XVdnEFNCOmXZF5Pexgkz9biWsSLm2itJebC18wypRH-PsZKZwSzi5c0l3OqfpxvUF8yIN3d2YHPFmezYTNeQ
```

### Response

```javascript


HTTP 200

X-Content-Type-Options: nosniff
X-XSS-Protection: 0
Cache-Control: no-cache, no-store, max-age=0, must-revalidate
Pragma: no-cache
Expires: 0
X-Frame-Options: DENY
Content-Type: application/json
Transfer-Encoding: chunked
Date: Thu, 28 Mar 2024 02:07:11 GMT
Keep-Alive: timeout=60
Connection: keep-alive


{
    "active": true,
    "sub": "privatekeyjwt_jwt_client",
    "aud": [
        "privatekeyjwt_jwt_client"
    ],
    "nbf": 1711591631,
    "scope": "customer.read customer.write country.read",
    "iss": "http://localhost:8085/ms-auth-server",
    "exp": 1711606031,
    "iat": 1711591631,
    "client_id": "privatekeyjwt_jwt_client",
    "token_type": "Bearer"
}
```

## 06_accessResourceValidToken
### Request

```javascript

GET http://localhost:8091/ms-system/country/code/AUS 


Authorization: Bearer eyJraWQiOiI4NzgwZGY3ZC05YjhiLTQ4OTQtYWNhZi03MWFhZTRlMzA4NWUiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJwcml2YXRla2V5and0X2p3dF9jbGllbnQiLCJhdWQiOiJwcml2YXRla2V5and0X2p3dF9jbGllbnQiLCJuYmYiOjE3MTE1OTE2MzEsInNjb3BlIjpbImN1c3RvbWVyLnJlYWQiLCJjdXN0b21lci53cml0ZSIsImNvdW50cnkucmVhZCJdLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwODUvbXMtYXV0aC1zZXJ2ZXIiLCJleHAiOjE3MTE2MDYwMzEsImlhdCI6MTcxMTU5MTYzMX0.CQp-AdknNlDB0yhX7JSGNf0N1x43YkMklGt-fuAA_DZDZ4t2ZrQGj9aDH1bmGhfxSq6wsPjIGF7pRFJqkvDwKYZGoKkUe0galjvBSEhXTnFFY4QfHAYZ3brghwxgdOiITB0rEQYFYt_XZEb50YZ-MCb7FjCt17dheCUpIxpnnPbMweF9fWbW7ozmcqfzrPHlGTs1QX8PqpTdrQ_zdjysyDQpIcqKFZeY-5artYKAOT6C42lr88CYxHXQLKmfFn7iY1XVdnEFNCOmXZF5Pexgkz9biWsSLm2itJebC18wypRH-PsZKZwSzi5c0l3OqfpxvUF8yIN3d2YHPFmezYTNeQ
User-Agent: PostmanRuntime/7.37.1
Accept: */*
Cache-Control: no-cache
Postman-Token: 3abb5f9b-ca22-40d8-91bb-324415f493d4
Host: localhost:8091
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
Cookie: JSESSIONID=329F1F130E025EB2DF4334CDF1B470E9

```

### Response

```javascript


HTTP 200

X-Content-Type-Options: nosniff
X-XSS-Protection: 0
Cache-Control: no-cache, no-store, max-age=0, must-revalidate
Pragma: no-cache
Expires: 0
X-Frame-Options: DENY
Content-Type: application/json
Transfer-Encoding: chunked
Date: Thu, 28 Mar 2024 02:07:10 GMT
Keep-Alive: timeout=60
Connection: keep-alive


{
    "code": "AUS",
    "name": "AUSTRALIA"
}
```

## 07_revoke-token
### Request

```javascript

POST http://localhost:8085/ms-auth-server/oauth2/revoke 


content-type: application/json
User-Agent: PostmanRuntime/7.37.1
Accept: */*
Cache-Control: no-cache
Postman-Token: a407b8b7-52f1-4394-b816-9d10e0390cd0
Host: localhost:8085
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
Content-Length: 1464


client_assertion=eyJraWQiOiJraWQtMTAwMDAwMDEiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJwcml2YXRla2V5and0X2p3dF9jbGllbnQiLCJzdWIiOiJwcml2YXRla2V5and0X2p3dF9jbGllbnQiLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjgwODUvbXMtYXV0aC1zZXJ2ZXIvb2F1dGgyL3Rva2VuIiwidGVzdCI6ImFiYyIsImV4cCI6MTcxMTU5NTIzMH0.bPAZubo8gz4mWdcYlo_i5jWN9mGi1fUCikxx_grHmmXkuQcyIFg5OV1HGawbyZ2J1noplLN6bgb2v6HOng8muLNmImeQ3as9J1d-ToJ-XFpvirQ9yEP7pZhKu4h0Q-KbfqO8T42TdPGPTT6kmEnrN7R8s0Zcjfbfg3bvwhIeqqsxCldrCeZSOd5IMtPaCSYhFwgJYBKgyeqtESvazTkOOqQKYttyd8w79PA1tJw3CbpCA9SWDWPPlPMwlB8wf4oJ2PkxwAmuLH4CthDayp2SGsgGPQTo5HxjGwlpUmaaccx1_XUsGWVkb8Vn3PUzHXMg8pkHamb2HGmORskn0Uo0AA&client_id=privatekeyjwt_jwt_client&client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer&token=eyJraWQiOiI4NzgwZGY3ZC05YjhiLTQ4OTQtYWNhZi03MWFhZTRlMzA4NWUiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJwcml2YXRla2V5and0X2p3dF9jbGllbnQiLCJhdWQiOiJwcml2YXRla2V5and0X2p3dF9jbGllbnQiLCJuYmYiOjE3MTE1OTE2MzEsInNjb3BlIjpbImN1c3RvbWVyLnJlYWQiLCJjdXN0b21lci53cml0ZSIsImNvdW50cnkucmVhZCJdLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwODUvbXMtYXV0aC1zZXJ2ZXIiLCJleHAiOjE3MTE2MDYwMzEsImlhdCI6MTcxMTU5MTYzMX0.CQp-AdknNlDB0yhX7JSGNf0N1x43YkMklGt-fuAA_DZDZ4t2ZrQGj9aDH1bmGhfxSq6wsPjIGF7pRFJqkvDwKYZGoKkUe0galjvBSEhXTnFFY4QfHAYZ3brghwxgdOiITB0rEQYFYt_XZEb50YZ-MCb7FjCt17dheCUpIxpnnPbMweF9fWbW7ozmcqfzrPHlGTs1QX8PqpTdrQ_zdjysyDQpIcqKFZeY-5artYKAOT6C42lr88CYxHXQLKmfFn7iY1XVdnEFNCOmXZF5Pexgkz9biWsSLm2itJebC18wypRH-PsZKZwSzi5c0l3OqfpxvUF8yIN3d2YHPFmezYTNeQ
```

### Response

```javascript


HTTP 200

X-Content-Type-Options: nosniff
X-XSS-Protection: 0
Cache-Control: no-cache, no-store, max-age=0, must-revalidate
Pragma: no-cache
Expires: 0
X-Frame-Options: DENY
Content-Length: 0
Date: Thu, 28 Mar 2024 02:07:11 GMT
Keep-Alive: timeout=60
Connection: keep-alive



```

## 08_IntrospectTokenWithRoveokedToken
### Request

```javascript

POST http://localhost:8085/ms-auth-server/oauth2/introspect 


Content-Type: application/x-www-form-urlencoded
User-Agent: PostmanRuntime/7.37.1
Accept: */*
Cache-Control: no-cache
Postman-Token: 68c0efb2-1084-47f1-a3aa-bc0fc3f29642
Host: localhost:8085
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
Content-Length: 801


client_id=client_secret_jwt_client&client_secret=client_secret_jwt_password&token=eyJraWQiOiI4NzgwZGY3ZC05YjhiLTQ4OTQtYWNhZi03MWFhZTRlMzA4NWUiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJwcml2YXRla2V5and0X2p3dF9jbGllbnQiLCJhdWQiOiJwcml2YXRla2V5and0X2p3dF9jbGllbnQiLCJuYmYiOjE3MTE1OTE2MzEsInNjb3BlIjpbImN1c3RvbWVyLnJlYWQiLCJjdXN0b21lci53cml0ZSIsImNvdW50cnkucmVhZCJdLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwODUvbXMtYXV0aC1zZXJ2ZXIiLCJleHAiOjE3MTE2MDYwMzEsImlhdCI6MTcxMTU5MTYzMX0.CQp-AdknNlDB0yhX7JSGNf0N1x43YkMklGt-fuAA_DZDZ4t2ZrQGj9aDH1bmGhfxSq6wsPjIGF7pRFJqkvDwKYZGoKkUe0galjvBSEhXTnFFY4QfHAYZ3brghwxgdOiITB0rEQYFYt_XZEb50YZ-MCb7FjCt17dheCUpIxpnnPbMweF9fWbW7ozmcqfzrPHlGTs1QX8PqpTdrQ_zdjysyDQpIcqKFZeY-5artYKAOT6C42lr88CYxHXQLKmfFn7iY1XVdnEFNCOmXZF5Pexgkz9biWsSLm2itJebC18wypRH-PsZKZwSzi5c0l3OqfpxvUF8yIN3d2YHPFmezYTNeQ
```

### Response

```javascript


HTTP 200

X-Content-Type-Options: nosniff
X-XSS-Protection: 0
Cache-Control: no-cache, no-store, max-age=0, must-revalidate
Pragma: no-cache
Expires: 0
X-Frame-Options: DENY
Content-Type: application/json
Transfer-Encoding: chunked
Date: Thu, 28 Mar 2024 02:07:11 GMT
Keep-Alive: timeout=60
Connection: keep-alive


{
    "active": false
}
```

## 09_accessResourceRevokedToken
### Request

```javascript

GET http://localhost:8091/ms-system/country/code/AUS 


Authorization: Bearer eyJraWQiOiI4NzgwZGY3ZC05YjhiLTQ4OTQtYWNhZi03MWFhZTRlMzA4NWUiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJwcml2YXRla2V5and0X2p3dF9jbGllbnQiLCJhdWQiOiJwcml2YXRla2V5and0X2p3dF9jbGllbnQiLCJuYmYiOjE3MTE1OTE2MzEsInNjb3BlIjpbImN1c3RvbWVyLnJlYWQiLCJjdXN0b21lci53cml0ZSIsImNvdW50cnkucmVhZCJdLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwODUvbXMtYXV0aC1zZXJ2ZXIiLCJleHAiOjE3MTE2MDYwMzEsImlhdCI6MTcxMTU5MTYzMX0.CQp-AdknNlDB0yhX7JSGNf0N1x43YkMklGt-fuAA_DZDZ4t2ZrQGj9aDH1bmGhfxSq6wsPjIGF7pRFJqkvDwKYZGoKkUe0galjvBSEhXTnFFY4QfHAYZ3brghwxgdOiITB0rEQYFYt_XZEb50YZ-MCb7FjCt17dheCUpIxpnnPbMweF9fWbW7ozmcqfzrPHlGTs1QX8PqpTdrQ_zdjysyDQpIcqKFZeY-5artYKAOT6C42lr88CYxHXQLKmfFn7iY1XVdnEFNCOmXZF5Pexgkz9biWsSLm2itJebC18wypRH-PsZKZwSzi5c0l3OqfpxvUF8yIN3d2YHPFmezYTNeQ
User-Agent: PostmanRuntime/7.37.1
Accept: */*
Cache-Control: no-cache
Postman-Token: a705dd90-aff8-45a7-8078-9f68952637fa
Host: localhost:8091
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
Cookie: JSESSIONID=329F1F130E025EB2DF4334CDF1B470E9

```

### Response

```javascript


HTTP 401

WWW-Authenticate: Bearer error="invalid_token", error_description="Provided token isn't active", error_uri="https://tools.ietf.org/html/rfc6750#section-3.1"
X-Content-Type-Options: nosniff
X-XSS-Protection: 0
Cache-Control: no-cache, no-store, max-age=0, must-revalidate
Pragma: no-cache
Expires: 0
X-Frame-Options: DENY
Content-Length: 0
Date: Thu, 28 Mar 2024 02:07:10 GMT
Keep-Alive: timeout=60
Connection: keep-alive



```

collection run complete!
