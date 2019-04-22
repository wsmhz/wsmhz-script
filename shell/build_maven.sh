GROUP=${1}
NAME=${2}
./run_command_on_each_node.sh $(cat<<EOF
cd /tmp::
rm -rf ${NAME}::
git clone https://jtb:325325@git.i.sixi.com/${GROUP}/${NAME}.git::
cd ${NAME}::
/home/maven/bin/mvn install
EOF
)