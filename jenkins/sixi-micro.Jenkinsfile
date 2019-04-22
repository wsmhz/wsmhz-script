node('docker') {
  ws(GROUP_NAME + '-' + PROJECT_NAME + '-' + GIT_BRANCH) {
    def shortCommit;
    stage('更新代码') { // for display purposes
      // Get some code from a Gogs repository
      def scm
      retry(3) {
        scm = checkout([$class: 'GitSCM', branches: [[name: '${GIT_BRANCH}']], userRemoteConfigs: [[credentialsId: 'JTB', url: '${GIT_URL}']]])
      }
      currentBuild.displayName = "${PROJECT_NAME}"
      currentBuild.description = "构建分支: ${scm.GIT_BRANCH}<br>合并人: ${SENDER}<br>提交人: ${PUSHER}"
      shortCommit = scm.GIT_COMMIT.substring(0, 10)
      // currentBuild.description = currentBuild.description + "<br>提交编号: [${shortCommit}](${GIT_URL.substring(0, GIT_URL.lastIndexOf('.'))}/commit/${shortCommit})"
      currentBuild.description = currentBuild.description + "<br>差异对比: [${shortCommit}](${COMPARE_URL})"
    }
    stage('通知检测') {
      sh 'curl -q -X POST "http://webhook.internal.sixi.com/api/notify?GROUP_NAME=${GROUP_NAME}&PROJECT_NAME=${PROJECT_NAME}&BUILD_URL=${BUILD_URL}&JOB_URL=${JOB_URL}"'
    }
    stage('构建项目') {
      // 如果是微服务项目就强制更新 bootstrap.yml
      if (fileExists('src/main/resources/bootstrap.yml')) {
        sh "wget -qOsrc/main/resources/bootstrap.yml https://git.i.sixi.com/jtb/script/raw/master/conf/bootstrap.yml"
        sh "if [[ -n `cat pom.xml | grep SPRING-BOOT-1.5` ]]; then sed -i s@instance-id@instanceId@g src/main/resources/bootstrap.yml; sed -i s@ip-address@ipAddress@g src/main/resources/bootstrap.yml; fi"
      }
      withMaven(maven: 'Maven') {
        sh "mvn clean -Dmaven.test.skip=true deploy"
      }
    }
    def buildImage = "${PROJECT_NAME}".endsWith("-service");
    def image;
    docker.withRegistry('https://docker.i.sixi.com', 'Mr_jtb') {
      stage('生成Dockerfile') {
        if (buildImage) {
          // generate Dockerfile
          sh "wget -qO- https://git.i.sixi.com/jtb/script/raw/master/build/docker.sh | bash"
          sh "echo '输出生成的Dockerfile' && cat Dockerfile"
        }
      }
      stage('构建镜像') {
        if (buildImage) {
        // Build docker image
          image = docker.build(GROUP_NAME.toLowerCase() + "/${PROJECT_NAME}:${GIT_BRANCH}")
        }
      }
      stage('推送镜像') {
        if (buildImage) {
          // Push the container to custom Registry
          image.push()
          if ("${GIT_BRANCH}" == "master") {
            image.push(shortCommit)
            image.push("latest")
          }
        }
      }
    }
    stage('收集结果') {
      //archiveArtifacts 'target/*.jar'
    }
    stage('清理工作空间') {
      cleanWs()
    }
  }
}