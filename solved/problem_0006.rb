require 'projectEuler'

# 0.00003624s (1/24/13, #~157925)
class Problem_0006
  def title; 'Sum square difference' end
  
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

  def refs; [] end
  def solution; 25_164_150 end
  def best_time; 0.00003624 end

  def completed_on; '2013-01-24' end
  def ordinality; 157_925 end
  def percentile; 45.39 end

  def solve( n = 100 )
    # Sum of squares is given by n(n + 1)(2n + 1) / 6, while square of sums
    # is [n(n + 1)][n(n + 1)] / 4.  Subtracting and simplifying the result
    # gives n(n + 1)(n - 1)(3n + 2) / 12.
    n * (n + 1) * (n - 1) * (3*n + 2) / 12
  end
end
