echo ${JOB_NAME}
TAG=sixi/${JOB_NAME}:latest
INTERNALTAG=docker.internal.sixi.com/${TAG}
cat > Dockerfile <<EOF
FROM java:8-jdk-alpine

ADD target/${JOB_NAME}.jar /root

WORKDIR /root

CMD ["java", "-jar", "${JOB_NAME}.jar", "--spring.cloud.config.uri=http://config:8083", "--spring.cloud.config.label=master", "--spring.cloud.config.fail-fast=true", "--spring.cloud.config.retry.max-attempts=10", "--spring.cloud.config.retry.max-interval=10000", "--spring.cloud.config.retry.initial-interval=1000"]
EOF
# docker build -f Dockerfile . -t ${INTERNALTAG}
# docker push ${INTERNALTAG}
# curl -q -X POST "http://test.erp.internal.sixi.com/api/${JOB_NAME}/shutdown"
# sleep 1
scp target/${JOB_NAME}.jar root@192.168.2.209:/home/app/erp
ssh -t root@192.168.2.209 "/home/app/kill.sh ${JOB_NAME}"
#curl -q "http://ci.internal.sixi.com/job/RemoteKillService/buildWithParameters?token=88888888&PROJECT_NAME=${JOB_NAME}&REMOTE_SERVER=192.168.2.209"




