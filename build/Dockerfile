FROM java:8
MAINTAINER com.wsmhz

ARG PROJECT_NAME=test

ADD target/$PROJECT_NAME.jar /root

WORKDIR /root

CMD ["java", "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005", "-XX:-OmitStackTraceInFastThrow", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Xmx2G", "-jar", "$PROJECT_NAME.jar"]