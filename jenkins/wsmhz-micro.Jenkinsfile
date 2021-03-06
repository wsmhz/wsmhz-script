import groovy.json.JsonSlurperClassic 
import groovy.json.JsonBuilder
@NonCPS
def jsonParse(def json) {
    new groovy.json.JsonSlurperClassic().parseText(json)
}
@NonCPS
def jsonBuilder(def json) {
    String result = new JsonBuilder(json).toPrettyString()
    "${result}".substring(1, "${result}".length() - 1)
}
node() {
    def mvnHome = tool 'maven3.6.1'
    def javaHome = tool 'jdk1.8'
    env.PATH = "${mvnHome}/bin:${javaHome}/bin:${env.PATH}"

    def SHORTCOMMIT
    def payload = jsonParse("$payload")
    def REPOSITORY_NAME= jsonBuilder("$payload.repository.name")
    def GIT_URL = jsonBuilder("$payload.repository.clone_url" )
    def BUILD_BRANCH = jsonBuilder("$payload.repository.default_branch" )
    def SENDER = jsonBuilder("$payload.sender.login" )
    def PUSHER = jsonBuilder("$payload.pusher.name" )
    def COMPARE_URL = jsonBuilder("$payload.compare" )
    def buildImage = "${REPOSITORY_NAME}".endsWith("-service");
    stage('更新代码') {
        def scm 
        retry(3) {
            scm = checkout([$class: 'GitSCM', branches: [[name: "${BUILD_BRANCH}"]], userRemoteConfigs: [[credentialsId: '6ada9c6d-d42f-4ace-bb96-5bb7cb392ad9', url: "${GIT_URL}"]]])
        }
        currentBuild.displayName = "${REPOSITORY_NAME}"
        currentBuild.description = "构建分支: ${scm.GIT_BRANCH}     合并人: ${SENDER}      提交人: ${PUSHER}"
        SHORTCOMMIT = scm.GIT_COMMIT.substring(0, 10)
        currentBuild.description = currentBuild.description + "     差异对比: [${SHORTCOMMIT}](${COMPARE_URL})"
    }
    stage('通知检测') {
      // sh 'curl -q -X POST "http://webhook.internal.wsmhz.com/api/notify?GROUP_NAME=${GROUP_NAME}&PROJECT_NAME=${PROJECT_NAME}&BUILD_URL=${BUILD_URL}&JOB_URL=${JOB_URL}"'
        // curl -X POST \
        //   'https://oapi.dingtalk.com/robot/send?access_token=7345e00368e57c8dd5ecd02813c8bb68be1c7e336679dc4134331be56af3885c' \
        //   -H 'Content-Type: application/json' \
        //   -d '{"msgtype":"markdown","markdown":{"title": "项目构建完成","text":"- '"项目 [${PROJECT_NAME}](${JOB_URL}) 自动构建 [#${BUILD_NUMBER}](${BUILD_URL})"' 已完成"}}'
    }
    stage('构建项目') {
       sh "'mvn' clean -Dmaven.test.skip=true install"
    }
    stage('构建镜像') {
        if(buildImage){
            try {
                sh "wget -qO- https://raw.githubusercontent.com/wsmhz/wsmhz-script/master/shell/docker_rmi_none.sh | bash"
            }
            catch(e) {
                sh "echo 删除带<none>的旧镜像失败，可能是该镜像正在被使用"
            }
            sh "wget https://raw.githubusercontent.com/wsmhz/wsmhz-script/master/build/Dockerfile"
            sh "echo '输出生成的Dockerfile' && cat Dockerfile"
            def result = sh returnStdout: true ,script: "docker images docker.wsmhz.cn/${REPOSITORY_NAME}:${BUILD_BRANCH} | awk 'NR==2{print\$3}'"
            try {
                if ("${result}") {
                    sh "echo 删除旧镜像"
                    sh "docker rmi --force ${result}"
                    sh "echo 删除旧镜像成功"
                }
            }
            catch(e){
                sh "echo 删除旧镜像失败，可能是该镜像正在被使用"
            }
            sh "docker build -t docker.wsmhz.cn/${REPOSITORY_NAME}:${BUILD_BRANCH} --build-arg PROJECT_NAME=${REPOSITORY_NAME} ."
        } 
        else{
           echo "api项目跳过镜像构建过程"
        }
    }
    stage('推送镜像') {
        if(buildImage){
            sh "docker push docker.wsmhz.cn/${REPOSITORY_NAME}:${BUILD_BRANCH}"
        }
        else{
           echo "api项目跳过推送镜像过程"
        }
    }
    stage('清理工作空间') {
      cleanWs()
    }

}