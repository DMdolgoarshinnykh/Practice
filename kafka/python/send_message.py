from kafka import KafkaProducer
import json
import time
import random

def create_producer():
    while True:
        try:
            # Создаем экземпляр KafkaProducer с сериализацией JSON сообщений
            producer = KafkaProducer(
                bootstrap_servers=['kafka:9092'], # Адрес сервера Kafka
                value_serializer=lambda v: json.dumps(v).encode('utf-8') # Сериализатор значения сообщения
            )
            return producer
        except Exception as e:
            # В случае ошибки подключения, ждем и пытаемся снова
            print(f"Failed to connect to Kafka: {e}")
            time.sleep(5) # Задержка перед следующей попыткой подключения

def send_message(producer):
    # Генерация случайного числа
    random_number = random.randint(0, 1000)
    # Создание сообщения с использованием сгенерированного числа
    message = {"message": f"Very important message {random_number}!"}
    try:
        # Отправка сообщения в указанный топик
        producer.send('my-topic', value=message)
        print("Message sent successfully")
    except Exception as e:
        # Обработка возможных исключений при отправке
        print(f"Fail: {e}")

if __name__ == "__main__":
    # Создание продюсера
    producer = create_producer()
    while True:
        # Отправка сообщений с интервалом в 10 секунд
        send_message(producer)
        time.sleep(10)
