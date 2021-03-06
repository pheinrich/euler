require 'projectEuler'

class Problem_0056
  def title; 'Powerful digit sum' end
  def difficulty; 5 end

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

  def solution; 'OTcy' end
  def best_time; 0.4690 end
  def effort; 0 end

  def completed_on; '2013-03-17' end
  def ordinality; 23_371 end
  def population; 305_961 end

  def refs
    ['https://oeis.org/A135740']
  end
end
