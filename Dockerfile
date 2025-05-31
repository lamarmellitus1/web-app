# ------------ Stage 1: Build WAR using Maven ------------
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy Maven project files
COPY pom.xml .
COPY src ./src

# Package the WAR file
RUN mvn clean package

# ------------ Stage 2: Deploy to Tomcat ------------
FROM tomcat:9.0-jdk17

# Remove default web apps (optional)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file from the build stage
COPY --from=build /app/target/01-maven-web-app.war /usr/local/tomcat/webapps/ROOT.war

# Expose default Tomcat port
EXPOSE 8080

# Start Tomcat (default CMD is already set in the base image)
