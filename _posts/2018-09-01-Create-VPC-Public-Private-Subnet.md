---
layout:     default
title:      "Create VPC with public and private subnets"
subtitle:   "Create VPC with public and private subnets"
description: "Create VPC with public and private subnets. "
date:       2018-08-28 12:00:00
author:     "Boby Thomas"
header-img: "images/logo_black.png"
categories: technical
---

# Demo

```TODO```

# Architecture

![Architecture](/diagrams/aws/VPC-Diagram.png){:class="img-responsive"}

We will create a VPC with two public and private subnets in two different availability zones. Instances created in public subnet can have public IP and route table with a configuration to route traffic on 0.0.0.0/0 to Internet Gateway (igw). Instances created in private subnet will only have a private ip and cannot be accessed from internet. They are accessable only from public subnets. Usually, internet facing load balancers are created in public subnets. Most of the servers like API servers will be in private subnets. 

 - VPC => 10.0.0.0/16 => IP range 10.0.0.0 to 10.0.255.255
 - PublicSubnetOne => 10.0.0.0/24 => 10.0.0.0 - 10.0.0.255
 - PublicSubnetTwo => 10.0.1.0/24 => 10.0.1.0 - 10.0.1.255
 - PrivateSubnetOne => 10.0.100.0/24 => 10.0.100.0 - 10.0.100.255
 - PrivateSubnetOne => 10.0.101.0/24 => 10.0.101.0 - 10.0.101.255

## Cloudformation
Use cloudformation [script](https://github.com/bobypt/docker-node/blob/master/aws/cloudformation/vpc-network.yml) to create VPC automatically.