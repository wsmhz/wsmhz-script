FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER com.huyang

ARG PROJECT_NAME
ENV PROJECT_NAME=${PROJECT_NAME}

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ADD ${PROJECT_NAME}.jar /root
WORKDIR /root

CMD sleep 150;java -Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8 -Xms128m -Xmx256m -Djava.security.egd=file:/dev/./urandom -jar ${PROJECT_NAME}.jar