#!/usr/bin/env bash
# d16264bf0c250ca9bed1f6e4e4b22a4dcfcc215e
# https://api.github.com/repos/  仓库api
# https://api.github.com/orgs
# curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}' > /dev/null 2>&1   
set -e


################# 用户填写部分，请自行修改  注意：全部用小写字母 #####################
# maven groupId
groupId=com.wsmhz.shop
# 组织名称
groupName=wsmhz
# 父仓库名称
parentRepoName=wsmhz-shop
# maven artifactId
artifactId=product-service-api
# 选项:micro api
type=api


################################  以下请勿修改 #############################
################################  以下请勿修改 #############################
################################  以下请勿修改 #############################
echo "开始自动化创建..."
## TODO验证参数
if [[ -z "${type}" ]] || [[ -z "$(echo "micro api" | grep "${type}")" ]]; then
    echo "Unknown Type ${type} ! Support type: [micro, api]"
    exit 1
fi

# 一些常量
RemoteHost=https://github.com
APIHost=https://api.github.com
packageDir=${groupId//.//}/${artifactId//-//}  # . 替换成 /  - 替换成 /  java包名目录
username=`git config github.user`
token=`git config github.token`

# 一些函数
# api_post(){
#     curl -u "$username:$token" "${APIHost}${1:?Empty api path!}" -o/dev/null -d "${2:?Empty api data!}"
# }

api_code(){
    curl -u "$username:$token" -kqsw '%{http_code}' "${APIHost}${1:?Empty api path!}" -o/dev/null
}

# 权限校验
if [ "$username" = "" ]; then
    echo "Could not find username, run 'git config --global github.user <username>'"
    exit 1
fi
if [ "$token" = "" ]; then
    echo "Could not find token, run 'git config --global github.token <token>'"
    exit 1
fi
if [[ "$(api_code /repos/wsmhz/wsmhz-config-repository)" != "200" ]]; then
    echo "Bad credentials, 401"
    exit 1
else
    echo "success oauth github"
fi

############################ 开始创建项目 #############################

# 检查父仓库是否存在
if [[ ! -d ${parentRepoName} ]] ;then
    if [[ "$(api_code /repos/${groupName}/${parentRepoName})" == "200" ]]; then
        git clone ${RemoteHost}/${groupName}/${parentRepoName}.git
        git submodule update --init
        git submodule foreach git checkout master
        git submodule foreach git pull origin master
        echo "${RemoteHost} remote origin already exist project ${parentRepoName}!!"
    else
        echo "创建父仓库"
        mkdir ${parentRepoName} 
    fi
fi
cd ${parentRepoName}

# 项目目录创建 分type
projectName=${artifactId}
baseDir='config constant controller enums domain domain/entity domain/form domain/vo service service/impl' #目录结构
if [[ "${type}" == "api" ]]; then
    baseDir='api config constant enums domain domain/form domain/vo'
fi
# 检查项目仓库是否存在
if [[ "$(api_code /repos/${groupName}/${projectName})" == "200" ]]; then
    echo "${RemoteHost} remote origin already exist project ${projectName}!!"
    exit 0
fi
if [[ -d ${projectName} ]] ;then
    echo "${projectName} already exist!!"
    exit 0
fi
echo "创建项目目录" ${projectName}
mkdir ${projectName}
cd ${projectName}

# 创建项目文件
# 创建目录
echo "创建Java代码/资源/类库目录"
mkdir -p "src/main/java/${packageDir}"
mkdir -p "src/main/resources/"

echo "创建基础目录结构..."
touch ./src/main/java/${packageDir}/.gitkeep
for dir in ${baseDir}; do
    echo "创建目录 ${dir} ..."
    mkdir -p "src/main/java/${packageDir}/${dir}"
    touch ./src/main/java/${packageDir}/${dir}/.gitkeep
done

replacePackageName() {
    local file=${1:?No File  Space}
    sed -i s/com.template/${groupId}.${artifactId//-/.}/g ${file}
    temp=${artifactId//-/}
    sed -i s/template/${temp^}/g ${file}
}

# 创建主类和配置文件
classFileName=${artifactId//-/}Application.java
# 复制文件
echo "复制Git忽略文件..."
wget https://raw.githubusercontent.com/wsmhz/wsmhz-script/master/conf/.gitignore --no-check-certificate
case ${type} in
    api)
        wget https://raw.githubusercontent.com/wsmhz/wsmhz-script/master/conf/api-pom.xml --no-check-certificate
        mv api-pom.xml  pom.xml
        ;;
    micro)
        wget https://raw.githubusercontent.com/wsmhz/wsmhz-script/master/conf/micro-pom.xml --no-check-certificate
        mv micro-pom.xml  pom.xml

        wget https://raw.githubusercontent.com/wsmhz/wsmhz-script/master/conf/templateApplication.java --no-check-certificate
        mv templateApplication.java ./src/main/java/${packageDir}/${classFileName^}
        wget https://raw.githubusercontent.com/wsmhz/wsmhz-script/master/conf/bootstrap.yml --no-check-certificate
        mv bootstrap.yml ./src/main/resources
        replacePackageName ./src/main/java/${packageDir}/${classFileName}
        ;;
    *)
        ;;
esac
# 替换readme文件
wget wget https://raw.githubusercontent.com/wsmhz/wsmhz-script/master/conf/README.md --no-check-certificate
sed -i s/template/${artifactId}/g README.md
#替换pom.xml文件内容
echo "替换pom.xml文件内容..."
sed -i s/template.groupId/${groupId}/g pom.xml
sed -i s/template-artifactId/${artifactId}/g pom.xml

# echo "初始化本地Git仓库..."
# git init 2>&1 > /dev/null
# git add . 2>&1 > /dev/null
# git commit -q -m "Create & Init ${projectName} Project..." 2>&1 > /dev/null

# echo "初始化远程仓库..."
# # 创建项目
# curl -u "$username:$token" ${APIHost}/user/repos -d "{\"name\":\"${projectName}\", \"private\":false}"
# # api_post "/user/repos" "{\"name\":\"${projectName}\", \"private\":true}"

# # 推送项目
# echo "推送至远程仓库..."
# git remote add origin ${RemoteHost}/${groupName}/${projectName}.git 2>&1 > /dev/null
# git push origin master -f 2>&1 > /dev/null
# git push origin master:release -f 2>&1 > /dev/null
# git push origin master:dev -f 2>&1 > /dev/null

# echo "新增子项目到父模块..."
# cd ../
# if [[ ! -d ".git" ]]; then
#     git init 2>&1 > /dev/null
# fi
# if [[ -z "$(git remote -v)" ]]; then
#     curl -u "$username:$token" ${APIHost}/user/repos -d "{\"name\":\"${parentRepoName}\", \"private\":false}"
#     # api_post "/user/repos" "{\"name\":\"${parentRepoName}\", \"private\":true}"
#     git remote add origin ${RemoteHost}/${groupName}/${parentRepoName}.git
#     wget wget https://raw.githubusercontent.com/wsmhz/wsmhz-script/master/conf/README.md --no-check-certificate
#     sed -i s/template/${parentRepoName}/g README.md
# fi
# if [[ -z "$(cat .git/config | grep submodule)" ]]; then
#     git submodule init 2>&1 > /dev/null
# fi
# git submodule add ${RemoteHost}/${groupName}/${projectName}.git 2>&1 > /dev/null
# git add . 2>&1 > /dev/null
# git commit -m "add submodule ${projectName}..."
# git push origin master

echo "组织 ${groupName} 项目 ${projectName} 创建完成!"
popd
