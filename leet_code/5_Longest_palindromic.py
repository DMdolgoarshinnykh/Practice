class Solution:
    def longestPalindrome(self, s: str) -> str:
        if len(s) == 1:
            return s
        longest_sub = ""
        for i in range(len(s) - 1):
            flag = False
            if s[i] == s[i + 1]:
                flag = True
                if len(longest_sub) == 1:
                    longest_sub = s[i] + s[i + 1]
            j = 0
            prob_sub = ""
            if flag == True:
                prob_sub = s[i] + s[i + 1]
                while i - j > 0 and i + j + 1 < len(s) and s[i - j - 1] == s[i + j + 2]:
                    j += 1
                    prob_sub = s[i - j] + prob_sub + s[i + j + 1]
            else:
                prob_sub = s[i]
                while i - j > 0 and i + j < len(s) and s[i - j - 1] == s[i + j + 1]:
                    j += 1
                    prob_sub = s[i - j] + prob_sub + s[i + j]
            if len(prob_sub) > len(longest_sub):
                longest_sub = prob_sub
        return longest_sub



if __name__ == "__main__":
    solution = Solution()
    result = solution.longestPalindrome("cbbd")
    print(result)

