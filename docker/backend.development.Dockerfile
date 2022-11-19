
FROM maven:3.8.6-eclipse-temurin-17
WORKDIR /app
COPY ./pom.xml .
COPY ./src/ ./src
RUN cd /app
ENTRYPOINT ["mvn", "spring-boot:run"] 