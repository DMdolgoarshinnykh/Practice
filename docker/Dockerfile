FROM python:3.9-slim

ENV http_proxy=http://192.168.20.28:8080
ENV https_proxy=http://192.168.20.28:8080

RUN apt-get update && apt-get install -y \
    libpq-dev \
    python3-tk \
    x11-apps \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY ./app.py .

CMD ["python", "app.py"]

