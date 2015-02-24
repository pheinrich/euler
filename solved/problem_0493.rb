require 'projectEuler'

# 0.00005198s (2/23/15, #705)
class Problem_0493
  def title; 'Under The Rainbow' end

  # 70 colored balls are placed in an urn, 10 for each of the seven rainbow
  # colors.
  #
  # What is the expected number of distinct colors in 20 randomly picked
  # balls?
  #
  # Give your answer with nine digits after the decimal point (a.bcdefghij).

  def refs
    ["http://www.albany.edu/~mark/classes/367/e2s99sol.pdf",
     "http://en.wikipedia.org/wiki/Hypergeometric_distribution"]
  end

  def solution; 6.818741802 end
  def best_time; 0.00005198 end

  def completed_on; '2015-02-23' end
  def ordinality; 705 end
  def percentile; 99.9985 end

  def solve( colors = 7, count = 10, drawn = 20 )
    # If X = the number of colors drawn, we're looking for its expected value,
    # E(X). Instead, let Y = colors - X, the number of colors NOT drawn. Then
    # every color not drawn will increase Y by 1, so Y = Y1 + Y2 + ... + Y7,
    # where Yi = 1 if the ith color isn't drawn, 0 otherwise.
    #
    # This situation is described by the hypergeomtric distribution, so
    # E(Yi) = P(ith color not drawn) = (Ki k)(N-Ki n-k) / (N n) where:
    #
    #   N = total population size (total number of balls, colors*count)
    #   Ki = 'success' states, i.e. balls of color i (count)
    #   n = number of draws (drawn)
    #   k = number of successes, i.e. balls of color i drawn (0)
    #
    # So E(Yi) = (N-Ki n) / (N n), E(Y) = E(Y1) + E(Y2) + ... + E(Y7), and
    # E(X) = 7 - E(Y).
    total = colors * count
    expy = (total - count).choose( drawn ).to_f / total.choose( drawn )
    "%.9f" % [colors * (1 - expy)]
  end
end
