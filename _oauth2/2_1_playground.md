---
name: Setup playground
layout: default
---

# Start local playground

## Demo
<iframe width="560" height="315" src="https://www.youtube.com/embed/nVif4GnlIO8" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

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