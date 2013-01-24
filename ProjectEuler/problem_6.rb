require 'projectEuler'

class Problem_6
  # The sum of the squares of the first ten natural numbers is,
  #
  #      1^2 + 2^2 + ... + 10^2 = 385
  #
  # The square of the sum of the first ten natural numbers is,
  #
  #      (1 + 2 + ... + 10)^2 = 55^2 = 3025
  #
  # Hence the difference between the sum of the squares of the first ten
  # natural numbers and the square of the sum is 3025 - 385 = 2640.
  #
  # Find the difference between the sum of the squares of the first one
  # hundred natural numbers and the square of the sum.

  def self.solve( n )
    # Sum of squares is given by n(n + 1)(2n + 1) / 6, while square of sums
    # is [n(n + 1)][n(n + 1)] / 4.  Subtracting and simplifying the result
    # gives n(n + 1)(n - 1)(3n + 2) / 12.
    puts n * (n + 1) * (n - 1) * (3*n + 2) / 12
  end
end

ProjectEuler.time do
  Problem_6.solve( 100 )
end
