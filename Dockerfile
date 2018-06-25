FROM java:8
RUN apt-get update
RUN apt-get install -y maven

RUN apt-get install -y curl

RUN curl http://apache.otenet.gr/dist/tomcat/tomcat-8/v8.5.31/bin/apache-tomcat-8.5.31.tar.gz --output tomcat.tar.gz
RUN mkdir /tomcat
RUN tar -xvzf tomcat.tar.gz --directory /tomcat
RUN chmod 777 -R /tomcat/apache-tomcat-8.5.31

WORKDIR /app

ADD pom.xml /app/pom.xml

RUN ["mvn", "install"]
RUN chmod 777 /app/target/osk.war

RUN mv /app/target/osk.war /tomcat/apache-tomcat-8.5.31/webapps/osk.war

CMD /tomcat/apache-tomcat-8.5.31/bin/startup.sh
EXPOSE 8080