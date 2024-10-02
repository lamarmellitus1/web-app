# Stage 1: Build the Java application
FROM maven:3.8.6-openjdk-11 AS builder

# Set the working directory
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code and build the application
COPY src ./src
RUN mvn clean package

# Stage 2: Build the runtime image with Tomcat 8
FROM tomcat:8.5-jdk11-openjdk-slim AS runtime

# Set the working directory
WORKDIR /usr/local/tomcat/webapps/

# Copy the WAR file from the build stage
COPY --from=builder /app/target/*.war ./app.war

# Expose the necessary ports
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]
