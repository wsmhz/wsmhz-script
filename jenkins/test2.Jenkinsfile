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
    stage('更新代码') {

      echo "${payload}"
        echo "${repositoryName}"
    }
}