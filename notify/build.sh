curl -X POST \
  'https://oapi.dingtalk.com/robot/send?access_token=7345e00368e57c8dd5ecd02813c8bb68be1c7e336679dc4134331be56af3885c' \
  -H 'Content-Type: application/json' \
  -d '{"msgtype":"markdown","markdown":{"title": "项目构建完成","text":"- '"项目 [${PROJECT_NAME}](${JOB_URL}) 自动构建 [#${BUILD_NUMBER}](${BUILD_URL})"' 已完成"}}'