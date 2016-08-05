require 'projectEuler'

class Problem_0190
  def title; 'Maximising a weighted product' end
  def difficulty; 50 end

  # Let S_m = (x_1, x_2, ... , x_m) be the m-tuple of positive real numbers
  # with x_1 + x_2 + ... + x_m = m for which P_m = x_1 * x_2^2 * ... * x_m^m
  # is maximised.
  #
  # For example, it can be verified that [P_10] = 4112 ([ ] is the integer
  # part function).
  #
  # Find Σ[P_m] for 2 ≤ m ≤ 15.

  def solve( first = 2, last = 15 )
    # Use the Lagrangean method to maximize f(x, y, z, ...) subject to the
    # constraint that g(x, y, z, ...) = b. In our case,
    #
    #   f(x_1, x_2, x_3, ...) = x_1 · x_2^2 · x_3^3 · ... · x_m^m,
    #   g(x_1, x_2, x_3, ...) = x_1 + x_2 + x_3 + ... + x_m, and
    #   b = m
    #
    # Start with the simplest case, when m = 2 and f = x_1·x_2^2. First we
    # introduce a new variable, λ (the Lagrange multiplier), to set up the
    # Lagrangean. The Lagrange function appropriate to the problem statement
    # is:
    #
    #   L(x_1, x_2, λ) = f(x_1, x_2) + λ[b - g(x_1, x_2)]
    #                  = x_1·x_2^2 + 2λ - λ(2 - x_1 - x_2)
    #
    # Now set the partial derivatives equal to zero and solve for the x_n:
    #
    #   ∂L/∂x_1 = x_2^2 - λ = 0
    #   ∂L/∂x_2 = 2·x_1·x_2^2 - λ = 0  ==>  x_2^2 = 2·x_1·x_2^2
    #                                       x_2 = 2·x_1
    #   ∂L/∂λ = 2 - x_1 - x_2 = 0      ==>  2 = x_1 + 2·x_1
    #                                         = 3·x_1
    # So x_1 = 2/3 and x_2 = 4/3.
    #
    # Repeating this exercise for larger m gradually reveals a pattern in the
    # solutions generated in each case. It becomes clear that x_1 = m / t_m,
    # where t_m is the m-th triangle number [1, 3, 6, 10, 15, ...]. We also
    # see that x_2 = 2·x_1, x_3 = 3·x_1, and in general, x_k = k·x_1. Substi-
    # tuting the appropriate expression for each x_i, we get:
    #
    #   f = x_1 · (2·x_1)^2 · (3·x_1)^3 · ... · (m·x_1)^m
    #
    # We could factor out the scalars and combine exponents, but the product
    # is actually a hyperfactorial and grows enormous very quickly. Instead,
    # we'll reduce each term separately and use the very small exponentiated
    # factors to keep the scalars under control.
    sum = 0

    first.upto( last ) do |m|
      # x = m / t_m reduces to something rather simple.
      x = 2.0 / (m + 1)

      # Compute P_m and add its integer part to the total.
      sum += ((1..m).reduce( 1 ) {|acc, i| acc * (i*x)**i}).floor
    end

    sum
  end

  def solution; 'MzcxMDQ4Mjgx' end
  def best_time; 0.00006723 end
  def effort; 10 end

  def completed_on; '2016-08-05' end
  def ordinality; 2_927 end
  def population; 619_609 end

  def refs
    ['http://privatewww.essex.ac.uk/~wangt/Presession%20Math/Lecture%204.pdf',
     'http://oeis.org/A002109',
     'https://en.wikipedia.org/wiki/Level_set',
     'https://en.wikipedia.org/wiki/Hessian_matrix',
     'https://en.wikipedia.org/wiki/Second_partial_derivative_test']
  end
end
