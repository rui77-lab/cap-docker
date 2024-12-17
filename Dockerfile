FROM openjdk:21-jdk
ARG JAR_FILE=target/cap_docker-exec.jar
COPY ${JAR_FILE} cap_docker-exec.jar
ENTRYPOINT ["java","-jar","-Dspring.profiles.active=cloud","/cap_docker-exec.jar"]
