import groovy.json.JsonSlurperClassic 
import groovy.json.JsonBuilder
@NonCPS
def jsonParse(def json) {
    new groovy.json.JsonSlurperClassic().parseText(json)
}
pipeline {
    agent any
    environment {
        payload = jsonParse("$payload")
    }
    stages {
        stage('init') {
            steps {
                String name= new JsonBuilder("$payload.repository.name" ).toPrettyString()
                echo "${name}"
            }
        }
    }
}