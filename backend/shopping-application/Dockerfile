FROM eclipse-temurin:17-jdk-alpine
VOLUME /tmp
COPY backend/shopping-application/target/shopping-application-0.0.1-SNAPSHOT.jar shopping-application-0.0.1.jar
ENTRYPOINT ["java","-jar","/shopping-application-0.0.1.jar"]