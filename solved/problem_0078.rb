require 'projectEuler'

# 49.05s (12/24/13, #7757)
class Problem_0078
  def title; 'Coin partitions' end
  def solution; 55_374 end

  # Let p(n) represent the number of different ways in which n coins can be
  # separated into piles. For example, five coins can separated into piles in
  # exactly seven different ways, so p(5)=7.
  #
  #         OOOOO
  #        OOOO   O
  #        OOO   OO
  #       OOO   O   O
  #       OO   OO   O
  #      OO   O   O   O
  #     O   O   O   O   O
  #
  # Find the least value of n for which p(n) is divisible by one million.

  def solve( n = 1_000_000 )
    # From observation, brute force.
    limit = (2.75 * n**0.75).floor
    limit.partition_sieve.find_index {|i| 0 == (i % n)}
  end
end
