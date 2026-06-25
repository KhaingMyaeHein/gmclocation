FROM eclipse-temurin:21 AS build

WORKDIR /app
COPY . .

RUN chmod +x gradlew
RUN ./gradlew clean build -x test --no-daemon

FROM eclipse-temurin:21

WORKDIR /opt/app

# safer copy (avoids wildcard failure)
COPY --from=build /app/build/libs/ /app/libs/

EXPOSE 8082

ENTRYPOINT ["sh", "-c", "java -jar /app/libs/*.jar"]