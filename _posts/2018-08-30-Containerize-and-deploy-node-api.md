---
layout:     default
title:      "Create a simple API in node and dockerize it"
subtitle:   "Create a simple API in node and dockerize it"
description: "Create a simple API in node and dockerize it"
date:       2018-08-30 12:00:00
author:     "Boby Thomas"
header-img: "images/logo_black.png"
categories: technical
---


# Create a simple API in node and dockerize it
For the demo of microservices, we will create a simple node API. The technology or framework or language doesn't really matter once we dockerize the api. I chose node simply because its lightweight and I can deploy with least compute.

## API
We expose two APIs.


 - API endpoint

```
/info

{
   "id":"34caea30-acbd-11e8-9861-138b18ec2ca2",  => Random id which uniquely identifies the runnaing instance. 
   "version":"1"  => Version of the api. 
}

```

 - Health endpoint

```
/health

{
   "status":"OK"
}

```

## Code 
Checkout the code from [github](https://github.com/bobypt/docker-node)

Follow the instructions in the readme to build image and run containers.

To keep the memory footprint small, we chosse the base docker image ```FROM node:8-slim```. Please see more information on this [here](https://derickbailey.com/2017/03/09/selecting-a-node-js-image-for-docker/)


## Push the image to Amazon Elastic Container Registry (ECR)
```TODO```
