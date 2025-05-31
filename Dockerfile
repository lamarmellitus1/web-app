# Use an official Tomcat base image
FROM tomcat:9.0-jdk17

# Remove default apps (optional cleanup)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file into the webapps directory
COPY target/01-maven-web-app.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat (inherited from base image CMD)
