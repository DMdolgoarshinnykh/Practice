package calculator

import (
    "math"
    "testing"
)

func TestAdd(t *testing.T) {
    tests := []struct {
        name     string
        a, b     float64
        expected float64
    }{
        {"positive numbers", 2, 3, 5},
        {"negative numbers", -2, -3, -5},
        {"zero and positive", 0, 5, 5},
        {"large numbers", 999999, 1, 1000000},
        {"decimals", 0.1, 0.2, 0.3},
    }

    calc := Calculator{}
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            result := calc.Add(tt.a, tt.b)
            if math.Abs(result-tt.expected) > 0.0001 {
                t.Errorf("Add(%f, %f) = %f; want %f", tt.a, tt.b, result, tt.expected)
            }
        })
    }
}

func TestSubtract(t *testing.T) {
    tests := []struct {
        name     string
        a, b     float64
        expected float64
    }{
        {"positive numbers", 5, 3, 2},
        {"negative numbers", -5, -3, -2},
        {"zero result", 5, 5, 0},
        {"subtract from zero", 0, 5, -5},
        {"decimals", 0.3, 0.1, 0.2},
    }

    calc := Calculator{}
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            result := calc.Subtract(tt.a, tt.b)
            if math.Abs(result-tt.expected) > 0.0001 {
                t.Errorf("Subtract(%f, %f) = %f; want %f", tt.a, tt.b, result, tt.expected)
            }
        })
    }
}

func TestMultiply(t *testing.T) {
    tests := []struct {
        name     string
        a, b     float64
        expected float64
    }{
        {"positive numbers", 2, 3, 6},
        {"negative numbers", -2, -3, 6},
        {"zero multiplication", 5, 0, 0},
        {"one multiplication", 5, 1, 5},
        {"decimals", 0.1, 0.1, 0.01},
    }

    calc := Calculator{}
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            result := calc.Multiply(tt.a, tt.b)
            if math.Abs(result-tt.expected) > 0.0001 {
                t.Errorf("Multiply(%f, %f) = %f; want %f", tt.a, tt.b, result, tt.expected)
            }
        })
    }
}

func TestDivide(t *testing.T) {
    tests := []struct {
        name        string
        a, b        float64
        expected    float64
        expectError bool
    }{
        {"positive numbers", 6, 2, 3, false},
        {"negative numbers", -6, -2, 3, false},
        {"divide by zero", 5, 0, 0, true},
        {"zero divided", 0, 5, 0, false},
        {"decimals", 0.1, 0.1, 1, false},
    }

    calc := Calculator{}
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            result, err := calc.Divide(tt.a, tt.b)
            
            if tt.expectError {
                if err == nil {
                    t.Errorf("Divide(%f, %f) expected error, got nil", tt.a, tt.b)
                }
                return
            }
            
            if err != nil {
                t.Errorf("Divide(%f, %f) unexpected error: %v", tt.a, tt.b, err)
                return
            }
            
            if math.Abs(result-tt.expected) > 0.0001 {
                t.Errorf("Divide(%f, %f) = %f; want %f", tt.a, tt.b, result, tt.expected)
            }
        })
    }
}
