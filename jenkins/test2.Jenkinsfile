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
pipeline {
    agent any
    environment {
        payload = jsonParse("$payload")
        repositoryName= jsonBuilder("$payload.repository.name" )
    }
    stages {
        def shortCommit
        stage('更新代码') {
            steps {
                echo "${payload}"
                echo "*********"
                echo "${name}"
                echo "*********"
                echo "${GIT_BRANCH}"
                echo "*********"
                echo "${GIT_URL}"
            }
        }
    }
}