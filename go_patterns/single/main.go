package main

import "fmt"

type Singleton struct{}

var instance *Singleton

func init() {
    instance = &Singleton{}
}

func GetInstance() *Singleton {
    return instance
}

func main() {
    s1 := GetInstance()
    s2 := GetInstance()
    fmt.Println(s1 == s2)
}
