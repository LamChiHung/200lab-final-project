FROM maven:3.6.3-openjdk-17 AS build
WORKDIR /app
COPY ./src/demo/ ./
RUN mvn clean install -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /app
RUN useradd demo
ARG DEPENDENCY=/app/target
COPY --from=build ${DEPENDENCY}/demo-0.0.1-SNAPSHOT.jar app.jar
COPY ./src/demo/elastic-apm-agent-1.52.1.jar ./elastic-apm-agent-1.52.1.jar
RUN chown -R demo /app
EXPOSE 8080
USER demo
ENTRYPOINT ["java","-javaagent:/app/elastic-apm-agent-1.52.1.jar","-Delastic.apm.service_name=demo","-Delastic.apm.server_urls=http://ec2-3-0-18-28.ap-southeast-1.compute.amazonaws.com:8200","-Delastic.apm.application_packages=com.example","-jar","app.jar"]