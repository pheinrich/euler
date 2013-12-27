require 'projectEuler'

# 0.0006421 (#14159)
class Problem_0076
  def title; 'Counting summations' end
  def solution; 190_569_291 end

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
end
