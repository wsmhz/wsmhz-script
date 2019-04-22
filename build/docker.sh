cat > Dockerfile <<EOF
FROM docker.i.sixi.com/base/openjdk:8u181

ADD target/${PROJECT_NAME}.jar /root

WORKDIR /root

CMD ["java", "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005", "-XX:-OmitStackTraceInFastThrow", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Xmx2G", "-jar", "${PROJECT_NAME}.jar"]
EOF