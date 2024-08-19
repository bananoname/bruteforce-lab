FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y vsftpd && \
    apt-get clean

COPY vsftpd.conf /etc/vsftpd.conf
COPY xato-net-10-million-passwords-10.txt /root/xato-net-10-million-passwords-10.txt
COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD ["/start.sh"]

