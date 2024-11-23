class Solution:
    def waysToBuyPensPencils(self, total: int, cost1: int, cost2: int) -> int:
        ways = 0
        for pens in range(total // cost1 + 1):
            remaining = total - (pens * cost1)
            ways += remaining // cost2 + 1
        return ways

if __name__ == "__main__":
    solution = Solution()
    result = solution.waysToBuyPensPencils(20, 10, 5)
    print(result)
