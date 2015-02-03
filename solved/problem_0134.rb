require 'projectEuler'

# 0.6329s (1/20/15, #4108)
class Problem_0134
  def title; 'Prime pair connection' end

  # Consider the consecutive primes p1 = 19 and p2 = 23. It can be verified
  # that 1219 is the smallest number such that the last digits are formed by
  # p1 whilst also being divisible by p2.
  #
  # In fact, with the exception of p1 = 3 and p2 = 5, for every pair of con-
  # secutive primes, p2 > p1, there exist values of n for which the last
  # digits are formed by p1 and n is divisible by p2. Let S be the smallest of
  # these values of n.
  #
  # Find ∑ S for every pair of consecutive primes with 5 ≤ p1 ≤ 1000000.

  def refs; [] end
  def solution; 18_613_426_663_617_118 end
  def best_time; 0.6329 end

  def completed_on; '2015-01-20' end
  def ordinality; 4_108 end
  def percentile; 99.10 end

  def solve( min = 5, max = 1_000_000 )
    # Extend the range of our prime sieve slightly to ensure we include the
    # prime just on the other side of our upper bound.
    p = (max + 10*Math.log10( max )).to_i.prime_sieve

    # Find the indices of the primes that will bound our calculation.
    first = p.find_index( min )
    last = p.find_index {|n| n > max}

    # Use the Chinese Remainder theorem on each pair of primes, since we can
    # set up a system of congruences for each.
    (first...last).inject( 0 ) do |acc, i|
      ord = 1 + Math.log10( p[i] ).to_i
      acc + [[p[i + 1], 0], [10**ord, p[i]]].chinese_rem
    end
  end
end
