FROM gradle:8-jdk17 AS build

WORKDIR /app
COPY . .

RUN ./gradlew build -x test
RUN chmod +x gradlew

FROM eclipse-temurin:17

WORKDIR /opt/traccar

COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8082

ENTRYPOINT ["java"]
CMD ["-jar", "app.jar"]