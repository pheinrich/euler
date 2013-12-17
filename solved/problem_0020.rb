require 'projectEuler'

# Factorial digit sum
class Problem_0020
  # n! means n x (n - 1) x ... x 3 x 2 x 1
  #
  # For example, 10! = 10 x 9 x ... x 3 x 2 x 1 = 3628800, and the sum of the
  # digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
  #
  # Find the sum of the digits in the number 100!

  def self.solve( n )
    puts n.fact.sum_digits
  end
end

ProjectEuler.time do
  # 648 (0.0000s)
  Problem_0020.solve( 100 )
end
