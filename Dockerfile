FROM python:2.7
LABEL maintainer="Hossam Hammady <github@hammady.net>"
WORKDIR /root
COPY ./requirements.txt /root/requirements.txt
RUN pip install -r requirements.txt
COPY / /root/
CMD ./streisand

