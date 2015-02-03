require 'projectEuler'

# 0.002269s (1/13/15, #6267)
class Problem_0114
  def title; 'Counting block combinations I' end

  # A row measuring seven units in length has red blocks with a minimum length
  # of three units placed on it, such that any two red blocks (which are
  # allowed to be different lengths) are separated by at least one black
  # square. There are exactly seventeen ways of doing this (see
  # problem_0113.png).
  #
  # How many ways can a row measuring fifty units in length be filled?
  #
  # NOTE: Although the example above does not lend itself to the possibility,
  # in general it is permitted to mix block sizes. For example, on a row
  # measuring eight units in length you could use red (3), black (1), and red
  # (4).

  def refs; [] end
  def solution; 16_475_640_049 end
  def best_time; 0.002269 end

  def completed_on; '2015-01-13' end
  def ordinality; 6_267 end
  def percentile; 98.62 end

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

  def solve( n = 50, min = 3 )
    1 + fill( min, n, {} )
  end
end
