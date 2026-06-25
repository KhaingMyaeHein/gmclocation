FROM eclipse-temurin:21 AS build

WORKDIR /app
COPY . .

RUN chmod +x gradlew
RUN ./gradlew clean build -x test --no-daemon

FROM eclipse-temurin:21

WORKDIR /opt/traccar

COPY --from=build /app/target/tracker-server.jar .
COPY conf/traccar.xml ./conf/traccar.xml

EXPOSE 8082

CMD ["java","-jar","tracker-server.jar","conf/traccar.xml"]