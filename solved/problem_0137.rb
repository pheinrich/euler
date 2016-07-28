require 'projectEuler'

class Problem_0137
  def title; 'Fibonacci golden nuggets' end
  def difficulty; 50 end

  # Consider the infinite polynomial series A_F(x) = x·F_1 + x^2·F_2 + x^3·F_3
  # + ..., where F_k is the kth term in the Fibonacci sequence: 1, 1, 2, 3, 5,
  # 8, ... ; that is, F_k = F_(k−1) + F_(k−2), F_1 = 1 and F_2 = 1.
  #
  # For this problem we shall be interested in values of x for which A_F(x) is
  # a positive integer.
  #
  # Surprisingly A_F(1/2)  =  (1/2)·1 + (1/2)^2·1 + (1/2)^3·2
  #                                          + (1/2)^4·3 + (1/2)^5·5 + ...
  #                        =  1/2 + 1/4 + 2/8 + 3/16 + 5/32 + ...
  #                        =  2
  #
  # The corresponding values of x for the first five natural numbers are shown
  # below.
  #
  #        x     A_F(x)
  #      √2−1     1
  #      1/2      2
  #   (√13−2)/3   3
  #   (√89−5)/8   4
  #   (√34−3)/5   5
  #
  # We shall call A_F(x) a golden nugget if x is rational, because they become
  # increasingly rarer; for example, the 10th golden nugget is 74049690.
  #
  # Find the 15th golden nugget.

  def solve( n = 15 )
    # It happens that the infinite sum above has a closed form:
    #                                              ∞                x
    #   A_F(x) = x·F_1 + x^2·F_2 + x^3·F_3 + ... = ∑ x^k·F_k = -----------
    #                                             k=1          1 - x - x^2
    # Rearranging terms, we have:
    #
    #   A_F(x)x^2 + (A_F(x) + 1)x - A_F(x) = 0
    #
    # Which we can solve using the ordinary quadratic formula. For clarity,
    # substitute y = A_F(x):
    #
    #   x = [-(y + 1) ± √(5y^2 + 2y + 1)] / 2y
    #
    # The problem requires us to find integer values of y that lead exclusive-
    # ly to rational x values. The only time the expression above will NOT be
    # rational is when the radical is irrational. To guarantee a rational
    # radical, the radicand 5y^2 + 2y + 1 must be a square number. Using this
    # constraint to generate the first 10 terms (taking about 15 seconds)
    # leads directly to A081018, which may be generated by the simple closed
    # form below.
    n <<= 1
    n.fib * (n + 1).fib
  end

  def solution; 'MTEyMDE0OTY1ODc2MA==' end
  def best_time; 0.00002003 end
  def effort; 20 end

  def completed_on; '2016-07-13' end
  def ordinality; 3_648 end
  def population; 613_505 end

  def refs
    ['http://math.stackexchange.com/a/114809',
     'http://functions.wolfram.com/IntegerFunctions/Fibonacci/23/02/',
     'http://oeis.org/A081018']
  end
end
