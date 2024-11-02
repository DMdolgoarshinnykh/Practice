package main

import (
        "fmt"
        "bufio"
        "os"
        "strconv"
        "strings"
)

type Strategy interface {
        Execute(a int, b int) int
}

type ConcreteStrategyAdd struct{}

func (s *ConcreteStrategyAdd) Execute(a int, b int) int {
        return a + b
}

type ConcreteStrategySubtract struct{}

func (s *ConcreteStrategySubtract) Execute(a int, b int) int {
        return a - b
}

type ConcreteStrategyMultiply struct{}

func (s *ConcreteStrategyMultiply) Execute(a int, b int) int {
        return a * b
}

type Context struct {
        strategy Strategy
}

func (c *Context) SetStrategy(strategy Strategy) {
        c.strategy = strategy
}

func (c *Context) ExecuteStrategy(a int, b int) int {
        return c.strategy.Execute(a, b)
}

func main() {
        context := &Context{}
        reader := bufio.NewReader(os.Stdin)

        for {
                fmt.Println("\nВыберите операцию: (add/subtract/multiply/exit)")
                choice, _ := reader.ReadString('\n')
                choice = strings.TrimSpace(choice)

                if choice == "exit" {
                        fmt.Println("Выход из программы.")
                        break
                }

                fmt.Println("Введите два числа через пробел:")
                numInput, _ := reader.ReadString('\n')
                nums := strings.Fields(numInput)
                if len(nums) != 2 {
                        fmt.Println("Пожалуйста, введите два числа.")
                        continue
                }

                a, err1 := strconv.Atoi(nums[0])
                b, err2 := strconv.Atoi(nums[1])
                if err1 != nil || err2 != nil {
                        fmt.Println("Ошибка: введите корректные числа.")
                        continue
                }

                switch choice {
                case "add":
                        context.SetStrategy(&ConcreteStrategyAdd{})
                case "subtract":
                        context.SetStrategy(&ConcreteStrategySubtract{})
                case "multiply":
                        context.SetStrategy(&ConcreteStrategyMultiply{})
                default:
                        fmt.Println("Неизвестная операция.")
                        continue
                }

                result := context.ExecuteStrategy(a, b)
                fmt.Printf("Результат: %d\n", result)
        }
}
