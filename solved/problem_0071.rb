require 'projectEuler'

# 0.03006s (12/19/13, #~14078)
class Problem_0071
  def title; 'Ordered fractions' end

  # Consider the fraction, n/d, where n and d are positive integers. If n<d
  # and HCF(n,d)=1, it is called a reduced proper fraction.
  #
  # If we list the set of reduced proper fractions for d ≤ 8 in ascending
  # order of size, we get:
  #
  #    1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2,
  #       4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8
  #
  # It can be seen that 2/5 is the fraction immediately to the left of 3/7.
  #
  # By listing the set of reduced proper fractions for d ≤ 1,000,000 in
  # ascending order of size, find the numerator of the fraction immediately
  # to the left of 3/7.

  def refs; ["http://en.wikipedia.org/wiki/Farey_sequence#Next_term"] end
  def solution; 428_570 end
  def best_time; 0.03006 end

  def completed_on; '2013-12-19' end
  def ordinality; 14_078 end
  def percentile; 96.42 end

  def solve( n = 1_000_000, numer = 3, denom = 7 )
    a, b, c, d = 0, 1, 1, denom

    # Find the nearest neighbor in the Farey sequence where numer/denom first
    # appears, i.e. F(denom).
    while c <= denom && c != numer
      k = (denom + b) / d
      a, b, c, d = c, d, k*c - a, k*d - b
    end

    c, d = a, b

    # Repeatedly compute the mediant of a/b and numer/denom until denominator
    # exceeds n.  The last previous mediant value is the neighbor in the Farey
    # sequence of order n.
    begin
      a, b, c, d = c, d, c + numer, d + denom
      gcd = c.gcd( d )
      c, d = c / gcd, d / gcd if 1 < gcd
    end while n >= d

    a # puts "#{a}/#{b}"
  end
end
