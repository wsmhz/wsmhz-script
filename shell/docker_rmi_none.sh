## 删除带有<none>的镜像
id=`docker images|grep eureka|awk '{print $3}'`
if [ "$id" != "" ]; then
  echo "删除<none>镜像"
  docker rmi $id
else
  echo "不存在none镜像"
fi