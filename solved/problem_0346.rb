require 'projectEuler'

class Problem_0346
  def title; 'Strong Repunits' end
  def difficulty; 15 end

  # The number 7 is special, because 7 is 111 written in base 2, and 11
  # written in base 6 (i.e. 7_10 = 11_6 = 111_2). In other words, 7 is a
  # repunit in at least two bases b > 1.
  #
  # We shall call a positive integer with this property a strong repunit. It
  # can be verified that there are 8 strong repunits below 50: {1, 7, 13, 15,
  # 21, 31, 40, 43}. Furthermore, the sum of all strong repunits below 1000
  # equals 15864.
  #
  # Find the sum of all strong repunits below 10^12.

  def solve( n = 1_000_000_000_000 )
    # Note that a repunit in any base b is simply the sum of b's powers (as
    # many as there are digits in the repunit), so we can generate progressive
    # strong repunits in base b by adding higher and higher powers of b. Once
    # the result passes the upper limit n, we know we've found all the rep-
    # for that base.
    #
    # We don't need to keep track of the repunits we find (to make sure the
    # number is a repunit in more than one base), because every number n is
    # already a repunit in one base, n - 1. If, for each base, we skip this
    # first positive, we know that any subsequent match will automatically
    # satisfy the criteria in the problem statement.
    #
    # Finally, we need to account for 1, which is a repunit in every base (we
    # don't bother trying to uncover it programmatically). Similarly, we need
    # to avoid double-counting 31 and 8191, the only two numbers representable
    # as repunits with 3 or more digits in more than one base, according to
    # the Goormaghtigh Conjecture.
    total = 1
    sum = 7
    b = 2

    while sum < n
      # Add progressively larger powers of the current base, b.
      while sum < n
        total += sum
        sum = sum * b + 1
      end

      # Advance the base until the first 3-digit repunit formed with it is
      # larger than our upper bound.
      b += 1
      sum = b*b + b + 1
    end

    # Adjust for the two special values described by Goormaghtigh.
    [31, 8191].each {|i| total -= i if i < n}
    total
  end

  def solution; '336108797689259276' end
  def best_time; 0.1034 end
  def effort; 15 end

  def completed_on; '2016-08-12' end
  def ordinality; 2_294 end
  def population; 621_773 end

  def refs
    ['https://en.wikipedia.org/wiki/Repunit',
     'https://en.wikipedia.org/wiki/Goormaghtigh_conjecture',
     'http://oeis.org/A053696']
  end
end
