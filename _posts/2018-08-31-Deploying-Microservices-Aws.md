---
layout:     default
title:      "Deploying microservices to AWS"
subtitle:   "Deploying microservices to AWS"
description: "Deploying microservices to AWS"
date:       2018-08-30 12:00:00
author:     "Boby Thomas"
header-img: "images/logo_black.png"
categories: technical
---



# Deploying microservices to AWS  

## Demo
<iframe width="560" height="315" src="https://www.youtube.com/embed/915ePPMwVCk" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

## Architecture
![Architecture](/diagrams/aws/microservices-aws-fargate.png){:class="img-responsive"}

This is a reference architecture for deploying microservices to aws. 
 - Services are deployed to aws in docker containers. 
 - Services can be build using any language / technology as long as it can be dockerized.
 - Comes with a reference network design for **security** and **high availability**  
 - Infrastructure as code - Cloud formation to create 
    - VPC
    - Network links (internet gateway, nat wateway).
    - Private multi AZ subnets for deploying fargate tasks.
    - Public subnets for exposing service to internet.
    - Logs in to cloud watch.
    - Application load balancer and target groups to route traffic to appropriate services based on url.
        - For example /api/v1/customerservice/* -> customer service fargate task
        - For example /api/v1/orderservice/* -> order service fargate task
    - Easy to add new serices to the service landscape.
    - Deployments/ update to services without an outage. 

## Code
Follow github link [here](https://github.com/bobypt/microservices-aws-fargate)

## Detailed descriptions
 - Containerising API server - [Part 1]({% post_url 2018-08-30-Containerize-and-deploy-node-api %}) 
 - Create network infrastructure for secure deployment of applications. [Part 2]({% post_url 2018-09-01-Create-VPC-Public-Private-Subnet %})
 - Scaling up and down. ```TODO```
 - Seamlessly updating (deploying a new version of API) the server without an outage. ```TODO```

 
