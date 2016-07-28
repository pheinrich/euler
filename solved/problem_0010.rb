require 'projectEuler'

class Problem_0010
  def title; 'Summation of primes' end
  def difficulty; 5 end

  # The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
  #
  # Find the sum of all the primes below two million.

  def solve( n = 2_000_000 )
    n.prime_sieve.inject( :+ )
  end

  def solution; 'MTQyOTEzODI4OTIy' end
  def best_time; 0.1309 end
  def effort; 0 end

  def completed_on; '2013-01-26' end
  def ordinality; 104_986 end
  def population; 275_916 end

  def refs
    ['https://oeis.org/A007504']
  end
end
