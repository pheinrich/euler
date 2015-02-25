require 'projectEuler'

# 0.0005360.s (1/27/15, #4851)
class Problem_0110
  def title; 'Diophantine reciprocals II' end

  # In the following equation x, y, and n are positive integers.
  #
  #      1   1   1
  #      - + - = -
  #      x   y   n
  #
  # It can be verified that when n = 1260 there are 113 distinct solutions and
  # this is the least value of n for which the total number of distinct sol-
  # utions exceeds one hundred.
  #
  # What is the least value of n for which the number of distinct solutions
  # exceeds four million?
  #
  # NOTE: This problem is a much more difficult version of Problem 108 and as
  # it is well beyond the limitations of a brute force approach it requires a
  # clever implementation.

  P = 1000.prime_sieve

  def refs; [] end
  def solution; 9_350_130_049_860_600 end
  def best_time; 0.0005360 end

  def completed_on; '2015-01-27' end
  def ordinality; 4_851 end
  def population; 457_323 end

  def limit( root, max )
    # Starting at the root provided, step forward until we find one with
    # prime factors less than some maximum value.
    root += 1 while root.prime_factors.find {|f| max < f}

    # Expand the prime factor array to describe root*root, then reverse the
    # order and scale by half. The number of terms items in the array is im-
    # portant, since it defines how many primes to include, but by halving
    # the exponents we can compute the square root directly.
    pf = root.prime_factors * 2
    pf = pf.sort.reverse.map {|f| (f/2.0 - 0.5).round}

    pf.each_with_index.reduce( 1 ) {|acc, (e, i)| acc * P[i]**e}
  end

  def solve( sols = 4_000_000 )
    # Similar (perhaps more general) approach as in problem 108, except that
    # look for square numbers that don't have any "high-value" prime factors.
    r = Math.sqrt( (sols - 1) << 1 ).ceil
    lim = limit( r, P[2] )
    min, i = lim + 1, 3

    # We don't know exactly what constitutes a high-value prime factor, just
    # that we don't want the resulting exponents to overpower the answer.
    while lim <= min
      # Limit the max prime to try. Stop when we start to climb away from the
      # minimum result.
      min, lim = lim, limit( r, P[i] )
      i += 1    
    end

    min
  end
end
