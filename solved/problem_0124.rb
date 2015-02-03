require 'projectEuler'

# 0.4321s (1/18/15, #8527)
class Problem_0124
  def title; 'Ordered radicals' end

  # The radical of n, rad(n), is the product of the distinct prime factors of
  # n. For example, 504 = 23 × 32 × 7, so rad(504) = 2 × 3 × 7 = 42.
  #
  # If we calculate rad(n) for 1 ≤ n ≤ 10, then sort them on rad(n), and
  # sorting on n if the radical values are equal, we get:
  #
  #        Unsorted           Sorted
  #       n   rad(n)       n   rad(n)  k
  #       1     1          1     1     1
  #       2     2          2     2     2
  #       3     3          4     2     3
  #       4     2          8     2     4
  #       5     5          3     3     5
  #       6     6          9     3     6
  #       7     7          5     5     7
  #       8     2          6     6     8
  #       9     3          7     7     9
  #      10    10         10    10    10
  #
  # Let E(k) be the kth element in the sorted n column; for example, E(4) = 8
  # and E(6) = 9.
  #
  # If rad(n) is sorted for 1 ≤ n ≤ 100000, find E(10000).

  def refs; [] end
  def solution; 21_417 end
  def best_time; 0.4321 end

  def completed_on; '2015-01-18' end
  def ordinality; 8_527 end
  def percentile; 98.12 end

  def solve( n = 100_000, k = 10_000 )
    (n + 1).radical_sieve.map.with_index {|x, i| [x, i]}.sort[k][1]
  end
end
