### https://docs.docker.com/develop/develop-images/multistage-build/

FROM maven:3.5.2-jdk-8-alpine AS MAVEN_BUILD
COPY pom.xml /build/
COPY src /build/src/
WORKDIR /build/
RUN mvn -B clean package -DskipTests

# FROM openjdk:8-jdk-alpine AS MAVEN_BUILD
# COPY mvnw .
# COPY .mvn .mvn
# COPY pom.xml /build/
# COPY src /build/src/
# WORKDIR /build/
# RUN mvn -B clean package -DskipTests

#FROM openjdk:8
#FROM openjdk:8-jre-alpine
FROM tomcat

#ENV JAVA_OPTS=-javaagent:/usr/skywalking/agent/skywalking-agent.jar
#ADD target/k8s.jar /opt/app.jar
#COPY --from=MAVEN_BUILD  /build/target/example.smallest-0.0.1-SNAPSHOT.war  /opt/ROOT.war

COPY --from=MAVEN_BUILD  /build/target/example.smallest-0.0.1-SNAPSHOT.war  /usr/local/tomcat/webapps/ROOT.war
#CMD ["java", "-jar", "/opt/app.jar"]
#COPY /opt/ROOT.war /usr/local/tomcat/webapps/


#From tomcat:8.0.51-jre8-alpine
#RUN rm -rf /usr/local/tomcat/webapps/*
#COPY ./target/employee-producer-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
#CMD ["catalina.sh","run"]