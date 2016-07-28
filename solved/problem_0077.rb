require 'projectEuler'

class Problem_0077
  def title; 'Prime summations' end
  def difficulty; 25 end

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

  def solution; 'NzE=' end
  def best_time; 0.0005162 end
  def effort; 30 end

  def completed_on; '2013-12-25' end
  def ordinality; 8_833 end
  def population; 358_554 end

  def refs; [] end
end
