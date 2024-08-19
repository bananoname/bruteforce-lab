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

