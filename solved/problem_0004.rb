require 'projectEuler'

# Largest palindrome product
class Problem_0004
  # A palindromic number reads the same both ways. The largest palindrome made
  # from the product of two 2-digit numbers is 9009 = 91 99.
  #
  # Find the largest palindrome made from the product of two 3-digit numbers.

  def self.solve( n )
    min = 10**(n - 1)
    max = (10 * min) - 1

    max.downto( min ).each do |i|
      # Create the next palindromic number.
      p = (i.to_s + i.to_s.reverse).to_i

      # Factors must be min <= f <= sqrt(p). The quotient of p and f <= max.
      # Find the first number with a factor satisfying these constraints.
      a = Math.sqrt( p ).to_i.downto( min ).select {|f| max >= p / f && 0 == p % f}
      if( 0 < a.length )
        puts "%d x %d = %d" % [a[0], p / a[0], p]
        break
      end
    end
  end
end

ProjectEuler.time do
  # 913 x 993 = 906609 (0.02400s)
  Problem_0004.solve( 3 )
end
