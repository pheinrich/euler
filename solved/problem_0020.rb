require 'projectEuler'

class Problem_0020
  def title; 'Factorial digit sum' end
  def difficulty; 5 end

  # n! means n x (n - 1) x ... x 3 x 2 x 1
  #
  # For example, 10! = 10 x 9 x ... x 3 x 2 x 1 = 3628800, and the sum of the
  # digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
  #
  # Find the sum of the digits in the number 100!

  def solve( n = 100 )
    n.fact.sum_digits
  end

  def solution; 'NjQ4' end
  def best_time; 0.0001712 end
  def effort; 0 end

  def completed_on; '2013-02-01' end
  def ordinality; 76_316 end
  def population; 294_374 end

  def refs
    ['https://oeis.org/A061602']
  end
end
