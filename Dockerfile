FROM apache/superset

EXPOSE 8088
CMD ["gunicorn", "-b", "0.0.0.0:8088", "superset.app:create_app()"]
