# Stage 1: Build Flutter web app
FROM debian:bookworm-slim AS flutter-build
RUN apt-get update && apt-get install -y curl git unzip xz-utils && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /flutter
ENV PATH="/flutter/bin:${PATH}"
RUN flutter config --enable-web && flutter precache --web
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
