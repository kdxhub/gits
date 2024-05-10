#!/bin/bash

#初始化
goal=https://kdxhub.github.io/gits/gits.sh
p=$(echo ~)/.kdx.gits
echo 默认目录$p
echo 当前用户$(whoami)
function title() {
#usage: title [TitleText]
  clear
  echo ''
  echo '      GITS.SH on Termux'
  if [ -n "$1" ]; then
      echo "      ❖  部署向导→ $1"
    else
      echo '      ❖  部署向导'
    fi
  echo '▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁'▁▁▁▁▁▁▁▁▁▁▁▁▁▁
  echo ''
}
#欢迎界面
title
echo ' 欢迎来到此向导。
 该向导将帮助您部署GITS.sh到您的Termux上。
 
 更多信息请访问：
 https://kdxhub.github.io/gits'
echo
read -n 1 -p '键入[y]以继续> ' input
if [ "$input" != "y" ]; then
    if [ "$input" != "Y" ]; then
      echo
      echo
      echo ' 取消操作。
 键入命令bash -c $(curl http://kdxhub.github.io/gits/deploy/termux.sh)以重新开始向导。'
      exit 1
    fi
  fi
echo $input

#部署位置
mkdir $p
if [ -d "$p" ]; then
    pState=0
  else
    p=#默认目录获取失败
    pState=1
  fi
while true; do
  title 部署位置
  echo " 您想在哪里部署？默认在下列目录部署："
  echo "$p"
  if [ "$pState" = "1" ]; then
      echo "无效目录或者您没有权限访问。"
    fi
  echo ""
  echo "输入一个新目录"
  echo "或者直接回车以开始安装"
  read -p '> ' input
  echo
  if [ -n "$input" ]; then
      mkdir ${input}
    else
      break
    fi
  if [ "$input" = "." ]; then
      input=...........
    elif [ "$input" = ".." ]; then
      input=...........
    fi
  if [ -d "$input" ]; then
      pState=0
      p=$input
    else
      pState=1
    fi
done
echo $p

#自动应答
while true; do
#Termux不允许脚本自动应答
autoConfirm=0
break
  title 自动应答设置
  echo " 要开启自动应答吗？"
  echo " 这会自动安装/升级软件包"
  echo
  echo '* Termux不允许脚本自动应答.'
  echo
  echo "[y] 开启"
  echo "[n] 关闭"
  read -n 1 -p '> ' input
  if [ "$input" = "y" ]; then
      autoConfirm=1
      break
    elif [ "$input" = "Y" ]; then
      autoConfirm=1
      break
    elif [ "$input" = "N" ]; then
      autoConfirm=0
      break
    elif [ "$input" = "n" ]; then
      autoConfirm=0
      break
    fi
done

#最后确认
while true; do
  title 最后确认
  echo 部署GITS.sh将占用您≤1MB的磁盘空间
  echo 此外会自动安装一些软件包，预计占用100MB空间
  echo
  echo [y] 继续
  echo [n] 取消
  read -n 1 -p '> ' input
  if [ "$input" = "y" ]; then
      break
    elif [ "$input" = "Y" ]; then
      break
    elif [ "$input" = "N" ]; then
      input=n
    elif [ "$input" = "n" ]; then
      echo
      echo
      echo ' 取消操作。'
      echo ' 键入命令bash -c $(curl http://kdxhub.github.io/gits/deploy/termux.sh)以重新开始向导。'
      exit 1
    fi
done

#部署进程
title 部署进度
echo 准备部署……
echo Path=$p
echo Goal=$goal
totalSteps=9
echo 
if [ "$autoConfirm" = "1" ]; then
    echo [1/${totalSteps}]升级现有软件库
    echo ！大陆地区执行较慢请先换源
    apt update
    echo 1|apt upgrade
    echo [2/${totalSteps}]安装软件包OpenSSH
    echo 1|apt install openssh
    echo [3/${totalSteps}]安装软件包Vim
    echo 1|apt install vim
    echo [4/${totalSteps}]安装软件包Wget
    echo 1|apt install wget
    echo [5/${totalSteps}]安装软件包Git
    echo 1|apt install git
    echo [6/${totalSteps}]安装软件包Unzip
    echo 1|apt install unzip
  else
    echo [1/${totalSteps}]升级现有软件库
    echo ！大陆地区执行较慢请先换源
    apt update&&apt upgrade
    echo [2/${totalSteps}]安装软件包OpenSSH
    apt install openssh
    echo [3/${totalSteps}]安装软件包Vim
    apt install vim
    echo [4/${totalSteps}]安装软件包Wget
    apt install wget
    echo [5/${totalSteps}]安装软件包Git
    apt install git
    echo [6/${totalSteps}]安装软件包Unzip
    apt install unzip
  fi
echo [7/${totalSteps}]下载Gits.sh
cd $p
curl $goal
echo [8/${totalSteps}]安装Gits.sh
if [ -r "$(pwd)/gits.sh" ]; then
    cat "$(pwd)/gits.sh"
  else
    echo
    echo
    echo '错误(2)'
    echo kdx.gits.deploy.wget.invalidFile
    echo '#下载文件失败'
    echo 这可能是因为文件没有被正确下载或是您没有权限读取此文件。
    echo 尝试手动下载文件${goal}并放于$(pwd)后重试。
    echo 或者尝试授予Everyone读权限。
    exit 2
  fi
if [ -n "$(cat "$(pwd)/gits.sh")" ]; then
    echo unempty file.
  else
    echo
    echo
    echo '错误(3)'
    echo kdx.gits.deploy.wget.emptyFile
    echo '#下载文件为空'
    echo 这可能是因为文件没有被正确下载或是您没有权限读取此文件。
    echo 尝试手动下载文件${goal}并放于$(pwd)后重试。
    echo 或者尝试授予Everyone读权限。
    exit 3
  fi
echo 'alias gits='"bash $(pwd)"'/gits.sh ;'"$(cat ~/.bashrc)" >~/.bashrc
echo [9/${totalSteps}]即将完成……
