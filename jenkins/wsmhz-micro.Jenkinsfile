pipeline {
    agent any
    stages {
        stage('׼������') {
            steps {
                echo "��ʼ����������"
                checkout scm
                pom = readMavenPom file: 'location/pom.xml'
                docker_host = "docker.ryan-miao.com"
                img_name = "${pom.groupId}-${pom.artifactId}"
                docker_img_name = "${docker_host}/${img_name}"
                echo "group: ${pom.groupId}, artifactId: ${pom.artifactId}, version: ${pom.version}"
                echo "docker-img-name: ${docker_img_name}"
            }
        }
    }
}