# gits.sh
这是一个开源**脚本**，立志让git命令使用更加简单。<br>
其终极愿景是复刻VSCode那样的Git操作过程。

# 下载
此脚本目前只有[Linux](#Linux平台)/[Android](#Android平台)平台。

* [Linux .sh](./gits.sh)
* [Windows .bat](./gits.bat)

# 部署
## Android平台（未做好）
您需要[`termux`](//termux.dev)或类似终端模拟器来模拟Linux命令环境。<br>
> ！请勿使用MT管理器内置的终端模拟器，此模拟器不包括某些必备命令

> ✓ 对于中国大陆用户，执行下列命令以换源来提高部署速度。
```sh
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/apt/termux-main stable main@' $PREFIX/etc/apt/sources.list
apt update && apt upgrade
```

在Termux中执行下列命令来部署`gits`。<br>
> ！您不用为此提前安装包括`git`在内的任何前置包体，这是全自动的
```sh
sh $(curl https://kdxhub.github.io/gits/deloy/termux.sh)
```

## Linux平台
请提前安装下列包体：
* Git `apt install git`
* SSH `apt install openssh`
* Vim `apt install Vim`

您可以使用[Termux脚本（不推荐）](#Android平台)或是执行下列命令。

```sh
#前往一个您喜欢的目录并执行下列命令
curl https://kdxhub.github.io/gits/gits.sh
alias 'gits'="sh $(pwd)/gits.sh"
```


# LICENSE
本仓库使用开源协议[Affero General Public License 3.0 (AGPL 3.0)](./LICENSE)