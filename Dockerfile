FROM maven:3-jdk-8 as builder
WORKDIR /app

COPY pom.xml /app/pom.xml
RUN mvn dependency:go-offline -B

COPY /src /app/src
RUN mvn package && cp target/podyn-*.jar app.jar

FROM openjdk:8
ARG APP_VERSION=1.0
WORKDIR /app
COPY --from=builder /app/app.jar /app/podyn.jar
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]