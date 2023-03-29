#FROM tomcat:8.0.20-jre8
#COPY target/maven-web-application*.war /usr/local/tomcat/webapps/maven-web-application.war
#COPY /var/lib/jenkins/workspace/maven-web-app-deploy-to-docker/target/maven-web-application.war /usr/local/tomcat/webapps/maven-web-application.war
FROM maven as build
WORKDIR /mavenbuild
COPY . .
RUN mvn clean package

FROM tomcat:jre8-alpine
COPY --from=build /mavenbuild/target/maven-web-application*.war /usr/local/tomcat/webapps/maven-web-application.war
