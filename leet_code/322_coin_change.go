package main

func coinChange(coins []int, amount int) int {
	counter:= 0
	i:= len(coins)
	for amount > 0{
		if i == 0{
			return -1
		}
		if amount > coins[i]{
			amount = amount - coins[i]
			counter = counter + 1
		else
			i = i-1
		}
	}
	return counter   
}
