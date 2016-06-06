require 'projectEuler'

# 0.0006421 (12/24/13, #14159)
class Problem_0076
  def title; 'Counting summations' end
  def difficulty; 10 end

  # It is possible to write five as a sum in exactly six different ways:
  #
  #    4 + 1
  #    3 + 2
  #    3 + 1 + 1
  #    2 + 2 + 1
  #    2 + 1 + 1 + 1
  #    1 + 1 + 1 + 1 + 1
  #
  # How many different ways can one hundred be written as a sum of at least
  # two positive integers?

  def solve( n = 100 )
    n.partition_sieve[-1] - 1
  end

  def solution; 190_569_291 end
  def best_time; 0.0002010 end
  def effort; 30 end

  def completed_on; '2013-12-24' end
  def ordinality; 14_159 end
  def population; 358_306 end

  def refs; [] end
end
