FROM registry.opensource.zalan.do/stups/node:6.4-42

# general tools
RUN apt-get update && apt-get install -y git

COPY switch-user.sh /switch-user.sh
ENTRYPOINT ["/switch-user.sh"]
