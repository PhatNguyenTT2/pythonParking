# Hướng dẫn cài đặt Python Backend

## 1. Cài đặt Python

### Windows

1. **Download Python 3.11 hoặc mới hơn:**
   - Truy cập: https://www.python.org/downloads/
   - Download phiên bản Python 3.11+ cho Windows
   - **QUAN TRỌNG:** Tick vào "Add Python to PATH" khi cài đặt

2. **Kiểm tra cài đặt:**
   ```powershell
   python --version
   # Output: Python 3.11.x
   
   pip --version
   # Output: pip 23.x.x
   ```

### macOS/Linux

```bash
# macOS (với Homebrew)
brew install python@3.11

# Ubuntu/Debian
sudo apt update
sudo apt install python3.11 python3-pip python3-venv

# Kiểm tra
python3 --version
pip3 --version
```

## 2. Tạo Virtual Environment (Khuyến nghị)

Virtual environment giúp cô lập dependencies của project, tránh xung đột với các project khác.

### Windows PowerShell

```powershell
# Di chuyển vào thư mục python
cd e:\UIT\parking\python

# Tạo virtual environment
python -m venv venv

# Kích hoạt virtual environment
.\venv\Scripts\Activate.ps1

# Nếu gặp lỗi "cannot be loaded because running scripts is disabled"
# Chạy PowerShell as Administrator và chạy:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Sau đó thử lại:
.\venv\Scripts\Activate.ps1

# Kiểm tra đã kích hoạt (sẽ thấy (venv) ở đầu dòng)
# (venv) PS E:\UIT\parking\python>
```

### macOS/Linux

```bash
# Di chuyển vào thư mục python
cd /path/to/parking/python

# Tạo virtual environment
python3 -m venv venv

# Kích hoạt virtual environment
source venv/bin/activate

# Kiểm tra đã kích hoạt (sẽ thấy (venv) ở đầu dòng)
# (venv) user@host:~/parking/python$
```

## 3. Cài đặt Dependencies

### Với Virtual Environment (Khuyến nghị)

```powershell
# Đảm bảo venv đã được kích hoạt (thấy (venv) ở đầu dòng)
# Windows
.\venv\Scripts\Activate.ps1

# macOS/Linux
source venv/bin/activate

# Cài đặt tất cả dependencies
pip install -r requirements.txt

# Kiểm tra đã cài đặt
pip list
```

### Không dùng Virtual Environment (Không khuyến nghị)

```powershell
# Windows
cd e:\UIT\parking\python
pip install -r requirements.txt

# macOS/Linux
cd /path/to/parking/python
pip3 install -r requirements.txt
```

## 4. Cấu hình Environment Variables

```powershell
# Copy file .env.example thành .env
cp .env.example .env

# Hoặc trên Windows
copy .env.example .env

# Mở file .env và điền thông tin
# Notepad
notepad .env

# VS Code
code .env
```

**Nội dung file `.env`:**

```env
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/parking?retryWrites=true&w=majority
PORT=3001
NODE_ENV=development
```

Thay `username`, `password`, `cluster` bằng thông tin MongoDB Atlas của bạn.

## 5. Chạy Backend

### Với Virtual Environment

```powershell
# Kích hoạt venv nếu chưa
.\venv\Scripts\Activate.ps1  # Windows
source venv/bin/activate      # macOS/Linux

# Chạy server
python main.py

# Hoặc với uvicorn (recommended for production)
uvicorn main:app --reload --host 0.0.0.0 --port 3001
```

### Không dùng Virtual Environment

```powershell
# Windows
cd e:\UIT\parking\python
python main.py

# macOS/Linux
cd /path/to/parking/python
python3 main.py
```

**Server sẽ chạy tại:**
- API: http://localhost:3001
- Swagger Docs: http://localhost:3001/docs
- ReDoc: http://localhost:3001/redoc

## 6. Tắt Virtual Environment

```powershell
# Khi muốn tắt venv
deactivate
```

## 7. Troubleshooting

### Lỗi: "python is not recognized"

**Nguyên nhân:** Python chưa được thêm vào PATH

**Giải pháp:**
1. Gỡ cài đặt Python
2. Cài lại và **TICK VÀO "Add Python to PATH"**
3. Hoặc thêm thủ công:
   - Tìm đường dẫn cài đặt Python (VD: `C:\Users\YourName\AppData\Local\Programs\Python\Python311`)
   - Thêm vào Environment Variables > System Variables > Path

### Lỗi: "pip is not recognized"

```powershell
# Cài pip thủ công
python -m ensurepip --upgrade

# Hoặc
python -m pip install --upgrade pip
```

### Lỗi: "cannot be loaded because running scripts is disabled"

```powershell
# Chạy PowerShell as Administrator
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Hoặc chỉ cho session hiện tại
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```

### Lỗi: "No module named 'fastapi'"

```powershell
# Đảm bảo venv đã kích hoạt
.\venv\Scripts\Activate.ps1

# Cài lại dependencies
pip install -r requirements.txt
```

### Lỗi kết nối MongoDB

**Kiểm tra:**
1. MONGODB_URI trong `.env` đúng format
2. IP của máy đã được whitelist trên MongoDB Atlas (Network Access)
3. Username/Password đúng
4. Database name đúng

## 8. Commands Tóm tắt

### Setup lần đầu (Windows)

```powershell
# 1. Di chuyển vào thư mục
cd e:\UIT\parking\python

# 2. Tạo virtual environment
python -m venv venv

# 3. Kích hoạt venv
.\venv\Scripts\Activate.ps1

# 4. Cài dependencies
pip install -r requirements.txt

# 5. Tạo .env
copy .env.example .env

# 6. Chỉnh sửa .env (thêm MONGODB_URI)
notepad .env

# 7. Chạy server
python main.py
```

### Chạy hàng ngày (Windows)

```powershell
# 1. Di chuyển vào thư mục
cd e:\UIT\parking\python

# 2. Kích hoạt venv
.\venv\Scripts\Activate.ps1

# 3. Chạy server
python main.py
```

### Cập nhật dependencies

```powershell
# Kích hoạt venv
.\venv\Scripts\Activate.ps1

# Cập nhật pip
python -m pip install --upgrade pip

# Cài lại dependencies
pip install -r requirements.txt --upgrade
```

## 9. Cấu trúc thư mục sau khi setup

```
python/
├── venv/                    # Virtual environment (không commit lên git)
│   ├── Scripts/             # Windows
│   ├── bin/                 # macOS/Linux
│   └── ...
├── __pycache__/            # Python cache (không commit lên git)
├── .env                     # Environment variables (không commit lên git)
├── .env.example            # Template cho .env
├── .gitignore              # Ignore venv, __pycache__, .env
├── main.py                 # Entry point
├── app.py                  # FastAPI app
├── requirements.txt        # Dependencies
├── controllers/
├── models/
└── utils/
```

## 10. Best Practices

✅ **LUÔN dùng Virtual Environment**
- Tránh xung đột dependencies
- Dễ quản lý phiên bản packages
- Clean uninstall (chỉ cần xóa thư mục venv)

✅ **KHÔNG commit venv, __pycache__, .env lên git**
- Đã có trong `.gitignore`
- Mỗi người tự tạo venv riêng

✅ **Cập nhật requirements.txt khi thêm package mới**
```powershell
# Sau khi pip install package-mới
pip freeze > requirements.txt
```

✅ **Sử dụng .env cho sensitive data**
- MONGODB_URI, API keys, secrets
- KHÔNG hard-code trong code

## 11. VS Code Integration

### Chọn Python Interpreter

1. `Ctrl + Shift + P`
2. Gõ: "Python: Select Interpreter"
3. Chọn: `.\venv\Scripts\python.exe` (Windows) hoặc `./venv/bin/python` (macOS/Linux)

### Extensions khuyến nghị

- Python (Microsoft)
- Pylance (Microsoft)
- Python Debugger (Microsoft)
- autoDocstring (Nils Werner)

### Launch configuration (.vscode/launch.json)

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Python: FastAPI",
      "type": "debugpy",
      "request": "launch",
      "module": "uvicorn",
      "args": [
        "main:app",
        "--reload",
        "--host",
        "0.0.0.0",
        "--port",
        "3001"
      ],
      "jinja": true,
      "envFile": "${workspaceFolder}/python/.env"
    }
  ]
}
```

## 12. Liên hệ

Nếu gặp vấn đề, hãy kiểm tra:
1. Python version: `python --version` (cần >= 3.11)
2. Pip version: `pip --version`
3. Virtual environment đã kích hoạt chưa: `(venv)` ở đầu dòng
4. Dependencies đã cài: `pip list`
5. `.env` file tồn tại và có đúng config
