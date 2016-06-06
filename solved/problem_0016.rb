require 'projectEuler'

# 0.0003679s (2/1/13, #~84937)
class Problem_0016
  def title; 'Power digit sum' end
  def difficulty; 5 end

  # 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
  #
  # What is the sum of the digits of the number 2^1000?

  def solve( n = 1_000 )
    (2**n).sum_digits
  end

  def solution; 1_366 end
  def best_time; 0.0001931 end
  def effort; 0 end

  def completed_on; '2013-02-01' end
  def ordinality; 84_937 end
  def population; 277_405 end

  def refs; [] end
end
