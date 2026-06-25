FROM eclipse-temurin:21 AS build

RUN apt-get update && apt-get install -y protobuf-compiler

WORKDIR /app
COPY . .

RUN chmod +x gradlew
RUN ./gradlew build -x test --no-daemon

FROM eclipse-temurin:21

WORKDIR /opt/app
COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8082

ENTRYPOINT ["java", "-jar", "app.jar"]