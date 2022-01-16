---
layout: single
title: "Longest common subsequence in Java"
date: 2021-11-12 09:08:53 +0200
categories: development
comments: true
lang: en
tags: algorithms
image: 
---

In this post we will see how to solve a problem that is to look for the longest common subsequence of two Strings that we receive as input parameters. 

To solve this we will use a technique that is called <a href="https://en.wikipedia.org/wiki/Dynamic_programming">dynamic programming</a>. This technique uses the fact that a problem can be break into sub-problems in a recursive manner and using the results of previous sub-problems allow us to avoid repeating previous computations.

In this particular problem we will use a matrix called `DP` that at any given position (i, j) will have calculated the previous number characters that form a subsequence in both input Strings. 


```java

public class LongestCommonSubsequence {

    public int calculateLongestCommonSubsequence(String a, String b) {

        int N = a.length();
        int M = b.length();

        if (N == 0 || M == 0) {
            return 0;
        }

        int[][] DP = new int[N][M];

        if (a.charAt(0) == b.charAt(0)) {
            DP[0][0] = 1;
        }
        for (int i = 1; i < N; i++) {
            DP[i][0] = (DP[i - 1][0] == 1 || a.charAt(i) == b.charAt(0)) ? 1 : 0;
        }
        for (int j = 1; j < M; j++) {
            DP[0][j] = (DP[0][j - 1] == 1 || a.charAt(0) == b.charAt(j)) ? 1 : 0;
        }
        for (int i = 1; i < N; i++) {
            for (int j = 1; j < M; j++) {
                DP[i][j] = Math.max(DP[i - 1][j], DP[i][j - 1]);
                if (a.charAt(i) == b.charAt(j)) {
                    DP[i][j] = Math.max(DP[i][j], 1 + DP[i - 1][j - 1]);
                }
            }
        }
        return DP[N - 1][M - 1];
    }


    public static void main(String[] args) {
        LongestCommonSubsequence longestCommonSubsequence = new LongestCommonSubsequence();
        System.out.println(longestCommonSubsequence.calculateLongestCommonSubsequence("alex", "alexander"));
    }
}

```

### Conclusion

In this post we have seen how to solve the problem of finding the longest common subsequence between two Strings that we receive as input parameters using dynamic programming.


