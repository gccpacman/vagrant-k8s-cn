# vagrant-k8s-cn

## 特性

- 使用`Vagrantfile`定义的虚拟机基础配置和`provision`脚本，一键启动一个多节点的Kubernetes
    - 可以通过`vagrant ssh master/node{n}`随时登陆`master`和`node`节点
    - 可以通过`vagrant destroy`一键销毁
- 使用`ansible playbook`定义了所有`provision`脚本操作
    - 随时可以更改脚本，可以使用`vagrant provision master/node{n}`随时重新执行`provision`操作
    - 替换了阿里源，安装ubuntu依赖包，Docker, kubernetes等
    - Master获得`JoinCommand.sh`命令并复制宿主机，Node节点启动时将`JoinCommand.sh`复制到Node节点虚拟机，将加入K8s集群
    - 获得Kube config文件到宿主机
- 可以随时使用`ansible`操作所有节点（额外配置`/etc/ansible/hosts`即可，不在此说明）

## 当前版本

- 操作系统镜像：ubuntu-18.04
- K8S版本：v1.18.6

## 依赖:

1. git
2. Virtualbox
3. Vagrant
4. 主机拥有`bash`或者`zsh`环境, 以便执行`ansible playbook`


PS: 因为`ansible`不支持windows，但是windows 10的`wsl(Windows subsystem for Linux)`可以使用ansible，只要让`wsl`可以调用Windows的`Vagrant`即可，具体方法可以参考[Vagrant官方文档](https://www.vagrantup.com/docs/other/wsl.html)，或者我的一篇博客也有相关说明:  [WSL无缝使用windows的Vagrant](https://gccpacman.github.io/wslwu-feng-shi-yong-windowsde-vagrant.html)。

## 使用方法

    $ vagrant up

在`vagrant up`成功执行后, 可以在kube-config/master/home/vagrant/.kube/config下找到kubenetes的配置文件,放置或者合并在宿主机`$HOME`目录下的.kube/config文件夹下,就可以成功调用kubectl的命令了

## 增加节点

更改`Vagrantfile`里的`N`的值，重新执行命令: 

    $ vagrant up

## 遇到报错的情况

检查脚本，如果是因为网络等原因，执行以下命令重跑`provision`：

    $ vagrant up --provision
    
还是不行，执行`vagrant destroy`重来一遍
   
