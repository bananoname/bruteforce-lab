# Build lab ftp-server

![image](https://github.com/user-attachments/assets/62a26e5a-691d-45a6-b9fd-a084476ff4d4)

- Để cập nhật dự án của bạn nhằm khắc phục các lỗi về phiên bản Docker Compose và lỗi liên quan đến việc thay đổi mật khẩu của người dùng testuser, bạn cần thực hiện các bước sau:

**1. Cập nhật tệp docker-compose.yml**
- Đảm bảo rằng máy chủ của bạn đã cài đặt **docker-compose**. Nếu các bạn chưa các bạn có thể tham khảo cách cài đặt: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04.
- Sau khi các bạn đã cài đặt máy chủ của mình các bạn cần kiểm tra bằng cách:
![image](https://github.com/user-attachments/assets/51b3071c-168f-4b5b-a4b3-be6d374390ca)
- Các bạn tạo file **docker-compose.yml**: 
```
version: '3.9'
services:
  ftp-server:
    build: ./ftp-server
    container_name: ftp-server
    ports:
      - "21:21"
    volumes:
      - ftp-data:/var/lib/ftp
    tty: true
hydra-attacker:
    build: ./hydra-attacker
    container_name: hydra-attacker
    depends_on:
      - ftp-server
    tty: true
    entrypoint: /bin/bash
volumes:
  ftp-data:
```
![image](https://github.com/user-attachments/assets/fe5fb6d8-def7-4ef2-9c24-dece46e44494)

3. **Cập nhật script start.sh để đảm bảo việc tạo người dùng và thay đổi mật khẩu thành công**
- Tạo file **start.sh** sau đó thêm code ở dưới đây:
```
#!/bin/bash
# Tạo người dùng testuser nếu chưa tồn tại
if ! id "testuser" &>/dev/null; then
    useradd -m testuser
fi

# Chọn một mật khẩu ngẫu nhiên từ tệp xato-net-10-million-passwords-10.txt
PASSWORD=$(shuf -n 1 /root/xato-net-10-million-passwords-10.txt)

# Đặt mật khẩu cho người dùng testuser
echo "testuser:$PASSWORD" | chpasswd

# Kiểm tra xem mật khẩu đã được thay đổi thành công chưa
if [ $? -eq 0 ]; then
    echo "Mật khẩu cho user 'testuser' là: $PASSWORD"
else
    echo "Không thể thay đổi mật khẩu cho user 'testuser'."
fi

# Khởi động dịch vụ FTP
/usr/sbin/vsftpd /etc/vsftpd.conf
```
![image](https://github.com/user-attachments/assets/bee7bf80-3f12-471d-851f-82bb4ffa5d72)
**4. Cập nhật Dockerfile để cài đặt các gói cần thiết**
- Thêm các lệnh cài đặt các gói cần thiết cho **PAM và FTP** vào **Dockerfile** trong thư mục **ftp-server/**:
- Tạo file **Dockerfile**:
```
FROM ubuntu:latest
RUN apt-get update && \
    apt-get install -y vsftpd libpam-pwdfile && \
    apt-get clean
COPY vsftpd.conf /etc/vsftpd.conf
COPY start.sh /root/start.sh
COPY xato-net-10-million-passwords-10.txt /root/xato-net-10-million-passwords-10.txt
RUN chmod +x /root/start.sh
CMD ["/root/start.sh"]
```
![image](https://github.com/user-attachments/assets/42bb5c36-0c30-43f1-afc1-9538914c637e)
**5. Đảm bảo tệp xato-net-10-million-passwords-10.txt tồn tại**
- Sử dụng câu lệnh này để download file vào bên trong thư mục ftp-server/
```
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/xato-net-10-million-passwords-10.txt -O ftp-server/xato-net-10-million-passwords-10.txt

```
![image](https://github.com/user-attachments/assets/7db60436-049b-4bb9-9efa-8de8ce128453) 
**6. Xây dựng và khởi động các container**
```
docker-compose up --build -d
```
![image](https://github.com/user-attachments/assets/dec7b8dd-0296-4ae0-88ce-05c360050b10)

