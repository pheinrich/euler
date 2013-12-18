require 'projectEuler'

# Smallest multiple
class Problem_0005
  # 2520 is the smallest number that can be divided by each of the numbers
  # from 1 to 10 without any remainder.
  #
  # What is the smallest positive number that is evenly divisible by all of
  # the numbers from 1 to 20?
  
  def self.solve( n )
    puts( (2..n).inject {|acc, i| acc.lcm( i )} )
  end
end

ProjectEuler.time do
  # 232792560 (0.0000s)
  Problem_0005.solve( 20 )
end
