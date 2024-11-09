
FROM gradle:jdk21-alpine AS build

COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src

RUN gradle bootJar --no-daemon

FROM  openjdk:21-jdk-slim

RUN mkdir /app
COPY --from=build /home/gradle/src/build/libs/*.jar /app/authorization-server-0.0.1-SNAPSHOT.jar

EXPOSE 9000

ENTRYPOINT ["java","-jar","/app/authorization-server-0.0.1-SNAPSHOT.jar"]