# Sử dụng image Superset
FROM apache/superset:latest

# Đặt quyền root để cài đặt dependencies
USER root

# Đặt thư mục làm việc
WORKDIR /app

# Đảm bảo quyền ghi trên thư mục làm việc
RUN chown -R superset:superset /app
RUN chmod -R 775 /app

# Copy toàn bộ thư mục requirements vào container
COPY requirements/ ./requirements/

# Cập nhật pip và cài đặt pip-tools để xử lý các file *.in
RUN pip install --upgrade pip \
    && pip install pip-tools

# Thêm thư mục chứa pip-compile vào PATH
ENV PATH=$PATH:/root/.local/bin

# Biên dịch các file *.in thành *.txt
RUN pip-compile requirements/base.in -o requirements/base.txt \
    && pip-compile requirements/development.in -o requirements/development.txt \
    && pip-compile requirements/translations.in -o requirements/translations.txt

# Cài đặt tất cả các package từ các file *.txt
RUN pip install -r requirements/base.txt \
    && pip install -r requirements/development.txt \
    && pip install -r requirements/translations.txt

# Trả về user mặc định của Superset sau khi cài đặt xong
USER superset

# Copy script vào container với quyền thực thi
COPY --chmod=0755 docker-entrypoint.sh /app/docker-entrypoint.sh

# Expose cổng 8088 cho Superset
EXPOSE 8088

# Chạy script khi container khởi động
CMD ["/app/docker-entrypoint.sh"]
