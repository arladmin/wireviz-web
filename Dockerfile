FROM python:3.11-slim

# 5 MB of headers so pygraphviz builds instantly
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
        graphviz libgraphviz-dev build-essential && \
    rm -rf /var/lib/apt/lists/*

# single pip line = clearer logs
RUN pip install --no-cache-dir wireviz==0.4.1 wireviz-web gunicorn

WORKDIR /app
EXPOSE 8000
CMD ["gunicorn", "-b", "0.0.0.0:8000", "wireviz_web:create_app()"]
