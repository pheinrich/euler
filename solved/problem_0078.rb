require 'projectEuler'

class Problem_0078
  def title; 'Coin partitions' end
  def difficulty; 30 end

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

  def solution; 'NTUzNzQ=' end
  def best_time; 40.22 end
  def effort; 30 end

  def completed_on; '2013-12-24' end
  def ordinality; 7_757 end
  def population; 358_306 end

  def refs
    ['https://en.wikipedia.org/wiki/Partition_problem']
  end
end
