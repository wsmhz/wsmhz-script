#!/usr/bin/env bash

DIR="${PWD##*/}"
echo ${DIR}
git remote set-url origin http://git.internal.sixi.com/sixi-micro-service/${DIR}.git
git remote -v

for module in $(ls); do
    if [ -d ${module} ]; then
      cd ${module}
      DIR="${module%/}"
      echo ${DIR}
      git remote set-url origin http://git.internal.sixi.com/sixi-micro-service/${DIR}.git
      git remote -v
      cd ../
    fi
done
