require 'projectEuler'

class Problem_0021
  def title; 'Amicable numbers' end
  def difficulty; 5 end

  # Let d(n) be defined as the sum of proper divisors of n (numbers less than
  # n which divide evenly into n).  If d(a) = b and d(b) = a, where a != b,
  # then a and b are an amicable pair and each of a and b are called amicable
  # numbers.
  #
  # For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22,
  # 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1,
  # 2, 4, 71 and 142; so d(284) = 220.
  #
  # Evaluate the sum of all the amicable numbers under 10000.

  def solve( n = 10_000 )
    (1..n).select {|i| i.amicable?}.reduce( :+ )
  end

  def solution; 'MzE2MjY=' end
  def best_time; 0.2043 end
  def effort; 0 end

  def completed_on; '2013-02-05' end
  def ordinality; 54_309 end
  def population; 278_397 end

  def refs
    ['https://oeis.org/A063990']
  end
end
