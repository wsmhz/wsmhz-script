!/bin/bash
## 删除带有<none>的镜像
docker images|grep none|awk '{print $3}'|xargs docker rmi