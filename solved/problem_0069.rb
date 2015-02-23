require 'projectEuler'

# 1.880s (12/16/13, ~16665)
class Problem_0069
  def title; 'Totient maximum' end

  # Euler's Totient function, φ(n) [sometimes called the phi function], is
  # used to determine the number of numbers less than n which are relatively
  # prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine
  # and relatively prime to nine, φ(9)=6.
  #
  #      n Relatively Prime  φ(n)  n/φ(n)
  #     ---------------------------------
  #      2  1                 1     2
  #      3  1,2               2     1.5
  #      4  1,3               2     2
  #      5  1,2,3,4           4     1.25
  #      6  1,5               2     3
  #      7  1,2,3,4,5,6       6     1.1666...
  #      8  1,3,5,7           4     2
  #      9  1,2,4,5,7,8       6     1.5
  #     10  1,3,7,9           4     2.5
  #
  # It can be seen that n=6 produces a maximum n/φ(n) for n <= 10.
  #
  # Find the value of n <= 1,000,000 for which n/φ(n) is a maximum.

  def refs; [] end
  def solution; 510_510 end
  def best_time; 0.8761 end

  def completed_on; '2013-12-16' end
  def ordinality; 16_665 end
  def percentile; 95.73 end

  def solve( n = 1_000_000 )
    s = n.totient_sieve
    s[0] = 1
    s.each_with_index.max_by {|i, j| j.to_f / i}[1]
  end
end
