package main

import (
    "fmt"
    "log"
    "os"
    "os/signal"
    "syscall"
    "time"

    "github.com/IBM/sarama"
)

func connectWithRetry(brokers []string, config *sarama.Config) (sarama.Consumer, error) {
    var consumer sarama.Consumer
    var err error
    for i := 0; i < 5; i++ {
        log.Printf("Attempting to connect to Kafka brokers: %v (attempt %d/5)", brokers, i+1)
        consumer, err = sarama.NewConsumer(brokers, config)
        if err == nil {
            log.Println("Successfully connected to Kafka")
            return consumer, nil
        }
        log.Printf("Failed to connect to Kafka: %v", err)
        log.Println("Retrying in 5 seconds...")
        time.Sleep(5 * time.Second)
    }
    return nil, fmt.Errorf("failed to connect to Kafka after 5 attempts: %v", err)
}

func createPartitionConsumerWithRetry(consumer sarama.Consumer, topic string, partition int32, offset int64) (sarama.PartitionConsumer, error) {
    var partitionConsumer sarama.PartitionConsumer
    var err error
    for i := 0; i < 5; i++ {
        log.Printf("Attempting to create partition consumer for topic %s, partition %d (attempt %d/5)", topic, partition, i+1)
        partitionConsumer, err = consumer.ConsumePartition(topic, partition, offset)
        if err == nil {
            log.Println("Successfully created partition consumer")
            return partitionConsumer, nil
        }
        log.Printf("Failed to create partition consumer: %v", err)
        log.Println("Retrying in 5 seconds...")
        time.Sleep(5 * time.Second)
    }
    return nil, fmt.Errorf("failed to create partition consumer after 5 attempts: %v", err)
}

func main() {
    log.Println("Starting Kafka consumer")
    config := sarama.NewConfig()
    config.Consumer.Return.Errors = true
    config.Consumer.Offsets.Initial = sarama.OffsetOldest

    brokers := []string{os.Getenv("KAFKA_BOOTSTRAP_SERVERS")}
    log.Printf("Kafka brokers: %v", brokers)

    consumer, err := connectWithRetry(brokers, config)
    if err != nil {
        log.Fatalf("Error creating consumer: %v", err)
    }
    defer func() {
        log.Println("Closing consumer")
        if err := consumer.Close(); err != nil {
            log.Printf("Failed to close consumer: %v", err)
        }
    }()

    topic := os.Getenv("TOPIC_NAME")
    log.Printf("Topic name: %s", topic)

    partitionConsumer, err := createPartitionConsumerWithRetry(consumer, topic, 0, sarama.OffsetNewest)
    if err != nil {
        log.Fatalf("Error creating partition consumer: %v", err)
    }
    defer func() {
        log.Println("Closing partition consumer")
        if err := partitionConsumer.Close(); err != nil {
            log.Printf("Failed to close partition consumer: %v", err)
        }
    }()

    signals := make(chan os.Signal, 1)
    signal.Notify(signals, syscall.SIGINT, syscall.SIGTERM)

    consumed := 0

    log.Println("Starting to consume messages")
    ConsumerLoop:
    for {
        select {
        case msg := <-partitionConsumer.Messages():
            consumed++
            log.Printf("Message received: topic=%s, partition=%d, offset=%d, key=%s, value=%s\n",
                msg.Topic, msg.Partition, msg.Offset, string(msg.Key), string(msg.Value))
            
        case err := <-partitionConsumer.Errors():
            log.Printf("Error: %v", err)

        case <-signals:
            log.Println("Interrupt is detected")
            break ConsumerLoop
        }
    }

    log.Printf("Consumed: %d\n", consumed)
    log.Println("Consumer stopped")
}
