
FROM maven:3.8.6-eclipse-temurin-17
RUN addgroup devgroup; adduser --ingroup devgroup --disabled-password developer
USER developer
WORKDIR /app
COPY ./pom.xml .
COPY ./src/ ./src
RUN cd /app
ENTRYPOINT ["mvn", "spring-boot:run"] 