FROM ubuntu:16.04
MAINTAINER nop@nop.com

RUN apt-get update -q
RUN apt-get install --yes build-essential

# Python
RUN apt-get install -y python-pip && pip install --upgrade pip

# Streisand builder begins here.
RUN apt-get install -y python-pip git python-dev python-setuptools python-cffi libffi-dev libssl-dev python-nacl

# Ansible
RUN pip install ansible

# pipping
RUN pip install boto boto3 msrest msrestazure azure==2.0.0rc5 packaging dopy==0.3.5 "apache-libcloud>=1.5.0" linode-python pyrax

RUN mkdir /work
RUN mkdir /work/streisand
WORKDIR /work
ADD . .git .travis.yml /work/streisand/
WORKDIR /work/streisand

CMD ["/work/streisand/streisand"]

# ENTRYPOINT ["bash"]
# ENTRYPOINT ["sleep 86400"]
ENTRYPOINT ["ssh-agent"]
