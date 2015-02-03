require 'projectEuler'

# 6.2399s (1/26/13, #~69659)
class Problem_0012
  def title; 'Highly divisible triangular number' end

  # The sequence of triangle numbers is generated by adding the natural
  # numbers. So the 7th triangle number would be
  #
  #           1 + 2 + 3 + 4 + 5 + 6 + 7 = 28.
  #
  # The first ten terms would be:
  #
  #           1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
  #
  # Let us list the factors of the first seven triangle numbers:
  #
  #      1: 1
  #      3: 1,3
  #      6: 1,2,3,6
  #     10: 1,2,5,10
  #     15: 1,3,5,15
  #     21: 1,3,7,21
  #     28: 1,2,4,7,14,28
  #
  # We can see that 28 is the first triangle number to have over five
  # divisors.
  #
  # What is the value of the first triangle number to have over five hundred
  # divisors?

  def refs; [] end
  def solution; 76_576_500 end
  def best_time; 6.240 end

  def completed_on; '2013-01-26' end
  def ordinality; 69_659 end
  def percentile; 74.64 end

  def solve( n = 500 )
    i = t = f = 0

    until f > n
      i += 1
      t += i
      f = t.factors.count
    end

    t
  end
end
