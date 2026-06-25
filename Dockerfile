FROM eclipse-temurin:21 AS build

WORKDIR /app
COPY . .

RUN chmod +x gradlew
RUN ./gradlew clean build -x test --no-daemon || true

RUN ls -R /app/build

FROM eclipse-temurin:21

WORKDIR /opt/app

COPY --from=build /app/build/libs/ /app/libs/

ENTRYPOINT ["sh", "-c", "java -jar /app/libs/*.jar"]