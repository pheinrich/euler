require 'projectEuler'

# 0.0002527s (1/21/13, #~274675)
class Problem_0001
  def title;'Multiples of 3 and 5' end
  def solution; 233_168 end

  # If we list all the natural numbers below 10 that are multiples of 3 or 5,
  # we get 3, 5, 6 and 9. The sum of these multiples is 23.
  #
  # Find the sum of all the multiples of 3 or 5 below 1000.

  def solve( n = 1_000, a = 3, b = 5 )
    # Important that multiples of BOTH a and b not be double-counted.
    (0...n).select {|x| 0 == x % a || 0 == x % b}.inject( :+ )
  end
end
