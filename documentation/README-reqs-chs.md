### 准备工作 ###
在本地计算机完成以下所有步骤（也可以在 VPS 上运行）。

* Streisand 运行在 BSD，Linux，或者 macOS 上，Windows 上是无法运行的。所有的指令都需要在终端下运行。
* 需要 Python 2.7 ，一般在 macOS 、Linux 及 BSD 系统上都是标配，如果你使用的发行版标配是 Python 3，你需要安装 Python 2.7 来运行 Streisand。
* 确定你的 SSH key 储存在 ~/.ssh/id\_rsa.pub 。
  * 如果不曾有过 SSH key，你需要用下面的命令生成一个：

        ssh-keygen
* 安装 Git 。
  * 基于 Debian 和 Ubuntu 的 Linux 发行版

        sudo apt install git
  * 在 Fedora

        sudo dnf install git
  * 在 macOS 上 （需要通过 [Homebrew](http://brew.sh/) 进行安装）

        brew install git
* 利用 Python 安装 [pip](https://pip.pypa.io/en/latest/) 包管理
  * 基于 Debian 和 Ubuntu 的 Linux 发行版

        sudo apt install python-paramiko python-pip python-pycurl python-dev build-essential
  * 在 Fedora

        sudo dnf install python-pip
  * 在 macOS 上

        sudo easy_install pip
        sudo pip install pycurl

* 安装 [Ansible](http://www.ansible.com/home) 。
  * 在 macOS 上

        brew install ansible
  * 在 Linux 和 其他 BSD 上

        sudo pip install ansible markupsafe
* 以下使用 pip 安装的 Python 库根据你所使用的 VPS 供应商不同而不同。如果你准备将目前使用的 VPS 变成网关，可以跳过此步。
  * 亚马逊 EC2

        sudo pip install boto
  * 微软云服务

        sudo pip install ansible[azure]
  * DigitalOcean

        sudo pip install dopy==0.3.5
  * Google

        sudo pip install "apache-libcloud>=1.5.0"
  * Linode

        sudo pip install linode-python
  * Rackspace 云

        sudo pip install pyrax
  * **特别需要注意的是如果你使用 Python** 是通过 Homebrew 安装的，还需要运行以下命令来确定找到必要的库文件

        mkdir -p ~/Library/Python/2.7/lib/python/site-packages
        echo '/usr/local/lib/python2.7/site-packages' > ~/Library/Python/2.7/lib/python/site-packages/homebrew.pth

