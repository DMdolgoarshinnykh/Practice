package main

import (
        "container/list"
        "fmt"
)

type visited struct {
        x int
        y int
}

func isSelfCrossing(distance []int) bool {
        x := 0
        y := 0
        lst := list.New()

        for i := 0; i < len(distance); i++ {
                switch i % 4 {
                case 0:
                        for distance[i] > 0 {
                                y++
                                distance[i]--
                                Node := &visited{x: x, y: y}
                                lst.PushBack(Node)
                                for e := lst.Front(); e != nil; e = e.Next() {
                                        visitedNode := e.Value.(*visited)
                                        if visitedNode.x == x && visitedNode.y == y && e != lst.Back() {
                                                return true
                                        }
                                }
                        }
                case 1:
                        for distance[i] > 0 {
                                x--
                                distance[i]--
                                Node := &visited{x: x, y: y}
                                lst.PushBack(Node)
                                for e := lst.Front(); e != nil; e = e.Next() {
                                        visitedNode := e.Value.(*visited)
                                        if visitedNode.x == x && visitedNode.y == y && e != lst.Back() {
                                                return true
                                        }
                                }
                        }
                case 2:
                        for distance[i] > 0 {
                                y--
                                distance[i]--
                                Node := &visited{x: x, y: y}
                                lst.PushBack(Node)
                                for e := lst.Front(); e != nil; e = e.Next() {
                                        visitedNode := e.Value.(*visited)
                                        if visitedNode.x == x && visitedNode.y == y && e != lst.Back() {
                                                return true
                                        }
                                }
                        }
                case 0:
                        for distance[i] > 0 {
                                x++
                                distance[i]--
                                Node := &visited{x: x, y: y}
                                lst.PushBack(Node)
                                for e := lst.Front(); e != nil; e = e.Next() {
                                        visitedNode := e.Value.(*visited)
                                        if visitedNode.x == x && visitedNode.y == y && e != lst.Back() {
                                                return true
                                        }
                                }
                        }
                }
        }

        fmt.Printf("Конечная позиция: x=%d, y=%d\n", x, y)
        return false
}

func main() {
        distances := []int{2, 1, 1, 2}
        crosses := isSelfCrossing(distances)
        fmt.Println("Самопересечение:", crosses)
}
