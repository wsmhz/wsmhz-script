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
    def shortCommit;
    def payload = jsonParse("$payload")
    def repositoryName= jsonBuilder("$payload.repository.name")
    def GIT_URL = jsonBuilder("$payload.repository.clone_url" )
    stage('更新代码') {
        def scm
        retry(3) {
            scm = checkout([$class: 'GitSCM', branches: [[name: '${GIT_BRANCH}']], userRemoteConfigs: [[url: '${GIT_URL}']]])
        }
        echo "${payload}"
        echo "${repositoryName}"
    }
}