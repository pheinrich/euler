require 'projectEuler'

# 0.0003679s (2/1/13, #~84937)
class Problem_0016
  def title; 'Power digit sum' end
  def solution; 1_366 end

  # 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
  #
  # What is the sum of the digits of the number 2^1000?

  def solve( n = 1_000 )
    (2**n).sum_digits
  end
end
