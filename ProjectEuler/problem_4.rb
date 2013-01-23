require 'ProjectEuler'

class Problem_4
  # A palindromic number reads the same both ways. The largest palindrome made
  # from the product of two 2-digit numbers is 9009 = 91 99.
  #
  # Find the largest palindrome made from the product of two 3-digit numbers.

  def self.solve
    # Maximum product of two 3-digit numbers is 999*999 = 998001.  Largest
    # palindromic number less than this is 997799.  Minimum product would be
    # 100*100 = 10000.  Smallest palindromic number greater that this is
    # 100001.  Answer must therefore be 100001 <= N <= 997799.
    997.downto(100).each do |i|
      # Create the next palindromic number.
      n = (i.to_s + i.to_s.reverse).to_i

      # Factors must be 100 <= f <= sqrt(n). The quotient of n and f < 1000.
      # Find the first number with a factor satisfying these constraints.
      if( 0 < Math.sqrt(n).to_i.downto(100).count {|f| 1000 > n / f && 0 == n % f} )
        puts n
        break
      end
    end
  end

  def self.is_palindrome(n)
    forward = n
    backward = 0

    while 0 < n do
      backward = (10 * backward) + n % 10
      n /= 10
    end

    return forward == backward
  end

  def self.solve_fast
    p = 0

    # Brute force method that uses no division/square roots.
    999.downto( 100 ).each do |i|
      i.downto( 100 ).each do |j|
        p = [p, i * j].max if is_palindrome( i * j )
      end
    end
    
    puts p
  end
end

ProjectEuler.time do
  Problem_4.solve
end

ProjectEuler.time do
  # Seems to be significantly (25x) slower.
  Problem_4.solve_fast
end
