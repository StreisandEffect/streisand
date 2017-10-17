FROM ubuntu:16.04

RUN apt-get update -q
RUN apt-get upgrade -q -y
RUN apt-get install -q -y build-essential

# We want the latest pip.
RUN apt-get install -q -y python-pip && pip install --upgrade pip

# Ansible. The pip runs take longer than they look, so don't be quiet.
RUN pip install ansible

# Streisand dependencies begin here.

# Binary requirements
RUN apt-get install -q -y python-dev python-setuptools python-cffi libffi-dev libssl-dev python-nacl

# Finally.
RUN pip install boto boto3 msrest msrestazure azure==2.0.0rc5 packaging dopy==0.3.5 "apache-libcloud>=1.5.0" linode-python pyrax

# openssh-client `Recommends` xauth, and we don't want it, or its dependencies.
RUN apt-get install -q -y --no-install-recommends openssh-client

# git `Recommends` openssh-client, so grab git after.
RUN apt-get install -q -y git

# End Streisand dependencies.

# We should be in a git clone of Striesand.
ADD . .git .travis.yml /work/streisand/

# Inside the container, this is the initial directory.
WORKDIR /work/streisand

# Set the default command for this container.
CMD ["/work/streisand/streisand"]

# For *any* command, wrap it inside our setup wrapper.
ENTRYPOINT ["/work/streisand/util/docker-internal.sh"]
