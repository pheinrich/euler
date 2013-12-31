require 'projectEuler'

# 0.6012s (3/17/13, #~23371)
class Problem_0056
  def title; 'Powerful digit sum' end
  def solution; 972 end

  # A googol (10^100) is a massive number: one followed by one-hundred zeros;
  # 100^100 is almost unimaginably large: one followed by two-hundred zeros.
  # Despite their size, the sum of the digits in each number is only 1.
  #
  # Considering natural numbers of the form, a^b, where a, b < 100, what is
  # the maximum digital sum?

  def solve( n = 100 )
    max = 0
    1.upto( n - 1 ) do |a|
      1.upto( n - 1 ) do |b|
        m = (a**b).sum_digits
        max = m if m > max
      end
    end
    
    max
  end
end
