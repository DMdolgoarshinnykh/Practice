package main

import (
    "fmt"
    "net"
    "log"
)

func main() {
    listener, err := net.Listen("tcp", ":5000")
    if err != nil {
        log.Fatalf("Failed to start server: %v", err)
    }
    defer listener.Close()

    fmt.Println("Server is listening on port 5000")

    for {
        conn, err := listener.Accept()
        if err != nil {
            log.Printf("Failed to accept connection: %v", err)
            continue
        }

        go handleConnection(conn)
    }
}

func handleConnection(conn net.Conn) {
    defer conn.Close()

    buffer := make([]byte, 1024)
    for {
        n, err := conn.Read(buffer)
        if err != nil {
            return
        }

        message := string(buffer[:n])
        fmt.Printf("Received message: %s\n", message)
    }
}
