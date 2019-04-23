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

        checkout([$class: 'GitSCM', branches: [[name: 'master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'f60b9246-0a0b-4240-a96c-5b307c212e4e', url: url: "${GIT_URL}"]]])

        echo "${GIT_URL}"
        echo "${repositoryName}"
    }
}