FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y \
      git build-essential libffi-dev libssl-dev libcurl4-openssl-dev \
      python3 python3-venv python3-pip python3-openssl python3-dev python3-setuptools python-cffi && \
    git clone https://github.com/StreisandEffect/streisand.git
      

WORKDIR streisand

ENV VIRTUAL_ENV=./venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip3 install --upgrade pip setuptools wheel && \
    python3 -m venv $VIRTUAL_ENV && \
    pip3 install -r requirements.txt

CMD ["./streisand"]
