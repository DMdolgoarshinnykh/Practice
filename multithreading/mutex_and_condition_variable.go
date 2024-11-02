package main

import (
        "fmt"
        "sync"
        "time"
)

type SharedCounter struct {
        mu      sync.Mutex
        cond    *sync.Cond
        counter int
}

func NewSharedCounter() *SharedCounter {
        sc := &SharedCounter{}
        sc.cond = sync.NewCond(&sc.mu)
        return sc
}

func (sc *SharedCounter) WaitFor(target int) {
        sc.mu.Lock()
        defer sc.mu.Unlock()
        for sc.counter < target {
                fmt.Printf("Ожидание: счётчик = %d, требуется = %d\n", sc.counter, target)
                sc.cond.Wait()
        }
        fmt.Printf("Условие выполнено: счётчик достиг %d\n", target)
}

func (sc *SharedCounter) Increment(target int) {
        sc.mu.Lock()
        defer sc.mu.Unlock()
        sc.counter++
        fmt.Printf("Увеличение счётчика: теперь = %d\n", sc.counter)
        if sc.counter >= target {
                fmt.Printf("Уведомление: счётчик достиг %d\n", sc.counter)
                sc.cond.Signal()
        }
}

func main() {
        sc := NewSharedCounter()
        var wg sync.WaitGroup
        target := 5

        wg.Add(2)

        go func() {
                defer wg.Done()
                sc.WaitFor(target)
        }()

        go func() {
                defer wg.Done()
                for i := 0; i < target; i++ {
                        time.Sleep(1 * time.Second)
                        sc.Increment(target)
                }
        }()

        wg.Wait()
        fmt.Println("Программа завершена.")
}
