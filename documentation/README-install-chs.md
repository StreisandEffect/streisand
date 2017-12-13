安装
------------
在你搞事情之前，认真阅读

### 重要说明 ###
Streisand 基于 [Ansible](http://www.ansible.com/home) ，它可以在远程服务器完成自动配置、打包等工作，Streisand 是将远程服务器自动配置成为多个 VPN 服务及科学上网的工具。

Streisand 运行在**你自己的计算机上时（或者你电脑的虚拟机上时）**，它将把网关部署到你 VPS 提供商的**另一个服务器**上（通过你自己的API自动生成）。另外，如果 Streisand 运行在 VPS 上，它将会把网关部署到**另一个 VPS 上**，所以说原先你运行 Streisand 的那个 VPS 就多余了，记得部署完成并获得文档后把它删掉，而部署出来的那个 VPS 你是无法使用 SSH 连接进去的，除非你有公钥（当然这是不可能的，因为整个配置过程都没有提供公钥给你下载或者你想办法把它搞出来）。

在某些情况下，你可能需要运行 Streisand/Ansible 在 VPS 上并将其自身配置为 Streisand 服务器，这种模式适合当你无法在你自己的计算机上运行和安装 Streisand/Ansible 时，或本地与 VPS 之间的 SSH 连接不稳定时。

### 执行 ###
1. 从 Streisand 抓取源码

        git clone https://github.com/StreisandEffect/streisand.git && cd streisand
   如果 Github 被封锁了，就用我们提供的镜像。

        git clone https://area51.threeletter.agency/mirrors/streisand.git && cd streisand
2. 执行 Streisand 脚本。

        ./streisand
3. 根据实际情况从弹出的问题中填写或选择选项，比如服务器的物理位置，它的名字。还有最重要的是 API 信息（可以从问题提示中找到如何提供 API 信息）。
4. 一旦登录信息和 API key 正确无误完成，Streisand 就开始安装到另一个 VPS 上了（或者把你目前的 VPS 变成网关）。
5. 整个配置完成大概需要10分钟左右的样子，完成后，在 Streisand 目录下会生成一个 'generated-docs' 文件夹，里面储存了4个 html 文件，其中包含了网关的 SSL 证书和如何连接的详细说明。当你使用这些方法连接上网关以后，网关里详细描述了设置客户端的方法、需要额外下载的文件，客户端镜像，密钥，只要耐心配置客户端就一切搞定了。

**译者注：到这里官方英文配置就告一段落了。译者在自己配置的过程中还遇到一些小麻烦，需要各位朋友注意。**
* 从本地用 Streisand 安装到网关的模式，如果能用这种模式最好，就不要选择其他的模式了，因为这样他生成的 generated-docs 就在本地，你用浏览器打开就能直接下载到证书文件，不折腾。
* 在 VPS 上用 Streisand 安装到新的 VPS 模式还有后面介绍的将正在运行的 VPS 转变为网关这种模式，你会发现你很难在 VPS 上阅读 generated-docs 文件夹中的4个 html 文档，这个时候有几种方法可选：
  * 使用 sftp 下载文件；
  * 在目前的 VPS 上安装一个 apache2 ，然后 cp -r generated-doc /var/www/html/ ，然后从浏览器输入 VPS 的地址直接浏览并下载密钥（严格地说，这不安全，因为不是 https 连接，如果截获了数据便可以知道如何登录你科学上网的那个网关了。**如果是使用转化那个模式，就不要用这种方法了**）。
  * 在 VPS 上使用 scp 将 generated-docs 目录全部推送到你本地暴露在公网下的 Linux, Unix 或者 macOS 里，或者另一个 VPS 里也可以。命令大概是 scp -r generated-docs user@×××.×××.×××.×××:/home/user/

### 将正在使用中的 VPS 变成 Streisand 服务器 （高级使用） ###

如果你本地使用的计算机无法运行 Streisand ，你可以将正在运行的 VPS 转变为网关。只需要在 VPS 上运行 ./streisand 并在菜单中选择 "Localhost (Advanced)" 就可以了。

**但是需要注意的是**这个操作是无法挽回的，它将把你正在使用的 VPS 完全转变为网关后，之前如果你在上面搭建博客或者用于测试某些软件，那完成这个操作后，它们将不复存在。

### 在其他的 VPS 供应商上运行 （高级使用）###

你同样可以将 Streisand 运行在其他 VPS 供应商（提供更好的硬件也没问题，奇葩的 VPS 供应商也行）的 16.04 Ubuntu 上，只需要你在运行 ./streisand 的时候选择菜单中的 "Existing Server (Advanced)" 就可以。你需要提供这个 VPS 的 IP 地址。

这个 VPS 必须使用 `$HOME/id_rsa` 来储存 SSH key，并且可以使用 **root** 作为默认用户登录 VPS，如果提供商没有给你 root 用户作为默认用户登录，而是别的用户名，比如：`ubuntu` ，那么在运行 `./streisand` 之前需要额外配置 `ANSIBLE_SSH_USER` 环境变量，比如修改为：`ANSIBLE_SSH_USER=ubuntu` 。

### 非交互式部署 （高级使用）###

如果你想做非交互式部署, 你可以在 `global_vars/noninteractive`找到配置文件和脚本文件。你需要在配置文件或命令行录入必要信息。

将 Streisand 在 VPS 供应商上运行:

      deploy/streisand-new-cloud-server.sh \
        --provider digitalocean \
        --site-config global_vars/noninteractive/digitalocean-site.yml

将 Streisand 在正在使用中的服务器上运行:

      deploy/streisand-local.sh \
        --site-config global_vars/noninteractive/local-site.yml

将 Streisand 在已现有的服务器上运行 :

      deploy/streisand-existing-cloud-server.sh \
        --ip-address 10.10.10.10 \
        --ssh-user root \
        --site-config global_vars/noninteractive/digitalocean-site.yml
