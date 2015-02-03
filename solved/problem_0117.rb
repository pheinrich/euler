require 'projectEuler'

# 0.0006001s (1/16/15, #6404)
class Problem_0117
  def title; 'Red, green, and blue tiles' end

  # Using a combination of black square tiles and oblong tiles chosen from:
  # red tiles measuring two units, green tiles measuring three units, and blue
  # tiles measuring four units, it is possible to tile a row measuring five
  # units in length in exactly fifteen different ways (see problem_0117.png).
  #
  # How many ways can a row measuring fifty units in length be tiled?
  #
  # NOTE: This is related to Problem 116.

  def refs; [] end
  def solution; 100_808_458_960_497 end
  def best_time; 0.0006001 end

  def completed_on; '2015-01-16' end
  def ordinality; 6_404 end
  def percentile; 98.59 end

  def fill( lens, row, memo )
    return memo[row] if memo[row]

    total = 0
    for l in lens
      next if l > row
      total += row - l + 1

      (row - l).downto( 1 ) do |sub|
        total += fill( lens, sub, memo )
      end
    end

    memo[row] = total
  end

  def solve( n = 50, lens = [2, 3, 4] )
    1 + fill( lens, n, {} )
  end
end
