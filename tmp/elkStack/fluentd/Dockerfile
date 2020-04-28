FROM fluent/fluentd:v1.7-1
WORKDIR /fluentd_server
USER root
COPY nelogica_config_server.conf nelogica_config_server.conf
RUN mkdir /fluentd_server/buffer
RUN mkdir /fluentd_server/logs

# Any faraday version >= 1 will generate a Faraday::Error::ConnectionFailed due to an impatibility with fluent-plugin-elasticsearch
RUN gem install faraday --version 0.17.1
RUN gem install fluent-plugin-elasticsearch --version 4.0.3

CMD ["fluentd", "-c", "nelogica_config_server.conf", "-o", "/fluentd_server/logs/fluentd.log"]



# Running without docker-compose: docker run -p 24224:24224 -p 24224:24224/udp -v C:/Fontes/hades/bin/log:/fluentd/log server_image
