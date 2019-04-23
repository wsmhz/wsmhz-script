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
    def SHORTCOMMIT;
    def payload = jsonParse("$payload")
    def REPOSITORY_NAME= jsonBuilder("$payload.repository.name")
    def GIT_URL = jsonBuilder("$payload.repository.clone_url" )
    def BUILD_BRANCH = jsonBuilder("$payload.repository.default_branch" )
    def SENDER = jsonBuilder("$payload.sender.login" )
    def PUSHER = jsonBuilder("$payload.pusher.name" )
    def COMPARE_URL = jsonBuilder("$payload.compare" )
    stage('更新代码') {
        def scm 
        retry(3) {
            scm = checkout([$class: 'GitSCM', branches: [[name: "${BUILD_BRANCH}".substring(1, "${BUILD_BRANCH}".length() - 1)]], userRemoteConfigs: [[credentialsId: '6ada9c6d-d42f-4ace-bb96-5bb7cb392ad9', url: "${GIT_URL}".substring(1, "${GIT_URL}".length() - 1)]]])
        }
        currentBuild.displayName = "${REPOSITORY_NAME}"
        currentBuild.description = "构建分支: ${scm.GIT_BRANCH}<br>合并人: ${SENDER}<br>提交人: ${PUSHER}"
        SHORTCOMMIT = scm.GIT_COMMIT.substring(0, 10)
        currentBuild.description = currentBuild.description + "<br>差异对比: [${SHORTCOMMIT}](${COMPARE_URL})"

        



        
    }
}