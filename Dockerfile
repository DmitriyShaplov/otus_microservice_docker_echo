FROM openjdk:17-jdk-alpine AS build
WORKDIR /workspace/app
RUN apk update && apk add git
RUN git clone https://github.com/DmitriyShaplov/otus_microservice_docker_echo.git
WORKDIR otus_microservice_docker_echo
RUN git checkout master
RUN chmod +x gradlew && ./gradlew clean build
RUN mkdir -p build/dependency && (cd build/dependency; jar -xf ../libs/docker-echo.jar)

FROM openjdk:17-jdk-alpine
ARG DEPENDENCY=/workspace/app/otus_microservice_docker_echo/build/dependency
COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app
ENTRYPOINT ["java","-cp","app:app/lib/*","ru.shaplov.dockerecho.DockerEchoApplication"]
EXPOSE 8000