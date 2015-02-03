require 'projectEuler'

# 0.005718s (1/31/15, #7181)
class Problem_0119
  def title; 'Digit power sum' end

  # The number 512 is interesting because it is equal to the sum of its digits
  # raised to some power: 5 + 1 + 2 = 8, and 8^3 = 512. Another example of a
  # number with this property is 614656 = 28^4.
  #
  # We shall define a[n] to be the nth term of this sequence and insist that a
  # number must contain at least two digits to have a sum.
  #
  # You are given that a[2] = 512 and a[10] = 614656.
  #
  # Find a[30].

  def refs; [] end
  def solution; 248_155_780_267_521 end
  def best_time; 0.005718 end

  def completed_on; '2015-01-31' end
  def ordinality; 7_181 end
  def percentile; 98.43 end

  def solve( n = 30 )
    term = nil

    (2..10).each do |e|
      (2..100).each do |sum|
        if (sum**e).sum_digits == sum
          term, n = sum**e, n - 1 
        end
        break if 0 == n
      end
      break if 0 == n
    end

    term
  end
end
