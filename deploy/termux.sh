#!/bin/bash

function title() {
 echo ''
 echo '      GITS.SH on Termux'
 echo '      ❖  部署向导'
 echo '▁▁▁▁▁▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▁▁▁▁▁'
}

#欢迎界面
title
echo ' 欢迎来到此向导。
 该向导将帮助您部署GITS.sh到您的Termux上。
 
 更多信息请访问：
 https://kdxhub.github.io/gits
 
 键入[y]以继续。'
read input
if [ "$input" != "y" ]; then
  exit 0
fi

#部署位置
title
