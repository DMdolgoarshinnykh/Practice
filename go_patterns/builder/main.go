package main

import "fmt"

type Person struct {
        FirstName string
        LastName  string
        Age      int
        Address  string
}

type PersonBuilder struct {
        person Person
}

func NewPersonBuilder() *PersonBuilder {
        return &PersonBuilder{person: Person{}}
}

func (b *PersonBuilder) SetFirstName(firstName string) *PersonBuilder {
        b.person.FirstName = firstName
        return b
}

func (b *PersonBuilder) SetLastName(lastName string) *PersonBuilder {
        b.person.LastName = lastName
        return b
}

func (b *PersonBuilder) SetAge(age int) *PersonBuilder {
        b.person.Age = age
        return b
}

func (b *PersonBuilder) SetAddress(address string) *PersonBuilder {
        b.person.Address = address
        return b
}

func (b *PersonBuilder) Build() Person {
        return b.person
}

func main() {
        person := NewPersonBuilder().
                SetFirstName("Иван").
                SetLastName("Иванов").
                SetAge(30).
                SetAddress("Москва, ул. Пушкина, д. Колотушкина").
                Build()

        fmt.Println(person) 
}
