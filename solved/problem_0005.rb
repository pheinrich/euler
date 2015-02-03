require 'projectEuler'

# 0.00006294s (1/23/13, #~151793)
class Problem_0005
  def title; 'Smallest multiple' end

  # 2520 is the smallest number that can be divided by each of the numbers
  # from 1 to 10 without any remainder.
  #
  # What is the smallest positive number that is evenly divisible by all of
  # the numbers from 1 to 20?
  
  def refs; [] end
  def solution; 232_792_560 end
  def best_time; 0.00006294 end

  def completed_on; '2013-01-23' end
  def ordinality; 151_793 end
  def percentile; 45.79 end

  def solve( n = 20 )
    (2..n).inject {|acc, i| acc.lcm( i )}
  end
end
