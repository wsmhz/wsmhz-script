FROM docker.wsmhz.cn/java8
MAINTAINER com.wsmhz

ARG PROJECT_NAME
ENV PROJECT_NAME=${PROJECT_NAME}
ENV LANG C.UTF-8

ADD target/${PROJECT_NAME}.jar /root

WORKDIR /root

CMD java -Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8 -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -XX:-OmitStackTraceInFastThrow -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -Xmx2G -jar ${PROJECT_NAME}.jar