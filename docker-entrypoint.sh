#!/bin/bash

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
