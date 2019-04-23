node() {
    def shortCommit;
    stage('更新代码') {
      def scm
      retry(3) {
        scm = checkout([$class: 'GitSCM', branches: [[name: '${GIT_BRANCH}']], userRemoteConfigs: [[url: '${GIT_URL}']]])
      }
      echo "${GIT_URL}"
      echo "${GIT_BRANCH}"
    }
}