require 'projectEuler'

# Summation of primes
class Problem_0010
  # The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
  #
  # Find the sum of all the primes below two million.

  def self.solve( n )
    puts ProjectEuler.eratosthenes( n ).inject(:+)
  end
end

ProjectEuler.time do
  # 142913828922 (1.993s)
  Problem_0010.solve( 2000000 )
end
