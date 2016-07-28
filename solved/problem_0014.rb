require 'projectEuler'

class Problem_0014
  def title; 'Longest Collatz sequence' end
  def difficulty; 5 end

  # The following iterative sequence is defined for the set of positive
  # integers:
  #
  #     n -> n/2 (n is even)
  #     n -> 3n + 1 (n is odd)
  #
  # Using the rule above and starting with 13, we generate the following
  # sequence:
  #
  #         13 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1
  #
  # It can be seen that this sequence (starting at 13 and finishing at 1)
  # contains 10 terms. Although it has not been proved yet (Collatz Problem),
  # it is thought that all starting numbers finish at 1.
  #
  # Which starting number, under one million, produces the longest chain?
  #
  # NOTE: Once the chain starts the terms are allowed to go above one million.

  def solve( n = 1_000_000 )
    m = 1
    max = 1

    (1...n).each do |i|
      l = i.collatz_length
      if l > max
        m = i
        max = l
      end
    end

    m
  end

  def solution; 'ODM3Nzk5' end
  def best_time; 10.93 end
  def effort; 0 end

  def completed_on; '2013-01-27' end
  def ordinality; 73_172 end
  def population; 276_164 end

  def refs
    ['https://en.wikipedia.org/wiki/Collatz_conjecture',
     'https://oeis.org/A006577']
  end
end
