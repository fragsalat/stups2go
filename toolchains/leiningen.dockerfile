FROM registry.opensource.zalan.do/stups/openjdk:8-28

RUN curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /usr/local/bin/lein \
        && chmod +x /usr/local/bin/lein

COPY switch-user.sh /switch-user.sh
ENTRYPOINT ["/switch-user.sh"]
