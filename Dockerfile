FROM openjdk:8-jre-alpine

ARG JAR_FILE
ADD ${JAR_FILE} /usr/share/app.jar

ENTRYPOINT ["java", "-cp", "/usr/share/app.jar", "ch.xog.dockerfile.App"]
