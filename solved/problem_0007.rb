require 'projectEuler'

# 0.1604s (1/24/13, #~129002)
class Problem_0007
  def title; '10001st prime' end

  # By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
  # that the 6th prime is 13.
  #
  # What is the 10001st prime number?

  def refs; [] end
  def solution; 104_743 end
  def best_time; 0.09079 end

  def completed_on; '2013-01-24' end
  def ordinality; 129_002 end
  def population; 275_419 end

  def solve( n = 10_001 )
    p, i = 2, 3

    while 1 < n
      p, n = i, n - 1 if i.prime?
      i += 2
    end

    p
  end
end
