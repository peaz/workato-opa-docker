FROM ubuntu:20.04

RUN apt update && apt -y install curl python

RUN mkdir -p /opt/workato
RUN mkdir -p /var/opa/files

COPY dl-latest-opa.sh /home
RUN chmod +x /home/dl-latest-opa.sh


RUN /home/dl-latest-opa.sh
ENTRYPOINT [ "/opt/workato/workato-agent/bin/run.sh" ]