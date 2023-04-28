---
name: Setup playground
layout: default
---

# Start local playground

## Pre-requisites
 - Java 17
 - Docker / docker-compose

## Clone repo
```git clone git@github.com:bobypt/oauth-demo.git```


## Build all the services
```./oauth.sh build```

## Start services locally
```docker-compose up```

## Check service status
```./oauth.sh health```

## Stop services

```Ctrl + c``` on the shell where docker-compose is running  

OR  

```docker-compose down```