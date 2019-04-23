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

    stage('更新代码') {

      echo "${payload}"

    }
}