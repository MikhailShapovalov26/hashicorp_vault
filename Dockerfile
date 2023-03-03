FROM alpine:latest
RUN mkdir /vault
RUN apk --no-cache add \
     bash \
     ca-certificates \
     wget  \
     curl
COPY vault_1.13.0_linux_amd64.zip /tmp
RUN unzip /tmp/vault_1.13.0_linux_amd64.zip -d /vault \
    && rm -f /tmp/vault_1.13.0_linux_amd64.zip \
    && chmod +x /vault


ENV PATH="PATH=$PATH:$PWD/vault"
COPY ./config/vault-config.json /vault/config/vault-config.json
EXPOSE 8200
ENTRYPOINT ["vault"]
