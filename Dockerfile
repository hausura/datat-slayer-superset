FROM apache/superset:latest

# Copy script vào container với quyền thực thi
COPY --chmod=+x docker-entrypoint.sh /app/docker-entrypoint.sh

# Expose cổng 8088 cho Superset
EXPOSE 8088

# Chạy script khi container khởi động
CMD ["/app/docker-entrypoint.sh"]
