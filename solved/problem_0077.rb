require 'projectEuler'

# 0.001203s (#8833)
class Problem_0077
  def title; 'Prime summations' end
  def solution; 71 end

  # It is possible to write ten as the sum of primes in exactly five different
  # ways:
  #
  #     7 + 3
  #     5 + 5
  #     5 + 3 + 2
  #     3 + 3 + 2 + 2
  #     2 + 2 + 2 + 2 + 2
  #
  # What is the first value which can be written as the sum of primes in over
  # five thousand different ways?

  def solve( n = 5_000 )
    # From observation, brute force.
    limit = (10 * Math.log( n )).floor
    limit.primepartition_sieve.find_index {|i| i > n}
  end
end
