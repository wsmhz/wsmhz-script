echo "=========开始自动化部署========="

echo "======开始打包所依赖的项目======"

echo "===========进入git项目wsmhz-common===================="
cd /developer/git-repository/wsmhz-common

echo "==========git切换分之到master==============="
git checkout master

echo "==================git fetch======================"
git fetch

echo "==================git pull master======================"
git pull origin master

echo "===========编译并跳过单元测试===================="
mvn clean install -Dmaven.test.skip=true

echo "===========进入git项目wsmhz-security目录============="
cd /developer/git-repository/wsmhz-security

echo "==========git切换分之到v2.1==============="
git checkout v2.1

echo "==================git fetch======================"
git fetch

echo "==================git pull v2.1======================"
git pull origin v2.1

echo "===========编译并跳过单元测试===================="
mvn clean install -Dmaven.test.skip=true

echo "======结束打包所依赖的项目======"

echo "===========进入git项目wsmhz-web-shop目录============="
cd /developer/git-repository/wsmhz-web-shop

echo "==========git切换分之到v1.1==============="
git checkout v1.1

echo "==================git fetch======================"
git fetch

echo "==================git pull v1.1======================"
git pull origin v1.1


echo "===========编译并跳过单元测试===================="
mvn clean install -Dmaven.test.skip=true


echo "==========切换到wsmhz-shop-back目录============"
cd /developer/git-repository/wsmhz-web-shop/wsmhz-shop-back/target

echo "========停止正在运行的wmshz-shop-back========"
ps aux |grep rbac.jar |grep -v grep |awk '{print $2}' |xargs kill -9


echo "================sleep 5s========================="
for i in {1..5}
do
        echo $i"s"
        sleep 1s
done

echo "==========删除之前的启动日志文件rbac-log.txt========="
rm -rf rbac-log.txt

echo "===========开始启动wsmhz-shop-back项目======="
nohup java -jar rbac.jar > rbac-log.txt 2>&1 &

echo "==========切换到wsmhz-shop-front目录============"
cd /developer/git-repository/wsmhz-web-shop/wsmhz-shop-front/target


echo "========停止正在运行的wmshz-shop-front========"
ps aux |grep shop-web.jar |grep -v grep |awk '{print $2}' |xargs kill -9


echo "================sleep 5s========================="
for i in {1..5}
do
        echo $i"s"
        sleep 1s
done

echo "==========删除之前的启动日志文件shop-web-log.txt========="
rm -rf shop-web-log.txt

echo "===========开始启动wsmhz-shop-front项目======="
nohup java -jar shop-web.jar > shop-web-log.txt 2>&1 &


echo "=======结束自动化部署====="
ps -aux | grep java