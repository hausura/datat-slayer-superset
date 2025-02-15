<<<<<<< HEAD
FROM apache/superset:latest

# Copy file config (nếu có)
COPY superset_config.py /app/superset_config.py

# Copy script khởi tạo admin
COPY docker-entrypoint.sh /app/docker-entrypoint.sh

# Cấp quyền thực thi cho script ngay khi build
RUN chmod +x /app/docker-entrypoint.sh

# Expose cổng Superset (8088)
EXPOSE 8088

# Chạy script khi container khởi động
CMD ["/app/docker-entrypoint.sh"]
=======
FROM apache/superset

EXPOSE 8088
CMD ["gunicorn", "-b", "0.0.0.0:8088", "superset.app:create_app()"]
>>>>>>> 55706147b9d74acfc128e3edb7751bbb00e5e009
