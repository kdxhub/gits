# gits TODO 列表
## 基本仓库管理及远程管理
## 一键pull
## 一键push
## 一键初始化仓库
git remote add origin git@github.com:kdxhub/gits.git
git branch -M main
git push -u origin main

echo "# gits" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:kdxhub/gits.git
git push -u origin main

## 修改安全仓库
git config --global --add safe.directory /storage/emulated/0/_kdx/repo/gits

## 修改个人信息
git config --global user.email
git config --global user.name