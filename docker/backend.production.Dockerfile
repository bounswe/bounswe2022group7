
FROM maven:3.8.6-eclipse-temurin-17 AS builder
RUN addgroup buildergroup; adduser --ingroup buildergroup --disabled-password builder
USER builder
WORKDIR /build
COPY pom.xml .
COPY src/ .src/
RUN cd /build && mvn package
 
 
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
EXPOSE 8080
COPY --from=builder /build/target/*.jar /app/*.jar
ENTRYPOINT ["java", "-jar", "/app/*.jar" ]