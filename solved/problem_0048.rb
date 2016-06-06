require 'projectEuler'

# 0.8499s (1/25/13, #~50546)
class Problem_0048
  def title; 'Self powers' end
  def difficulty; 5 end

  # The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.
  #
  # Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.

  def solve( n = 1_000, d = 10 )
    m = 10**d
    ((1..n).inject {|s, x| s + x.modular_power( x, m )}.to_s[-d, d]).to_i
  end

  def solution; 9_110_846_700 end
  def best_time; 0.005943 end
  def effort; 0 end

  def completed_on; '2013-01-25' end
  def ordinality; 50_546 end
  def population; 275_668 end

  def refs; [] end
end
