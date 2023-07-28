FROM openjdk:8-jdk

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR ${CATALINA_HOME}

RUN apt-get install -y wget

RUN wget https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.90/bin/apache-tomcat-8.5.90.tar.gz;
RUN tar -xf apache-tomcat-8.5.90.tar.gz  --strip-components=1;

RUN find . -name "*.bat" -exec rm -rf {} \;
RUN rm -rf *tomcat*.tar.gz;
RUN mv webapps webapps.org
RUN mkdir webapps

COPY ./target/ROOT.war $CATALINA_HOME/webapps
EXPOSE 8080
CMD ["catalina.sh", "run"]
