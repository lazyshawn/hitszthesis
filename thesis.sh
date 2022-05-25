#!/bin/bash
# ======================================================
# Function:
#   提供使用文档类的快捷命令。
# Usage:
#   bash thesis.sh [option]
# Options:
#   -l / --load  : 加载示例文件;
#   -b / --build : 编译Tex工程项目;
#   -c / --clean : 删除编译过程文件;
# Author:
#   Lazyshawn
# Contact:
#   20s053030@stu.hit.edu.cn
# More information:
#   https://github.com/lazyshawn/hitszthesis_master
# ======================================================

# Check update
check_for_update() {
  BRANCH=master
  LOCAL=$(git log $BRANCH -n 1 --pretty=format:"%H")
  REMOTE=$(git log remotes/origin/$BRANCH -n 1 --pretty=format:"%H")

  if [ $LOCAL = $REMOTE ]; then
      echo "This repo is Up-to-date."
  else
      echo "===> This repo need update."
  fi
}

# Load demo
loadDemo () {
  files=$(ls ./demo)
  echo "===> Begin loading demo ..."
  echo "\$TexProject: $(pwd)"
  # 遍历demo文件夹下的所有文件, 并复制缺少的文件
  for file in ${files}
  do
    if [ -e ./${file} ]; then
      echo "${file} already exist."
    else
      cp -r ./demo/${file} ${file}
      echo "Get copy: ${file}"
    fi
  done
  echo "===> Finish load demo."
}

# Save demo
saveDemo () {
  texClean
  files=$(ls ./demo)
  echo "===> Begin save demo ..."
  echo "\$TexProject: $(pwd)"
  for file in ${files}
  do
    rm -rf ./demo/${file}
    cp -r ./${file} ./demo/${file}
    echo "Get update: ${file}"
  done
  echo "===> Demo saved."
}

# Tex build: xelatex -> bibtex -> xelatex -> xelatex
texBuild () {
  # Run `latexmk -h` for help.
  latexmk -xelatex $1
  # echo -e "========== Xelatex No.1 =========="
  # xelatex $1.tex
  # checkError $?
  # echo -e "========== Compile references =========="
  # bibtex $1
  # checkError $?
  # echo -e "========== Xelatex No.2 =========="
  # xelatex $1.tex
  # checkError $?
  # echo -e "========== Xelatex No.3 =========="
  # xelatex $1.tex
}


# Tex clean
texClean () {
  # latexmk -CA
  rm -rf *.aux *.blg *.out *.bbl *.log *.toc *.entoc *.xdv\
    *.synctex.gz *.fdb_latexmk  *.fls
  rm -rf */*.aux */*.fdb_latexmk */*.log */*.fls
  rm -rf */*/*.aux
}

# Check error
checkError () {
  if [ "$1" != 0 ]; then
    echo "Enconter error: $1"
    exit 1
  fi
}


# ====== main ======
check_for_update;
opts=$(getopt -o lsb::c -l load,save,build::,clean -- "$@")
[ $? != 0 ] && exit 1
eval set -- "$opts"   # 将$parameters设置为位置参数
# 循环解析位置参数
while [ -n "$1" ]
do
  case "$1" in
    -l|--load) loadDemo;
      shift;;
    -s|--save) saveDemo;
      shift;;
    -b|--build)
      case "$2" in
        "") texBuild "main"; shift 2;;  # 没有给可选参数
        *) texBuild $2; shift 2;;  # 给了可选参数
      esac;;
    -c|--clean) texClean;
      shift;;
    --) break ;;    # 开始解析非选项类型的参数，break后，它们都保留在$@中
    *) echo break ;;
  esac
done

# ======================================================
# End of script

