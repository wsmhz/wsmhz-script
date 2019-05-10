echo "=========开始自动化部署========="

echo "===========进入git项目wsmhz-back-shop目录 4201端口============="
cd /developer/git-repository/wsmhz-back-shop

echo "==========git切换分之v1.1==============="
git checkout v1.1

echo "==================git fetch======================"
git fetch

echo "==================git pull v1.1======================"
git pull origin v1.1

echo "==================npm install======================"
npm install

echo "==================压缩打包项目======================"

ng build --prod --aot

echo "=========结束自动化部署========="