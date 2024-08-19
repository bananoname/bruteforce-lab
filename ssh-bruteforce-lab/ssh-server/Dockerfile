FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y openssh-server && \
    apt-get clean

COPY start.sh /root/start.sh
COPY xato-net-10-million-passwords-10.txt /root/xato-net-10-million-passwords-10.txt

RUN chmod +x /root/start.sh

CMD ["/root/start.sh"]
