HOSTS=(
    192.168.2.200
    192.168.2.202
    192.168.2.206
    192.168.2.207
    192.168.2.208
    192.168.2.209
    192.168.2.212
)

sshc="ssh -Tq "

run_command_on_each_node() {
    COMMAND=$(echo ${*:?No Command Space!} | sed s@::@\\n@g -)
    for host in ${HOSTS[*]}; do
        echo "Run Command On ${host}..."
        #echo "${COMMAND}"
        ${sshc} root@${host}<<EOF
${COMMAND}
EOF
        echo "Run Finish..."
    done
}

run_command_on_each_node ${*}
