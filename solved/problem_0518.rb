require 'projectEuler'

class Problem_0518
  def title; 'Prime triples and geometric sequences' end
  def difficulty; 20 end

  # Let S(n) = Σ a+b+c over all triples (a,b,c) such that:
  #
  #   a, b, and c are prime numbers.
  #   a < b < c < n.
  #   a+1, b+1, and c+1 form a geometric sequence.
  #
  # For example, S(100) = 1035 with the following triples:
  #
  #   (2, 5, 11), (2, 11, 47), (5, 11, 23), (5, 17, 53), (7, 11, 17),
  #   (7, 23, 71), (11, 23, 47), (17, 23, 31), (17, 41, 97), (31, 47, 71),
  #   (71, 83, 97)
  #
  # Find S(10^8).

  def solve( n = 100_000_000 )
    # Since a + 1, b + 1, c + 1 form a geometric sequence, we know that for
    # some rational number k, c + 1 = k(b + 1) = (k^2)(a + 1). This means that
    # for some starting prime a, we need subsequent primes b and c such that
    # b = k(a + 1) - 1 and c = k^2(a + 1) - 1. From the problem statement, we
    # know c < n, which means k^2(a + 1) - 1 < n => k < √( n+1 / a+1 ).
    #
    # Since the sequence is geomtric, k must be a rational number of the form
    # u/v (with u > v since k > 1). Substituting, we get:
    #
    #   1 < k < √( n+1 / a+1 )  =>  v < u < v√( n+1 / a+1 )
    #
    # We can also infer that v^2 divides a + 1, since c = k^2(a + 1) - 1 is an
    # integer equal to (u^2(a + 1) / v^2) - 1. v^2 doesn't divide u^2 (or is
    # 1), so it must divide a + 1.
    #
    # Our strategy, then, is find the largest v for each prime p < n such that
    # v^2 | p + 1, find all possible u subject to the inequalities above, then
    # verify the corresponding triplet. We'll sieve our working primes and add
    # them to a hash, reducing the primality test to O(1).
    sum, primes, mults = 0, {}, {}
    n.prime_sieve.each {|p| primes[p] = p}

    # Finding the largest v such that v^2 | p + 1 is expensive, so we'll trade
    # space for time. Build a hash from multiples of square numbers. Every non-
    # square-free integer will map to the appropriate v.
    v, sq, delta = 2, 4, 5
    while v < Math.sqrt( n )
      sq.step( n, sq ) {|m| mults[m - 1] = v}
      v, sq, delta = v + 1, sq + delta, delta + 2
    end

    # For each prime < n, look up the v we just precomputed, then check the
    # triplets formed from corresponding u possibilities.
    primes.keys.each do |a|
      # If a + 1 is square-free, it was skipped by our precomputation and the
      # largest square that divides it is 1. The upper limit for u comes
      # directly from the inequality above.
      v = mults[a] || 1
      limit = (v * Math.sqrt( (n + 1) / (a + 1).to_f )).to_i

      # Run through all valid u/v ratios for the current prime.
      (v + 1).upto( limit ).each do |u|
        b, c = u*(a + 1)/v - 1, u*u*(a + 1)/(v*v) - 1

        # If all three sequence values are prime, add them to the sum.
        sum += a + b + c if primes[b] && primes[c]
      end
    end

    sum
  end

  def solution; 'MTAwMzE1NzM5MTg0Mzky' end
  def best_time; 57.20 end
  def effort; 20 end

  def completed_on; '2018-09-21' end
  def ordinality; 1_134 end
  def population; 782_863 end

  def refs; [] end
end
