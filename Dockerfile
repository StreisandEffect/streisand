FROM python:2.7.12
RUN pip install ansible markupsafe boto dopy==0.3.5 apache-libcloud>=0.17.0 linode-python pyrax
COPY . /usr/src/streisand
WORKDIR /usr/src/streisand
CMD /usr/src/streisand/streisand
