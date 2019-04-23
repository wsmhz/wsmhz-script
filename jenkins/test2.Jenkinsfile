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
        name= jsonBuilder("$payload.repository.name" )
    }
    stages {
        stage('init build params') {
            steps {
                echo "${payload}"
                echo "*********"
                echo "${name}"
            }
        }
    }
}