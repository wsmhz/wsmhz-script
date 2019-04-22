TAG=sixi/${JOB_NAME}:latest
INTERNALTAG=docker.internal.sixi.com/${TAG}
cat > Dockerfile <<EOF
FROM java:8-jdk-alpine

ADD target/${JOB_NAME}.jar /root

WORKDIR /root

CMD ["java", "-jar", "${JOB_NAME}.jar"]
EOF
# docker build -f Dockerfile . -t ${INTERNALTAG}
# docker push ${INTERNALTAG}
