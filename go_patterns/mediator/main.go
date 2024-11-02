package main

import (
        "fmt"
)

type MessageType string

const (
        START MessageType = "START"
        STOP  MessageType = "STOP"
        RESET MessageType = "RESET"
)

type Mediator struct{}

func (m *Mediator) HandleMessage(messageType MessageType, data string) {
        switch messageType {
        case START:
                m.start(data)
        case STOP:
                m.stop(data)
        case RESET:
                m.reset(data)
        default:
                fmt.Println("Неизвестная команда")
        }
}

func (m *Mediator) start(data string) {
        fmt.Printf("Команда START: %s\n", data)
}

func (m *Mediator) stop(data string) {
        fmt.Printf("Команда STOP: %s\n", data)
}

func (m *Mediator) reset(data string) {
        fmt.Printf("Команда RESET: %s\n", data)
}

func main() {
        mediator := &Mediator{}

        mediator.HandleMessage(START, "Данные для запуска")
        mediator.HandleMessage(STOP, "Данные для остановки")
        mediator.HandleMessage(RESET, "Данные для сброса")
        mediator.HandleMessage("UNKNOWN", "Неизвестная команда")
}

