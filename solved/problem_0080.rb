require 'projectEuler'

# 0.2013s (#9575)
class Problem_0080
  def title; 'Square root digital expansion' end
  def solution; 40_886 end

  # It is well known that if the square root of a natural number is not an
  # integer, then it is irrational. The decimal expansion of such square roots
  # is infinite without any repeating pattern at all.
  #
  # The square root of two is 1.41421356237309504880..., and the digital sum
  # of the first one hundred decimal digits is 475.
  #
  # For the first one hundred natural numbers, find the total of the digital
  # sums of the first one hundred decimal digits for all the irrational square
  # roots.

  def solve( n = 100, figs = 100 )
    sum = 0

    n.times do |i|
      digits = []

      # Do manual "long division"-type root calculation.  See
      # http://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Decimal_.28base_10.29
      d = Math.sqrt( i ).floor
      r = i - d*d
      next if 0 == r

      figs.times do
        digits << d
        r *= 100
        subt = 20 * digits.join.to_i

        # Find the digit that produces a subtrahend closest to the minuend
        # without going over.
        9.downto( 0 ) do |b|
          p = b * (subt + b)

          if p <= r
            d, r = b, r - p
            break
          end
        end
      end

      sum += digits.inject( :+ )
    end

    sum
  end
end
