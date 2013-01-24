require 'projectEuler'

class Problem_3
  # The prime factors of 13195 are 5, 7, 13 and 29.
  #
  # What is the largest prime factor of the number 600851475143?

  def self.solve( n )
    puts ProjectEuler.prime_factors( n )[-1]
  end
end

ProjectEuler.time do
  Problem_3.solve( 600851475143 )
end
