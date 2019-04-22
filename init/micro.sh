VER=${1:master}
S='sixi-micro-service-parent sixi-micro-service-common sixi-micro-service-app-parent sixi-micro-service-app-api-parent'

for s in ${S}; do  
  rm -rf ${s}
  git clone https://git.i.sixi.com/sixi-micro-service/${s}.git
  pushd ${s}
  git checkout -b ${VER} origin/${VER}
  mvn install
  popd
done