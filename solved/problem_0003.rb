require 'projectEuler'

# 0.1960s (1/21/13, #~158901)
class Problem_0003
  def title; 'Largest prime factor' end

  # The prime factors of 13195 are 5, 7, 13 and 29.
  #
  # What is the largest prime factor of the number 600851475143?

  def refs; [] end
  def solution; 67_679 end
  def best_time; 0.1960 end

  def completed_on; '2013-01-21' end
  def ordinality; 158_901 end
  def percentile; 43.28 end

  def solve( n = 6_008_514_751_437 )
    n.prime_factors[-1]
  end
end
