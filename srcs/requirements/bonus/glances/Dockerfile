FROM debian:bullseye

RUN apt-get update -y && apt-get install -y procps python3 pip

RUN pip install glances[web]
RUN pip install glances[containers]

COPY ./conf /etc/glances

EXPOSE 61208 61209

CMD ["glances", "-w"]
# CMD ["glances", "-C", "/etc/glances/glances.conf", "-w"]


#https://glances.readthedocs.io/en/latest/