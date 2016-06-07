require 'projectEuler'

# 
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
  # Surprisingly A_F(1/2)  =  (1/2).1 + (1/2)2.1 + (1/2)3.2
  #                                            + (1/2)4.3 + (1/2)5.5 + ...
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
  end

  def solution; end
  def best_time; end
  def effort; end

  def completed_on; '2013-01-21' end
  def ordinality; end
  def population; end

  def refs; [] end
end
