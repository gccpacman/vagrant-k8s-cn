# k8s-vagrant

## 依赖:

1. git
2. Virtualbox 或者其他虚拟机平台(未尝试)
3. Vagrant
4. 主机拥有`bash`或者`zsh`环境, 以便执行`ansible playbook`

    - Ansible on Windows:  因为`ansible`不支持windows，但是windows 10的`wsl(Windows subsystem for Linux)`可以使用ansible，只要让`wsl`可以调用Windows的`Vagrant`即可，具体方法可以参考[Vagrant官方文档](https://www.vagrantup.com/docs/other/wsl.html)，或者我写了一篇博客:  [WSL无缝使用windows的Vagrant](https://gccpacman.github.io/wslwu-feng-shi-yong-windowsde-vagrant.html)。

## 使用方法

    $ vagrant up

在`vagrant up`成功执行后, 可以在kube-config/master14/home/vagrant/.kube/config下找到kubenetes的配置文件,放置在宿主机`$HOME`目录下的.kube/config文件夹下,就可以成功调用kubectl的命令了

   
