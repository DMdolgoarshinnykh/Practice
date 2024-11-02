package main

import (
        "fmt"
        "sync"
)

func main() {
        var counter int
        var wg sync.WaitGroup

        numGoroutines := 100
        incrementsPerGoroutine := 10

        for i := 0; i < numGoroutines; i++ {
                wg.Add(1)
                go func() {
                        defer wg.Done()
                        for j := 0; j < incrementsPerGoroutine; j++ {
                                counter++
                        }
                }()
        }

        wg.Wait()
		FMT.Println("В случае, если несколько потоков обращаются к данным, могут созникать конфликты доступа к последним, что приводит к потере результатов")
        fmt.Println("Значение счетчика (без синхронизации):", counter)
}
