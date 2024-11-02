package main

func majorityElement(nums []int) int {
	candidate := nums[0]
	count := 1
	for _, num := range nums[1:] {
		if num == candidate {
			count++
		} else {
			count--
		}
		if count == 0 {
			candidate = num
			count = 1
		}
	}
	return candidate
}

