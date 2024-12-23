# Use the official Ubuntu base image
FROM ubuntu:latest

RUN apt-get update -y  && \
    apt-get install wget -y

RUN apt-get install -y apt-transport-https software-properties-common wget && \
    mkdir -p /etc/apt/keyrings/ && \
    wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | tee /etc/apt/keyrings/grafana.gpg > /dev/null

RUN echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | tee -a /etc/apt/sources.list.d/grafana.list &&\
    echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com beta main" | tee -a /etc/apt/sources.list.d/grafana.list

RUN apt-get update -y && \
    apt-get install grafana -y

# add the port number
EXPOSE 3000

CMD ["/usr/sbin/grafana-server", "--homepath=/usr/share/grafana", "--config=/etc/grafana/grafana.ini", "--packaging=docker"]
