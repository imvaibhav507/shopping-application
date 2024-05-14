# Use an OpenJDK base image
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file of your Spring Boot application into the container
COPY target/shopping-application-0.0.1-SNAPSHOT.jar /app/shopping-application-0.0.1.jar

# Expose port (if needed)
EXPOSE 8080

# Command to run the Spring Boot application when the container starts
CMD ["java", "-jar", "your-application.jar"]
