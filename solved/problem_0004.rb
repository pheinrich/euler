require 'projectEuler'

# 0.02400s (1/22/13, #~135206)
class Problem_0004
  def title; 'Largest palindrome product' end
  def difficulty; 5 end

  # A palindromic number reads the same both ways. The largest palindrome made
  # from the product of two 2-digit numbers is 9009 = 91 99.
  #
  # Find the largest palindrome made from the product of two 3-digit numbers.

  def solve( n = 3 )
    min = 10**(n - 1)
    max = (10 * min) - 1

    max.downto( min ).each do |i|
      # Create the next palindromic number.
      p = (i.to_s + i.to_s.reverse).to_i

      # Factors must be min <= f <= sqrt(p). The quotient of p and f <= max.
      # Find the first number with a factor satisfying these constraints.
      a = Math.sqrt( p ).to_i.downto( min ).select {|f| max >= p / f && 0 == p % f}
      return p if 0 < a.length #puts "%d x %d = %d" % [a[0], p / a[0], p]
    end
  end

  def solution; 906_609 end
  def best_time; 0.007184 end
  def effort; 5 end

  def completed_on; '2013-01-22' end
  def ordinality; 135_206 end
  def population; 274_923 end

  def refs; [] end
end
