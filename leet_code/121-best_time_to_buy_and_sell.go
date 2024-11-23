package main

func maxProfit(prices []int) int{
	profit := 0
	for i := 0; i < len(prices)-1; i++{
		for j:= i; j < len(prices); j++{
			if prices[j] - prices[i] > profit{
				profit = prices[j] - prices[i]
			}
		}
	}
	return profit
}
