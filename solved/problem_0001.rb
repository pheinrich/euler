require 'projectEuler'

# Multiples of 3 and 5
class Problem_0001
  # If we list all the natural numbers below 10 that are multiples of 3 or 5,
  # we get 3, 5, 6 and 9. The sum of these multiples is 23.
  #
  # Find the sum of all the multiples of 3 or 5 below 1000.

  def self.solve( n, a, b )
    # Important that multiples of BOTH a and b not be double-counted.
    puts( (0...n).select {|x| 0 == x % a || 0 == x % b}.inject(:+) )
  end
end

ProjectEuler.time do
  # 233168 (0.0009999s)
  Problem_0001.solve( 1000, 3, 5 )
end

