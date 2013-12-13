require 'projectEuler'

# Power digit sum
class Problem_0016
  # 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
  #
  # What is the sum of the digits of the number 2^1000?

  def self.solve( n )
    puts( (2**n).sum_digits )
  end
end

ProjectEuler.time do
  # 1366 (0.001000s)
  Problem_0016.solve( 1000 )
end
