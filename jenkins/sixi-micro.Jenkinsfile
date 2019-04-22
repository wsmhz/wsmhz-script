node('docker') {
  ws(GROUP_NAME + '-' + PROJECT_NAME + '-' + GIT_BRANCH) {
    def shortCommit;
    stage('更新代码') { // for display purposes
      // Get some code from a Gogs repository
      def scm
      echo "start*******"
      echo "${PROJECT_NAME}"
      echo "end*******"
      currentBuild.displayName = "${PROJECT_NAME}"
      currentBuild.description = "构建分支: ${scm.GIT_BRANCH}<br>合并人: ${SENDER}<br>提交人: ${PUSHER}"
      shortCommit = scm.GIT_COMMIT.substring(0, 10)
      // currentBuild.description = currentBuild.description + "<br>提交编号: [${shortCommit}](${GIT_URL.substring(0, GIT_URL.lastIndexOf('.'))}/commit/${shortCommit})"
      currentBuild.description = currentBuild.description + "<br>差异对比: [${shortCommit}](${COMPARE_URL})"
    }
    stage('收集结果') {
      //archiveArtifacts 'target/*.jar'
    }
    stage('清理工作空间') {
      cleanWs()
    }
  }
}