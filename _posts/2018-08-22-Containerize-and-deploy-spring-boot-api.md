---
layout:     default
title:      "Containerize and deploy spring boot app to aws in 10 mins"
subtitle:   "Containerize and deploy spring boot app to aws in 10 mins"
description: "Containerize and deploy spring boot app to aws in 10 mins"
date:       2018-08-20 12:00:00
author:     "Boby Thomas"
header-img: "images/logo_black.png"
categories: technical
---


# Containerize and deploy spring boot app to aws in 10 mins
In this tutorial, we will containarize and deploy a simple spring boot app to aws.

## Create a simple spring boot app
Go to (SPRING INITIALIZR)[https://start.spring.io/] and create a simple spring boot app. 
Please choose
 - gradle
 - Dependency - Web
 - appropriate group and atrtefact names

 Generate project and download.

## Compile and run the app 
 - extract the zip file
 - Compile and build
 
 ```
 ./gradlew clean build
 ```
 - Import the project to your favourite ide
 - Add a simple controller

 ```
 package org.bpt.demo;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DemoController {

    @RequestMapping("/greet")
    public String greet() {
        return "hello";
    }
}

 ```
 - Build the project again
```
./gradlew clean build
```
 - Run the application
 - Go to your favourite browser and access ``` http://localhost:8080/greet ```


```
curl localhost:8080/greet
```

```
curl localhost:8080/actuator/health
```

You should see the message "hello"

## Containerize the spring boot app

 - Add a file ```Dockerfile``` with following content

```
FROM openjdk:8-jdk-alpine
VOLUME /tmp
ARG JAR_FILE
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

```

- Build a docker image using docker-gradle plugin
```

```
- Build image
```
./gradlew build docker
```

- Test image locally

```
docker run -p 8080:8080 -t org.bpt/demo
```

## Push image to ECR

```
$(aws ecr get-login --no-include-email --region ap-southeast-2)
```


If you get below error, add permission policy "AmazonEC2ContainerRegistryFullAccess" for the user.

```
An error occurred (AccessDeniedException) when calling the GetAuthorizationToken operation: User: arn:aws:iam::708464146667:user/Developer1 is not authorized to perform: ecr:GetAuthorizationToken on resource: *
```

- Tag image

```
docker tag org.bpt/demo:latest 708464146667.dkr.ecr.ap-southeast-2.amazonaws.com/spring-boot-demo:latest
```

- Push image to ECR
```
docker push 708464146667.dkr.ecr.ap-southeast-2.amazonaws.com/spring-boot-demo:latest
```



```
CMD-SHELL, curl localhost:8080/actuator/health || exit 1
```