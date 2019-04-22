FROM node:8.15.0-alpine

RUN apk add --no-cache tini

ENTRYPOINT ["/sbin/tini", "--"]

WORKDIR /root

RUN wget https://jtb:325325@git.i.sixi.com/SixiOpenPlatform/APIGateway/archive/master.tar.gz && tar -xvzf master.tar.gz

WORKDIR /root/apigateway
RUN npm config set registry https://repo.i.sixi.com/repository/taobao && npm i

CMD ["node", "index.js"]
