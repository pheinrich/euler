require 'projectEuler'

# 0.0001271s (1/6/14, #4488)
class Problem_0243
  def title; 'Resilience' end
  def difficulty; 35 end

  # A positive fraction whose numerator is less than its denominator is called
  # a proper fraction.  For any denominator, d, there will be d−1 proper
  # fractions; for example, with d = 12:
  #
  #     1/12, 2/12, 3/12, 4/12, 5/12, 6/12, 7/12, 8/12, 9/12, 10/12, 11/12.
  #
  # We shall call a fraction that cannot be cancelled down a resilient
  # fraction.  Furthermore we shall define the resilience of a denominator,
  # R(d), to be the ratio of its proper fractions that are resilient; for
  # example, R(12) = 4/11.
  #
  # In fact, d=12 is the smallest denominator having a resilience R(d) < 4/10.
  #
  # Find the smallest denominator d, having a resilience R(d) < 15499 / 94744.

  def solve( numer = 15_499, denom = 94_744 )
    # R(d) is simply φ(d)/(d - 1).  Since φ(d) = d·∏[p|d] (1 - 1/p), that
    # means R(d) ≈ ∏[p|d] (1 - 1/p) for large d, as d/(d - 1) -> 1.
    primes = 100.prime_sieve
    prod, resilience = 1, 1.0 * numer / denom

    # We need to find a combination of primes such that this n-ary product is
    # less than numer/denom.
    i = 0
    until prod < resilience
      prod *= 1 - 1.0 / primes[i]
      i += 1
    end

    # The first i primes divide d, but that d is not necessarily the smallest
    # possible value.  Back up one prime value and start testing multiples of
    # the corresponding (lesser) d.  It will have the same n-ary product.
    # Note that φ(d) = d·prod.
    d = s = primes[0...i].inject( :* )
    d += s until (d * prod) / (d - 1.0) < resilience

    d
  end

  def solution; 892_371_480 end
  def best_time; 0.00008440 end
  def effort; 45 end
  
  def completed_on; '2014-01-06' end
  def ordinality; 4_488 end
  def population; 361_532 end

  def refs; [] end
end
