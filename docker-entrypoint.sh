#!/bin/bash

# Cập nhật pip và cài đặt pip-tools (nếu cần)
python -m pip install --upgrade pip
python -m pip install pip-tools

# Biên dịch lại các file requirements
pip-compile requirements/base.in -o requirements/base.txt
pip-compile requirements/development.in -o requirements/development.txt
pip-compile requirements/translations.in -o requirements/translations.txt

# Cài đặt các package từ file requirements
pip install Pillow
pip install -r requirements/base.txt
pip install -r requirements/development.txt
pip install -r requirements/translations.txt

# Chạy migrations database (đảm bảo database đã khởi tạo)
superset db upgrade

# Tạo tài khoản admin mặc định nếu chưa có
superset fab create-admin \
    --username admin \
    --firstname Admin \
    --lastname User \
    --email admin@admin.com \
    --password admin || true

# Tải dữ liệu mẫu (tuỳ chọn)
superset load_examples

# Khởi động ứng dụng Superset
superset init
gunicorn --workers 2 --bind 0.0.0.0:8088 "superset.app:create_app()"
