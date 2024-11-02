package main

import (
        "fmt"
        "time"
        "os"
)

func main() {
        fmt.Println("Запуск программы...")

        ch1 := make(chan struct{})
        ch2 := make(chan struct{})

        go func() {
                fmt.Println("Горутина 1: Жду сигнал из ch2")
                <-ch2
                fmt.Println("Горутина 1: Получен сигнал из ch2, отправляю в ch1")
                ch1 <- struct{}{}
                fmt.Println("Горутина 1: Сигнал отправлен в ch1")
        }()

        go func() {
                fmt.Println("Горутина 2: Жду сигнал из ch1")
                <-ch1
                fmt.Println("Горутина 2: Получен сигнал из ch1, отправляю в ch2")
                ch2 <- struct{}{}
                fmt.Println("Горутина 2: Сигнал отправлен в ch2")
        }()

        timer := time.NewTimer(10 * time.Second)

        fmt.Println("Основная горутина: Ожидаю завершения горутин или срабатывания таймера")

        select {
        case <-timer.C:
                fmt.Println("Таймер сработал! Обнаружена взаимоблокировка. Завершение программы.")
                os.Exit(1)
        }

        fmt.Println("Программа завершена.")
}
