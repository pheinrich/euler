require 'projectEuler'

# 0.00001192s, (1/9/15, #8868)
class Problem_0100
  def title; 'Arranged probability' end
  def solution; 756_872_327_473 end

  # If a box contains twenty-one coloured discs, composed of fifteen blue
  # discs and six red discs, and two discs were taken at random, it can be
  # seen that the probability of taking two blue discs,
  #
  #      P(BB) = (15/21)×(14/20) = 1/2.
  #
  # The next such arrangement, for which there is exactly 50% chance of taking
  # two blue discs at random, is a box containing eighty-five blue discs and
  # thirty-five red discs.
  #
  # By finding the first arrangement to contain over 10^12 = 1,000,000,000,000
  # discs in total, determine the number of blue discs that the box would
  # contain.

  def refs
    [ "http://www.alpertron.com.ar/METHODS.HTM",
      "http://www.alpertron.com.ar/QUAD.HTM" ]
  end

  def solution; 756_872_327_473 end
  def best_time; 0.00001001 end

  def completed_on; '2015-01-09' end
  def ordinality; 8_868 end
  def population; 362_277 end

  def solve( n = 1_000_000_000_000 )
    # We are looking for x and y that satisfy the relationship:
    #
    #           x(x - 1)
    #      ------------------ = 1/2 
    #      (x + y)(x + y - 1)
    #
    # Rearranging terms, this is equivalent to x^2 - 2xy - y^2 - x + y = 0,
    # a standard quadratic Diophantine equation with A = 1, B = -2, C = -1,
    # D = -1, E = 1, and F = 0. The general solution to this specific
    # Diophantine equation (yielding all positive x and y) takes the form:
    #
    #      X[0] = 1,     X[n + 1] = P*X[n] + Q*Y[n] + K 
    #      Y[0] = 0,     Y[n + 1] = R*X[n] + S*Y[n] + L
    #
    # where P = 5, Q = 2, K = -2, R = 2, S = 1, and L = -1.
    x, y = 1, 0
    while x + y < n
      x, y = 5*x + 2*y - 2, 2*x + y - 1
    end

    x
  end
end
