require 'projectEuler'

# Powerful digit sum
class Problem_0056
  # A googol (10^100) is a massive number: one followed by one-hundred zeros;
  # 100^100 is almost unimaginably large: one followed by two-hundred zeros.
  # Despite their size, the sum of the digits in each number is only 1.
  #
  # Considering natural numbers of the form, a^b, where a, b < 100, what is
  # the maximum digital sum?

  def self.solve( n )
    max = 0
    1.upto( n - 1 ) do |a|
      1.upto( n - 1 ) do |b|
        m = (a**b).sum_digits
        max = m if m > max
      end
    end
    
    puts max
  end
end

ProjectEuler.time do
  # 972
  Problem_0056.solve( 100 )
end
