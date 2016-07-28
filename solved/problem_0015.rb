require 'projectEuler'

class Problem_0015
  def title; 'Lattice paths' end
  def difficulty; 5 end

  # Starting in the top left corner of a 2 x 2 grid, there are 6 routes
  # (without backtracking) to the bottom right corner.
  #
  #     .....    ... .    ... .    . . .    . . .    . . .   
  #     . . |    . |..    . | .    |....    |.. .    | . .   
  #     . . v    . . V    . |.>    . . V    . |.>    |...>   
  #
  # How many routes are there through a 20 x 20 grid?

  def solve( n = 20 )
    # Working backward from the lower right point, it's clear that its two
    # neighbors have only one path to reach it.  Their other common neighbor,
    # however can reach it through either of them, so it has 1 + 1 = 2 paths
    # to the corner point.  Similarly, every point P has M paths to the lower
    # right, where M is the sum of paths available to P's neighbors closer to
    # that point.  Labelling each point with its count of available paths, we
    # see that the values form an inverted Pascal Triangle.
    #
    # Since Pascal's Triangle can be formed through binomial expansion, we
    # must simply calculate the appropriate coefficient to find the solution.
    # If a[i] are the coefficients of row n, then a[k] = nCk, or "n Choose k",
    # where nCk = n! / (k! * (n - k)!).
    (n << 1).fact / (n.fact * n.fact)
  end

  def solution; 'MTM3ODQ2NTI4ODIw' end
  def best_time; 0.00003386 end
  def effort; 20 end

  def completed_on; '2013-01-30' end
  def ordinality; 63_274 end
  def population; 276_908 end

  def refs
    ['https://oeis.org/A007318']
  end
end
