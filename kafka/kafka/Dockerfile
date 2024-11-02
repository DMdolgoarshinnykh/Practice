FROM bitnami/kafka:latest

# Копирование конфигурационных файлов
COPY ./zookeeper.properties /opt/bitnami/zookeeper/config/zookeeper.properties
COPY ./server.properties /opt/bitnami/kafka/config/server.properties

# Настройка переменных окружения для Kafka и ZooKeeper
ENV KAFKA_BROKER_ID=0 \
    KAFKA_ZOOKEEPER_CONNECT=localhost:2181 \
    KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092 \
    ALLOW_PLAINTEXT_LISTENER=yes \
    PATH="/opt/bitnami/zookeeper/bin:$PATH"

# Запуск ZooKeeper и Kafka при старте контейнера
CMD ["sh", "-c", "zookeeper-server-start.sh /opt/bitnami/zookeeper/config/zookeeper.properties & kafka-server-start.sh /opt/bitnami/kafka/config/server.properties"]
