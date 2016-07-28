require 'projectEuler'

class Problem_0003
  def title; 'Largest prime factor' end
  def difficulty; 5 end

  # The prime factors of 13195 are 5, 7, 13 and 29.
  #
  # What is the largest prime factor of the number 600851475143?

  def solve( n = 6_008_514_751_437 )
    n.prime_factors[-1]
  end

  def solution; 'Njc2Nzk=' end
  def best_time; 0.1092 end
  def effort; 0 end

  def completed_on; '2013-01-21' end
  def ordinality; 158_901 end
  def population; 274_675 end

  def refs; [] end
end
