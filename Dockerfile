FROM python:3.11-slim

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends graphviz libgraphviz-dev build-essential && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY . .

RUN pip install --no-cache-dir wireviz==0.4.1 wireviz-web gunicorn

ENV PORT=3005
EXPOSE 3005
CMD ["gunicorn", "-b", "0.0.0.0:3005", "wireviz_web:create_app()"]
