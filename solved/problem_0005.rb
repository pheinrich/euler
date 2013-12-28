require 'projectEuler'

# 0.00006294s (1/23/13)
class Problem_0005
  def title; 'Smallest multiple' end
  def solution; 232_792_560 end

  # 2520 is the smallest number that can be divided by each of the numbers
  # from 1 to 10 without any remainder.
  #
  # What is the smallest positive number that is evenly divisible by all of
  # the numbers from 1 to 20?
  
  def solve( n = 20 )
    (2..n).inject {|acc, i| acc.lcm( i )}
  end
end
