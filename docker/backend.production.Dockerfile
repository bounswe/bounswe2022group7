
FROM maven:3.8.6-eclipse-temurin-17 AS builder
WORKDIR /build
COPY . .
RUN mvn clean package -e -X
 
 
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
EXPOSE 8080
COPY --from=builder /build/target/*.jar /app/*.jar
ENTRYPOINT ["java", "-jar", "/app/*.jar" ]