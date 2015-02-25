require 'projectEuler'

# 0.0002179s (2/13/13, #~46228)
class Problem_0028
  def title; 'Number spiral diagonals' end

  # Starting with the number 1 and moving to the right in a clockwise
  # direction a 5 by 5 spiral is formed as follows:
  #
  #     21 22 23 24 25
  #     20  7  8  9 10
  #     19  6  1  2 11
  #     18  5  4  3 12
  #     17 16 15 14 13
  #
  # It can be verified that the sum of the numbers on the diagonals is 101.
  #
  # What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral
  # formed in the same way?

  def refs; [] end
  def solution; 669_171_001 end
  def best_time; 0.00006700 end

  def completed_on; '2013-02-13' end
  def ordinality; 46_228 end
  def population; 280_383 end

  def solve( n = 1_001 )
    # For each enclosing rectangle, index 0 < i < (n - 1)/2, the corner values
    # are given by:
    #
    #     lr[0] = ll[0] = ul[0] = ur[0] = 1, and
    #
    #     lr[i+1] = lr[i] + 8*i + 2
    #     ll[i+i] = ll[i] + 8*i + 4 = lr[i] + 10*i + 4
    #     ul[i+1] = ul[i] + 8*i + 6 = lr[i] + 12*i + 6
    #     ur[i+i] = ur[i] + 8*i + 8 = lr[i] + 14*i + 8
    #
    # The sum of the corners of rectangle i for 0 < i is then given by
    #
    #     sum[i+1] = lr[i+1] + ll[i+1] + ul[i+1] + ur[i+1] = 4*lr[i] + 44*i + 20
    #     sum[i+1] = sum[i] + 32*i + 20

    sum = 4
    total = 0

    0.upto( n >> 1 ) do |i|
      total += sum
      sum += ((i << 3) + 5) << 2
    end

    # The center 1 was counted four times, so adjust.
    total - 3
  end
end
