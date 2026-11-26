# Bước 1: Dùng Maven để build file WAR từ source code
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app

# Khắc phục lỗi mạng / IPv6 / timeout khi Maven tải plugin trên Render
ENV MAVEN_OPTS="-Djava.net.preferIPv4Stack=true -Dhttp.keepAlive=false -Dmaven.wagon.http.retryHandler.count=5"

COPY pom.xml .
COPY src ./src

# Build gói ứng dụng (bỏ qua test, dùng chế độ batch và ưu tiên IPv4)
RUN mvn clean package -DskipTests -B -Djava.net.preferIPv4Stack=true

# Bước 2: Chạy ứng dụng bằng Tomcat 10 (hỗ trợ Jakarta EE 10 / Servlet 6.0)
FROM tomcat:10.1-jdk21-temurin

# Xóa các ứng dụng mặc định trong Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Đổi port mặc định 8080 thành 10000 theo chuẩn mặc định của Render
RUN sed -i 's/port="8080"/port="10000"/' ${CATALINA_HOME}/conf/server.xml

# Copy file ROOT.war vào webapps
COPY --from=build /app/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 10000

CMD ["catalina.sh", "run"]
