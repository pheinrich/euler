require 'projectEuler'

# 
class Problem_0549
  def title; 'Divisibility of factorials' end
  def difficulty; 10 end

  # The smallest number m such that 10 divides m! is m=5.
  # The smallest number m such that 25 divides m! is m=10.
  #
  # Let s(n) be the smallest number m such that n divides m!.
  # So s(10)=5 and s(25)=10.
  # Let S(n) be ∑s(i) for 2 ≤ i ≤ n.
  # S(100)=2012.
  #
  # Find S(10^8).

  def solve( n = 100_000_000 )
    # To clarify, s(n) identifies the smallest factorial divisible by n.
    #
    #    n    1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
    #   s(n)  0  2  3  4  5  3  7  4  6  5 11  4 13  7  5  6 17  6 19  5
    #
    # From this it's clear that s(n) = n when n is prime. 
  end

  def solution; end
  def best_time; end
  def effort; end

  def completed_on; '2013-01-21' end
  def ordinality; end
  def population; end

  def refs
    ["http://blog.janmr.com/2010/10/prime-factors-of-factorial-numbers.html",
     "http://www.cut-the-knot.org/blue/LegendresTheorem.shtml"]
  end
end
