FROM registry.opensource.zalan.do/stups/ubuntu:16.04-41

RUN apt-get update && apt-get install -y git make

RUN curl https://storage.googleapis.com/golang/go1.7.linux-amd64.tar.gz -o /tmp/go1.7.linux-amd64.tar.gz && \
    echo '702ad90f705365227e902b42d91dd1a40e48ca7f67a2f4b2fd052aaa4295cd95 /tmp/go1.7.linux-amd64.tar.gz' > /tmp/go1.7.linux-amd64.tar.gz.sha256sum && \
    sha256sum --check /tmp/go1.7.linux-amd64.tar.gz.sha256sum && \
    tar -C /usr/local -xzf /tmp/go1.7.linux-amd64.tar.gz && \
    rm /tmp/go1.7.linux-amd64.tar.gz


# keep our environment even after doing "su"
ENV PATH /usr/local/go/bin:$PATH
RUN echo "ENV_PATH PATH=$PATH" >> /etc/login.defs

COPY switch-user.sh /switch-user.sh
ENTRYPOINT ["/switch-user.sh"]
