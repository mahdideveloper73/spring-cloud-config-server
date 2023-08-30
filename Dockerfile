# AS <NAME> to name this stage as maven
FROM maven:latest AS maven
LABEL MAINTAINER="sgwebfreelancer@gmail.com"

WORKDIR /usr/src/app
COPY . /usr/src/app

RUN    mkdir /root/.m2
COPY ./settings.xml /root/.m2
# Compile and package the application to an executable JAR
RUN mvn package

# For Java 17,
FROM eclipse-temurin:17-jdk-alpine

ARG JAR_FILE=spring-cloud-config-server-0.0.1-SNAPSHOT.jar

WORKDIR /opt/app

# Copy the spring-boot-api-tutorial.jar from the maven stage to the /opt/app directory of the current stage.
COPY --from=maven /usr/src/app/target/${JAR_FILE} /opt/app/

ENTRYPOINT ["java","-jar","spring-cloud-config-server-0.0.1-SNAPSHOT.jar"]







#FROM eclipse-temurin:17-jdk-alpine
#VOLUME /tmp
#ARG JAR_FILE
#COPY ${JAR_FILE} app.jar
#ENTRYPOINT ["java","-jar","/app.jar"]