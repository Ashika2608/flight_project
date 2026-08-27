# Stage 1: Build Flutter web app (using prebuilt Flutter image - faster & reliable)
FROM ghcr.io/cirruslabs/flutter:stable AS flutter-build
WORKDIR /app
COPY flight_frontend/ .
RUN flutter pub get && flutter build web

# Stage 2: Build Spring Boot backend, embedding the Flutter web build as static files
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY flight_backend/ .
COPY --from=flutter-build /app/build/web ./src/main/resources/static
RUN mvn clean package -DskipTests

# Stage 3: Runtime
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
