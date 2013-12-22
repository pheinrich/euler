require 'projectEuler'

# Prime power triples
class Problem_0087
  # The smallest number expressible as the sum of a prime square, prime cube,
  # and prime fourth power is 28. In fact, there are exactly four numbers
  # below fifty that can be expressed in such a way:
  #
  #     28 = 2^2 + 2^3 + 2^4
  #     33 = 3^2 + 2^3 + 2^4
  #     49 = 5^2 + 2^3 + 2^4
  #     47 = 2^2 + 3^3 + 2^4
  # 
  # How many numbers below fifty million can be expressed as the sum of a
  # prime square, prime cube, and prime fourth power?

  def self.solve( n )
  end
end

ProjectEuler.time do
  # 
  Problem_0087.solve( 50000000 )
end
