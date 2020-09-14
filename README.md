# vagrant-k8s-cn

## 特性

- 使用`Vagrantfile`定义的虚拟机基础配置和`provision`脚本，一键启动一个多节点的Kubernetes
    - `vagrant up`一键启动
        - `Kube Config`文件会复制相对路径`kubernetes-setup/kube-config`目录下，可以自行复制或合并到`$HOME/.kube/config`，或者在执行`kubectl`命令时用`--kube-config .kube\config`指定该配置文件操作k8s集群
    - 可以通过`vagrant ssh {机器名}`随时登陆`master`和`node`节点
    - 可以通过`vagrant destroy`一键销毁
- 使用`ansible playbook`定义了所有`provision`脚本操作
    - 随时可以更改脚本，可以使用`vagrant provision {机器名} --provision-with {参数}`随时重新执行`provision`操作，支持的参数
        - basic: 安装基础依赖
        - docker: 安装docker环境
        - kubernetes: 安装kubernetes环境
        - kubernetes-master: 执行k8s的master节点的ansible-playbook
        - kubernetes-node: 执行k8s的worker节点的ansible-playbook
    - 替换了阿里源，安装ubuntu依赖包，Docker, kubernetes等
    - Master获得`JoinCommand.sh`命令并复制宿主机，Node节点启动时将`JoinCommand.sh`复制到Node节点虚拟机，将加入K8s集群

- 可以随时使用`ansible`操作所有节点（额外配置`/etc/ansible/hosts`即可，具体参考ansible文档）

## 默认provision的机器类型和功能

master: k8s的master节点，ip最后一位100
node-{n}: k8s的worker节点，可以在Vagrantfile里改变`N`的值，ip最后一位100开头
bnode-{bn}: 普通节点，可以在Vagrantfile里改变`BN`的值，安装docker环境，和k8s无关但在同一个网络，ip最后一位10开头

## 当前版本

- 操作系统镜像：ubuntu-18.04
- K8S版本：v1.18.6

## 本地环境依赖:

1. git
2. Virtualbox
3. Vagrant
4. 主机拥有`bash`或者`zsh`环境, 以便执行`ansible playbook`

PS: 因为`ansible`不支持windows，但是windows 10的`wsl(Windows subsystem for Linux)`可以使用ansible，只要让`wsl`可以调用Windows的`Vagrant`即可，具体方法可以参考[Vagrant官方文档](https://www.vagrantup.com/docs/other/wsl.html)，或者我的一篇博客也有相关说明:  [WSL无缝使用windows的Vagrant](https://gccpacman.github.io/wslwu-feng-shi-yong-windowsde-vagrant.html)。

   
