package calculator

import (
	"fmt"
)

type Calculator struct {
    result float64
}

func (c *Calculator) Add(a, b float64) float64 {
    c.result = a + b
    return c.result
}

func (c *Calculator) Subtract(a, b float64) float64 {
    c.result = a - b
    return c.result
}

func (c *Calculator) Multiply(a, b float64) float64 {
    c.result = a * b
    return c.result
}

func (c *Calculator) Divide(a, b float64) (float64, error) {
    if b == 0 {
        return 0, fmt.Errorf("division by zero")
    }
    c.result = a / b
    return c.result, nil
}
