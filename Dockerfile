# 1. JDK 설치(되어있는 이미지를 고르기)
FROM eclipse-temurin:17 as build

# 2. 소스코드 가져오기
# 2-1. 작업 공간 마련하기(없을 경우 생성 후 이동)
WORKDIR /app
# 2-2. 소스코드 복사해오기
COPY . .

# 3. gradlew 실행 권한 부여
RUN chmod +x ./gradlew

# 3. 소스코드 빌드
# RUN: 이미지를 설정하기 위한 명령이다.
RUN ./gradlew bootJar

# 3-1. Jar 파일 이동
RUN mv build/libs/*.jar app.jar


# 여기부터 새로운 stage가 시작된다.
FROM eclipse-temurin:17-jre

WORKDIR /app

# COPY를 하되, 위 build 단계에서 만든 app.jar만 가져온다.
COPY --from=build /app/app.jar .

# 4. Jar 파일 실행
# CMD: 이미지를 가지고 만든 컨테이너가 실행할 명령이다.
CMD ["java", "-jar", "app.jar"]

# 4 + @. 컨테이너가 실행되었을 때 요청을 듣고 있는 포트를 나열해준다.
EXPOSE 8080
