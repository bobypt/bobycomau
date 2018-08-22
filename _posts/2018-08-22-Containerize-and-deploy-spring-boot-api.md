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
In this tutorial, we will containarize and deploy a simple java spring boot app to aws.

## Pre-requisites
 - Java JDK 8 or above
 - Docker 17 or above
 - AWS account 
 - AWS CLI

## Create a simple spring boot app
Go to [SPRING INITIALIZR](https://start.spring.io/) and create a simple spring boot app. 
For this demo, I choose
 - gradle
 - Dependency - Web
 - appropriate group (org.bpt) and atrtefact names(demo). 

 Generate project and download.

## Compile and run the app 
 - extract the zip file
 - Compile and build
 
 ```shell
 ./gradlew clean build
 ```
 - Import the project to your favourite ide
 - Add a controller

 ```java
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
 - Go to your favourite browser and access `http://localhost:8080/greet` You should see the message "hello"


```
curl localhost:8080/greet
```
Also check health endpoint

```
curl localhost:8080/actuator/health
```


## Containerize the spring boot app

 - Add a file `Dockerfile` with following content

```
FROM openjdk:8-jdk-alpine
VOLUME /tmp
ARG JAR_FILE
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

```

## Build docker images

You can directly build the above dockerfile but we will use (Docker Gradle Plugin)[https://github.com/palantir/gradle-docker] so that creating java artefacts and building docker image can be done in one single step.



- Add docker gradle plugin to `build.gradle`

```groovy
buildscript {
....
	repositories {
        ....
		maven {
			url "https://plugins.gradle.org/m2/"
		}
	}
	dependencies {
        .....
		classpath('gradle.plugin.com.palantir.gradle.docker:gradle-docker:0.13.0')
        .....
	}
}

....
apply plugin: 'com.palantir.docker'
....


docker {
	dependsOn build
	name "${project.group}/${bootJar.baseName}"
	files bootJar.archivePath
	buildArgs(['JAR_FILE': "${bootJar.archiveName}"])
}


```
- Build a new image with latest code
```
./gradlew build docker
```

- Check that new image is created

```
docker images -a
```

- Test image locally

```
docker run -p 8080:8080 -t org.bpt/demo
```

Use curl commands above and make sure that application is running successfully. You have successfully created docker image of your application.


## Push image to Amazon Elastic Container Registry(ECR)

- Go to aws console and create a new registry ```spring-boot-demo```

- Get login to ECR

```
$(aws ecr get-login --no-include-email --region ap-southeast-2)
```


If you get below error, add permission policy "AmazonEC2ContainerRegistryFullAccess" for the user.

```
An error occurred (AccessDeniedException) when calling the GetAuthorizationToken operation: User: arn:aws:iam::708464146667:user/Developer1 is not authorized to perform: ecr:GetAuthorizationToken on resource: *
```

- Tag the docker image

```
docker tag org.bpt/demo:latest 708464146667.dkr.ecr.ap-southeast-2.amazonaws.com/spring-boot-demo:latest
```

- Push image to ECR
```
docker push 708464146667.dkr.ecr.ap-southeast-2.amazonaws.com/spring-boot-demo:latest
```

- Go to aws console and make sure that the image is present in the repository.

## Run the new image in aws

- Create a new Task definition. Please follow the video for details.

```
CMD-SHELL, curl localhost:8080/actuator/health || exit 1
```


- Create cluster

- Run task


## Conclusion
In this demo, we created, dockerized and deployed a simple spring boot application. Next step, we will create a VPC with private subnets, run the container inside  private subnets and use a public facing load balancer to route traffic to containers running in multi AZs.