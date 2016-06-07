require 'projectEuler'

# 0.01049s (1/14/15, #5756)
class Problem_0115
  def title; 'Counting block combinations II' end
  def difficulty; 35 end

  # NOTE: This is a more difficult version of Problem 114.
  #
  # A row measuring n units in length has red blocks with a minimum length of
  # m units placed on it, such that any two red blocks (which are allowed to
  # be different lengths) are separated by at least one black square.
  #
  # Let the fill-count function, F(m, n), represent the number of ways that a
  # row can be filled.
  #
  # For example, F(3, 29) = 673135 and F(3, 30) = 1089155.
  #
  # That is, for m = 3, it can be seen that n = 30 is the smallest value for
  # which the fill-count function first exceeds one million.
  #
  # In the same way, for m = 10, it can be verified that F(10, 56) = 880711
  # and F(10, 57) = 1148904, so n = 57 is the least value for which the fill-
  # count function first exceeds one million.
  #
  # For m = 50, find the least value of n for which the fill-count function
  # first exceeds one million.

  def fill( min, row, memo )
    return memo[row] if memo[row]

    total = 0
    if min <= row
      (min..row).each do |len|
        total += row - len + 1

        (row - len - 1).downto( min ) do |sub|
          total += fill( min, sub, memo )
        end
      end
    end

    memo[row] = total
  end

  def solve( m = 50, thresh = 1_000_000 )
    count, low, high = 0, 0, m + 1

    # Advance upper limit until threshold is exceeded.
    while count <= thresh
      low, high = high, high + m
      count = fill( m, high, {} )
    end

    # Use binary search to zero in on the correct value.
    ProjectEuler.bsearch( low, high, lambda {|x| thresh > fill( m, x, {} )} )
  end

  def solution; 168 end
  def best_time; 0.01049 end
  def effort; 35 end
  
  def completed_on; '2015-01-14' end
  def ordinality; 5_756 end
  def population; 454_097 end

  def refs; [] end
end
