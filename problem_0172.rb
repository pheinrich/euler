require 'projectEuler'

# 
class Problem_0172
  def title; 'Investigating numbers with few repeated digits' end

  # How many 18-digit numbers n (without leading zeros) are there such that no
  # digit occurs more than three times in n?

  def refs
    ["http://en.wikipedia.org/wiki/Algebra_of_sets",
     "http://math.stackexchange.com/questions/122384/venn-diagram-3-set#122417"]
  end

  def solution; end
  def best_time; end

  def completed_on; '2015-01-21' end
  def ordinality; end
  def population; end

  def solve( len = 5, max = 1 )
    # Divide the numbers having len digits into ten overlapping subsets, one
    # for each numeral i, such that subset S_i contains all numbers in which
    # i appears more than max times. This question is asking us to compute the
    # size of the complement of the union of these sets, |S|.
    #
    # From De Morgan's laws, we can compute |S| by intersecting all the com-
    # plements of the S_i. Since (A ∪ B)' = A' ∩ B', an alternative expression
    # for the complement of the union is
    #                                                         9
    #   (S_0 ∪ S_1 ∪ ... ∪ S_9)' = S_0' ∩ S_1' ∩ ... ∩ S_9' = ∏ (1 - 1_Sk)
    #                                                        k=0
    # where 1_Sk is the indicator function of S_k:
    #
    #   1_Sk(x) = 1 if x ∈ S_k and 0 x ∉ S_k
    #
    # 1 - 1_Sk is the indicator function of the complement of S_k. This leads
    # to a sum of every possible intersection of the 10 sets S_i, changing
    # sign depending on the number of sets involved:
    #
    #  |S| =  ∑ (-1)^(|K|+1) |S_K|, where K = {0, 1, 2, ..., k}, k up to 9
    #        K≠∅
    #
    # Expanding this expression:
    #
    #   |S| =  |S_0| + |S_1| + |S_2| + ... + |S_9|
    #        - |S_0 ∩ S_1| - |S_0 ∩ S_2| - ... - |S_8 ∩ S_9|
    #        + |S_0 ∩ S_1 ∩ S_2| + |S_0 ∩ S_1 ∩ S_3| + ... + |S_7 ∩ S_8 ∩ S_9|
    #        - |S_0 ∩ S_1 ∩ S_2 ∩ S_3| - |S_0 ∩ S_1 ∩ S_2 ∩ S_4| - ...
    #        ...
    #        - |S_0 ∩ S_1 ∩ S_2 ∩ ... ∩ S_9|
    #
    # There's no way more than 4 numerals can appear 4 or more times in the
    # 18-digit numbers described in the problem statement, so we can drop all
    # the intersection terms containing more than 4 sets. We must calculate
    # the remaining terms or count them and multiply by a general expression.
    #
    #   |S_0| = [1-9](17 4)(9^13) + [1-9](17 5)(9^12) + ... + [1-9](17 17)
    #         = (17 4)(9^14) + (17 5)(9^13) + ... + (17 17)9
    #   |S_1| = 1(17 3)(9^14) + 1(17 4)(9^13) + ... + 1(17 17) +
    #           [2-9](17 4)(9^13) + [2-9](17 5)(9^12) + ... + [2-9](17 17)
    #         = (17 3)(9^14) + (17 4)(9^14) + (17 5)(9^13) + ... + (17 17)9
    #         = (17 3)(9^14) + |S_0|
    #   ∑ |S_i| = (17 3)(9^15) + (17 4)(9^15) + (17 5)(9^14) + ... + (17 17)(9^2)
    #
    #   |S_0 ∩ S_1| = 1(17 3)(14 4)(9^10) + 1(17 4)(13 4)(9^9) + ... + 1(17 13)(4 4) +
    #                 1(17 3)(14 5)(9^9) + 1(17 4)(13 5)(9^8) + ... + 1(17
    #          [2-9](17 8)(9^9) + [2-9](

    lower = 10**(len-1)
    upper = 10**len
    range = upper - lower
    max += 1
    range - 9 * (max..len).reduce( 0 ) {|add, i| add + len.choose( i ) * 9**(len - i)}
  end
  
  # 227485267000992000
  # 809_395_012_528_478_910
end
