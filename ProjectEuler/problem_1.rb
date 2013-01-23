require 'ProjectEuler'

class Problem_1
  # If we list all the natural numbers below 10 that are multiples of 3 or 5,
  # we get 3, 5, 6 and 9. The sum of these multiples is 23.
  #
  # Find the sum of all the multiples of 3 or 5 below 1000.

  def self.solve
    # important that multiples of BOTH 3 and 5 not be double-counted
    puts (0...1000).select {|x| x % 3 == 0 || x % 5 == 0}.inject(:+)
  end
end

ProjectEuler.time do
  Problem_1.solve
end

