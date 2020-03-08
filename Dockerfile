FROM maven:3-jdk-8 as builder
WORKDIR /app
COPY /src /app/src
COPY pom.xml /app/pom.xml
RUN mvn package

FROM openjdk:8
ARG APP_VERSION=1.0
WORKDIR /app
COPY --from=builder "/app/target/podyn-${APP_VERSION}.jar" /app/podyn.jar
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]