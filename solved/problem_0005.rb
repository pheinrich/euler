require 'projectEuler'

class Problem_0005
  def title; 'Smallest multiple' end
  def difficulty; 5 end

  # 2520 is the smallest number that can be divided by each of the numbers
  # from 1 to 10 without any remainder.
  #
  # What is the smallest positive number that is evenly divisible by all of
  # the numbers from 1 to 20?
  
  def solve( n = 20 )
    (2..n).inject {|acc, i| acc.lcm( i )}
  end

  def solution; 'MjMyNzkyNTYw' end
  def best_time; 0.00001693 end
  def effort; 0 end

  def completed_on; '2013-01-23' end
  def ordinality; 151_793 end
  def population; 275_191 end

  def refs; [] end
end
