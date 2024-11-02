package main

import "fmt"

type OldSystem struct{}

func (o *OldSystem) request() string {
    return "Old System: Performing a request."
}

type NewSystem interface {
    anotherRequest() string
}

type Adapter struct {
    oldSystem *OldSystem
}

func (a *Adapter) anotherRequest() string {
    return fmt.Sprintf("Adapter: (TRANSLATED) %s", a.oldSystem.request())
}

func clientCode(newSystem NewSystem) {
    fmt.Println(newSystem.anotherRequest())
}

func main() {
    oldSystem := &OldSystem{}
	adapter := &Adapter{oldSystem: oldSystem}
    clientCode(adapter)
}
