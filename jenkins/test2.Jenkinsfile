import groovy.json.JsonSlurperClassic 
import groovy.json.JsonBuilder
@NonCPS
def jsonParse(def json) {
    new groovy.json.JsonSlurperClassic().parseText(json)
}
@NonCPS
def jsonBuilder(def json) {
    new JsonBuilder(json).toPrettyString()
}
node() {
    def mvnHome = tool 'maven3.0.5'
    def SHORTCOMMIT
    def payload = jsonParse("$payload")
    def REPOSITORY_NAME= jsonBuilder("$payload.repository.name")
    def GIT_URL = jsonBuilder("$payload.repository.clone_url" )
    def BUILD_BRANCH = jsonBuilder("$payload.repository.default_branch" )
    def SENDER = jsonBuilder("$payload.sender.login" )
    def PUSHER = jsonBuilder("$payload.pusher.name" )
    def COMPARE_URL = jsonBuilder("$payload.compare" )
    stage('更新代码') {
        sh "source /etc/profile"
        def scm 
        retry(3) {
            scm = checkout([$class: 'GitSCM', branches: [[name: "${BUILD_BRANCH}".substring(1, "${BUILD_BRANCH}".length() - 1)]], userRemoteConfigs: [[credentialsId: '6ada9c6d-d42f-4ace-bb96-5bb7cb392ad9', url: "${GIT_URL}".substring(1, "${GIT_URL}".length() - 1)]]])
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
       sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
    }
}