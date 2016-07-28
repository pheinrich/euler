require 'projectEuler'

class Problem_0123
  def title; 'Prime square remainders' end
  def difficulty; 30 end

  # Let p[n] be the nth prime: 2, 3, 5, 7, 11, ..., and let r be the remainder
  # when (p[n]−1)^n + (p[n]+1)^n is divided by p[n]^2.
  #
  # For example, when n = 3, p[3] = 5, and 4^3 + 6^3 = 280 ≡ 5 mod 25.
  #
  # The least value of n for which the remainder first exceeds 10^9 is 7037.
  #
  # Find the least value of n for which the remainder first exceeds 10^10.

  def get_n_primes( n )
    lnn = Math.log( n )
    est = n*(Math.log( n*lnn ) - 1) + n*(Math.log(lnn) - 2)/lnn + n*(Math.log(lnn)**2)/(lnn*lnn)
    est.to_i.prime_sieve 
  end

  def solve( limit = 10_000_000_000 )
    # Find the upper bound for n in the expression 2·n·p[n] > limit. From the
    # Prime Number Theorem, we know that p[n] < n·(ln n + ln ln n), so that
    # means n^2·(ln n + ln ln n) > limit/2. See Problem 120 for more info on
    # the origin of the derivation of r = 2·n·p[n].
    func = lambda {|n| limit > n*n * (Math.log( n ) + Math.log( Math.log( n )))}
    est = ProjectEuler.bsearch( 0, limit / 2, func )
 
    # Use the upper bound on n to get at least that many prime numbers.
    p = get_n_primes( est )

    # Zero in on the n that satisfies 2·n·p[n] > limit. Return excess 1 since
    # our array of primes is 0-based but the problem starts counting them at
    # index 1.
    1 + ProjectEuler.bsearch( 0, est, lambda {|n| limit > 2*n*p[n-1]})
  end

  def solution; 'MjEwMzU=' end
  def best_time; 0.01991 end
  def effort; 30 end
  
  def completed_on; '2015-01-17' end
  def ordinality; 6_988 end
  def population; 482_665 end
  
  def refs
    ['http://en.wikipedia.org/wiki/Prime-counting_function#Inequalities']
  end
end
