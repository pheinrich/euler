require 'projectEuler'

# 0.8394s (1/26/13, #~104986)
class Problem_0010
  def title; 'Summation of primes' end
  def solution; 142_913_828_922 end

  # The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
  #
  # Find the sum of all the primes below two million.

  def solve( n = 2_000_000 )
    n.prime_sieve.inject( :+ )
  end
end
