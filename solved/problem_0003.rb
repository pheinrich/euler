require 'projectEuler'

class Problem_0003
  def title; 'Largest prime factor' end
  def difficulty; 5 end

  # The prime factors of 13195 are 5, 7, 13 and 29.
  #
  # What is the largest prime factor of the number 600851475143?

  def solve( n = 600_851_475_143 )
    n.prime_factors[-1]
  end

  def solution; 'Njg1Nw==' end
  def best_time; 0.02980 end
  def effort; 0 end

  def completed_on; '2013-01-21' end
  def ordinality; 158_901 end
  def population; 291_477 end

  def refs; [] end
end
