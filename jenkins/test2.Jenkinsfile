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

        checkout([$class: 'GitSCM', branches: [[name: 'master']], userRemoteConfigs: [[credentialsId: '2d24cb3e-eb9e-4e85-b819-5f3555531270', url: "${GIT_URL}"]]])
        
        echo "${GIT_URL}"
        echo "${repositoryName}"
    }
}