FROM python:3.9-slim


ENV http_proxy=http://192.168.20.28:8080
ENV https_proxy=http://192.168.20.28:8080

# Установка рабочей директории
WORKDIR /app

# Копируем файл зависимостей
COPY python/requirements.txt /app/requirements.txt

# Установка зависимостей
RUN pip install --no-cache-dir -r requirements.txt

# Копируем всё приложение в контейнер
COPY ./python /app

# Указываем команду по умолчанию
CMD ["python", "send_message.py"]
