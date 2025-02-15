FROM apache/superset:latest


# Copy script khởi tạo admin
COPY docker-entrypoint.sh /app/docker-entrypoint.sh

# Cấp quyền thực thi cho script ngay khi build
RUN chmod +x /app/docker-entrypoint.sh

# Expose cổng Superset (8088)
EXPOSE 8088

# Chạy script khi container khởi động
CMD ["/app/docker-entrypoint.sh"]