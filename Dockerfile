# Sử dụng image Superset
FROM apache/superset:latest

# Đặt thư mục làm việc
WORKDIR /app

# Copy toàn bộ thư mục requirements vào container
COPY requirements/ ./requirements/

# Cập nhật pip và cài đặt các dependencies trực tiếp
RUN pip install --upgrade pip \
    && pip install -r requirements/base.txt \
    && pip install -r requirements/development.txt \
    && pip install -r requirements/translations.txt

# Copy script vào container với quyền thực thi
COPY --chmod=0755 docker-entrypoint.sh /app/docker-entrypoint.sh

# Expose cổng 8088 cho Superset
EXPOSE 8088

# Chạy script khi container khởi động
CMD ["/app/docker-entrypoint.sh"]
