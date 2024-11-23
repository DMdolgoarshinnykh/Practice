class Solution:
    def stoneGameVI(self, aliceValues: list[int], bobValues: list[int]) -> int:
        n = len(aliceValues)
        stones = [(aliceValues[i] + bobValues[i], i) for i in range(n)]
        stones.sort(reverse=True, key=lambda x: x[0])

        alice_score = 0
        bob_score = 0

        for i in range(n):
            if i % 2 == 0:
                alice_score += aliceValues[stones[i][1]]
            else:
                bob_score += bobValues[stones[i][1]]
        if alice_score > bob_score:
            return 1
        elif bob_score > alice_score:
            return -1
        else:
            return 0


if __name__ == "__main__":
    solution = Solution()
    result = solution.stoneGameVI([1, 3], [2, 1])
    print(result)
