## 当前版本

操作系统镜像：ubuntu-18.04
K8S版本：v1.18.6

## 依赖:

1. git
2. Virtualbox
3. Vagrant
4. 主机拥有`bash`或者`zsh`环境, 以便执行`ansible playbook`

>>>
    - Windows:  因为`ansible`不支持windows，但是windows 10的`wsl(Windows subsystem for Linux)`可以使用ansible，只要让`wsl`可以调用Windows的`Vagrant`即可，具体方法可以参考[Vagrant官方文档](https://www.vagrantup.com/docs/other/wsl.html)，或者我的一篇博客也有相关说明:  [WSL无缝使用windows的Vagrant](https://gccpacman.github.io/wslwu-feng-shi-yong-windowsde-vagrant.html)。

## 使用方法

    $ vagrant up

在`vagrant up`成功执行后, 可以在kube-config/master/home/vagrant/.kube/config下找到kubenetes的配置文件,放置或者合并在宿主机`$HOME`目录下的.kube/config文件夹下,就可以成功调用kubectl的命令了

## 增加节点

更改`Vagrantfile`里的N的值，重新执行命令: 

    $ vagrant up

## 遇到报错的情况

检查脚本，如果是因为网络等原因，执行：

    $ vagrant up --provision
   
