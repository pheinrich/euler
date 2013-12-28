require 'projectEuler'

# 0.03066s (3/18/13)
class Problem_0057
  def title; 'Square root convergents' end
  def solution; 153 end

  # It is possible to show that the square root of two can be expressed as an
  # infinite continued fraction.
  #
  #     sqrt(2) = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...
  #
  # By expanding this for the first four iterations, we get:
  #
  #     1 + 1/2 = 3/2 = 1.5
  #     1 + 1/(2 + 1/2) = 7/5 = 1.4
  #     1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
  #     1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...
  #
  # The next three expansions are 99/70, 239/169, and 577/408, but the eighth
  # expansion, 1393/985, is the first example where the number of digits in
  # the numerator exceeds the number of digits in the denominator.
  #
  # In the first one-thousand expansions, how many fractions contain a
  # numerator with more digits than denominator?

  def solve( n = 1_000 )
    count = 0
    a, b = 2, 1

    n.times do
      count += 1 if (a + b).to_s.length > a.to_s.length
      a, b = (a << 1) + b, a
    end

    count
  end
end
