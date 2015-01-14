require 'projectEuler'

# 
class Problem_0106
  def title; 'Special subset sums: meta-testing' end
  def solution;  end

  # Let S(A) represent the sum of elements in set A of size n. We shall call
  # it a special sum set if for any two non-empty disjoint subsets, B and C,
  # the following properties are true:
  #
  #      i.  S(B) ≠ S(C); that is, sums of subsets cannot be equal.
  #      ii. If B contains more elements than C then S(B) > S(C).
  #
  # For this problem we shall assume that a given set contains n strictly in-
  # creasing elements and it already satisfies the second rule.
  #
  # Surprisingly, out of the 25 possible subset pairs that can be obtained
  # from a set for which n = 4, only 1 of these pairs need to be tested for
  # equality (first rule). Similarly, when n = 7, only 70 out of the 966
  # subset pairs need to be tested.
  #
  # For n = 12, how many of the 261625 subset pairs that can be obtained need
  # to be tested for equality?
  #
  # NOTE: This problem is related to Problem 103 and Problem 105.

  def solve( n = 12 )
  end
end