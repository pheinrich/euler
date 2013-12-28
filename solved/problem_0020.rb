require 'projectEuler'

# 0.0003011s (2/1/13)
class Problem_0020
  def title; 'Factorial digit sum' end
  def solution; 648 end

  # n! means n x (n - 1) x ... x 3 x 2 x 1
  #
  # For example, 10! = 10 x 9 x ... x 3 x 2 x 1 = 3628800, and the sum of the
  # digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
  #
  # Find the sum of the digits in the number 100!

  def solve( n = 100 )
    n.fact.sum_digits
  end
end
