# Hướng dẫn thực hiện bài lab.
1. Sử dụng câu lệnh để login vào container Kali.
- Ở bước này các bạn sử dụng câu lệnh dưới đây để login vào bên trong container:
```
 docker exec -it ff350fae646e /bin/bash
```
![image](https://github.com/user-attachments/assets/2ca00f6a-6e16-4294-802b-2943a7c8ab43)
2. Kiểm tra từ điển dò mật khẩu: 
- Bước này các bạn kiểm tra từ điển mà các bạn cài đặt chưa?
- Nếu chưa các bạn xem chi tiết tại đây hướng dẫn cách cài đặt: https://github.com/danielmiessler/SecLists
- Sau khi cài đặt ở nội dung trên. Thực hiện câu lệnh này đảm bảo rằng câu lệnh đã được cài đặt:
```
seclists
```
![image](https://github.com/user-attachments/assets/f8be5ce0-722a-4379-8904-059502bed809)


3. Thực hành bài lab

```hydra -l testuser -P /usr/share/wordlists/rockyou.txt ftp://ftp-server```

![image](https://github.com/user-attachments/assets/2477b605-af54-4706-b3fa-e0f50e12413b)
