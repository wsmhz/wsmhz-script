!/bin/bash
## 删除所有已退出的未使用的容器
docker ps -a|grep "Exited" | awk '{print $1}' | xargs docker stop
docker ps -a|grep "Exited" | awk '{print $1}' | xargs docker rm