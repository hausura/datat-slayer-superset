# Sử dụng image Superset
FROM apache/superset:latest

# Đặt thư mục làm việc
WORKDIR /app

# Copy toàn bộ thư mục requirements vào container
COPY requirements/ ./requirements/

# Cập nhật pip và cài đặt pip-tools để xử lý các file *.in
RUN pip install --upgrade pip \
    && pip install pip-tools

# Kiểm tra vị trí của pip-compile để đảm bảo nó đã được cài
RUN which pip-compile

# Sử dụng đường dẫn tuyệt đối để gọi pip-compile
RUN /usr/local/bin/pip-compile requirements/base.in -o requirements/base.txt \
    && /usr/local/bin/pip-compile requirements/development.in -o requirements/development.txt \
    && /usr/local/bin/pip-compile requirements/translations.in -o requirements/translations.txt

# Cài đặt tất cả các package từ các file *.txt
RUN pip install -r requirements/base.txt \
    && pip install -r requirements/development.txt \
    && pip install -r requirements/translations.txt

# Copy script vào container với quyền thực thi
COPY --chmod=0755 docker-entrypoint.sh /app/docker-entrypoint.sh

# Expose cổng 8088 cho Superset
EXPOSE 8088

# Chạy script khi container khởi động
CMD ["/app/docker-entrypoint.sh"]
