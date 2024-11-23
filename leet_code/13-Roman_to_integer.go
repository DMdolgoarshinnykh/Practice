package main

func romanToInt(s string) int {
    result := 0
    if len(s) == 1 {
        return charToInt(s[0])
    }
    
    for i := 0; i < len(s)-1; i++ {
        if charToInt(s[i]) >= charToInt(s[i+1]) {
            result = result + charToInt(s[i])
        } else {
            result = result + charToInt(s[i+1]) - charToInt(s[i])
            i++
        }
    }
    
    if i := len(s) - 1; i >= 0 && (i == 0 || charToInt(s[i]) >= charToInt(s[i-1])) {
        result = result + charToInt(s[i])
    }
    
    return result
}

func charToInt(c byte) int {
    switch c {
    case 'I':
        return 1
    case 'V':
        return 5
    case 'X':
        return 10
    case 'L':
        return 50
    case 'C':
        return 100
    case 'D':
        return 500
    case 'M':
        return 1000
    default:
        return 0
    }
}

