require 'projectEuler'

# 0.8394s (1/26/13, #~104986)
class Problem_0010
  def title; 'Summation of primes' end

  # The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
  #
  # Find the sum of all the primes below two million.

  def refs; [] end
  def solution; 142_913_828_922 end
  def best_time; 0.4803 end

  def completed_on; '2013-01-26' end
  def ordinality; 104_986 end
  def population; 275_916 end

  def solve( n = 2_000_000 )
    n.prime_sieve.inject( :+ )
  end
end
