### Необходимые условия ###
Выполните все указанные ниже шаги на вашем домашнем компьютере.

* Стрейзанд требует BSD, Linux или macOS. На текущий момент Windows не поддерживается. Все указанные ниже команды должны выполняться в терминале.
* Требуется наличие Python 2.7. Он присутствует в стандартной поставке macOS и практически во всех Linux и BSD дистрибутивах. Если в вашем дистрибутиве установлен Python 3, вам потребуется также установить Python 2.7 , чтобы  Стрейзанд работал нормально.
* Убедитесь, что SSH ключ присутствует в файле ~/.ssh/id\_rsa.pub.
  * Если у вас нет SSH ключа, вы можете его сгенерировать с использование следующей команды и выбирая значения по умолчанию:

        ssh-keygen
* Установите Git.
  * На Debian и Ubuntu

        sudo apt-get install git
  * На Fedora

        sudo yum install git
  * На macOS (с использованием [Homebrew](http://brew.sh/))

        brew install git
* Установите  [pip](https://pip.pypa.io/en/latest/) - систему управления пакетами для Python.
  * На Debian и Ubuntu (также устанавливает зависимости. необходимые для сборки Ansible и работы некоторых других модулей)

        sudo apt-get install python-paramiko python-pip python-pycurl python-dev build-essential
  * На Fedora

        sudo yum install python-pip
  * На macOS

        sudo easy_install pip
        sudo pip install pycurl

* Установите [Ansible](http://www.ansible.com/home).
  * На macOS (с использованием [Homebrew](http://brew.sh/))

        brew install ansible
  * На BSD или Linux (с использованием pip)

        sudo pip install ansible markupsafe
* Установите необходимые библиотеки Python для вашего облачного хостера. Если вы настраиваете локальный или существующий сервер, вы можете пропустить этот шаг.
  * Amazon EC2

        sudo pip install boto
  * Azure

        sudo pip install ansible[azure]
  * DigitalOcean

        sudo pip install dopy==0.3.5
  * Google

        sudo pip install "apache-libcloud>=1.5.0"

  * Linode

        sudo pip install linode-python
  * Rackspace Cloud

        sudo pip install pyrax
  * **Важное замечание: если вы используете Python , установленный через  Homebrew** то вы должны также выполнить следующие команды чтобы быть уверенным, что Python сможет найти необходимые библиотеки:

        mkdir -p ~/Library/Python/2.7/lib/python/site-packages
        echo '/usr/local/lib/python2.7/site-packages' > ~/Library/Python/2.7/lib/python/site-packages/homebrew.pth

