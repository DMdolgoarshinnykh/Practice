package main

func canJump(nums []int) bool {
        max_reach := 0
        for i := 0; i < len(nums); i++ {
                if i > max_reach {
                        return false
                }
                if max_reach < i + nums[i] {
                        max_reach = i + nums[i]
                }
                if max_reach >= len(nums)-1 {
                        return true
                }
        }
        return false
}

