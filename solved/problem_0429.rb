require 'projectEuler'

class Problem_0429
  def title; 'Sum of squares of unitary divisors' end
  def difficulty; 20 end

  # A unitary divisor d of a number n is a divisor of n that has the property
  # gcd(d, n/d) = 1. The unitary divisors of 4! = 24 are 1, 3, 8 and 24. The
  # sum of their squares is 1^2 + 3^2 + 8^2 + 24^2 = 650.
  #
  # Let S(n) represent the sum of the squares of the unitary divisors of n.
  # Thus S(4!)=650.
  #
  # Find S(100 000 000!) modulo 1 000 000 009.

  def legendre( n, p )
    # Returns the exponent of p in the prime factorization of n!.
    sum = 0
    power = p

    while power <= n do
      sum += n / power
      power *= p
    end

    sum
  end

  def solve( n = 100_000_000, m = 1_000_000_009 )
    primes = n.prime_sieve
    vp = []

    # Find the powers of all prime factors of n!.
    primes.each do |p|
      exp = legendre( n, p )
      vp << exp if 0 < exp
      break unless 0 < exp
    end

    # The Unitary Divisor Sigma computes the sum of unitary divisor powers.
    # For squared unitary divisors, it can be calculated from:
    #
    #   σ(x) = (1 + p^2α)(1 + q^2β) · ... · (1 +r^2γ)
    #
    # where p, q, ... r are the prime factors of x and α, β, ... γ are their
    # exponents in the prime factorization of x. Then it's just a matter of
    # computing the product above modulo m.
    prod = 1
    vp.each_with_index do |exp, i|
      prod *= 1 + primes[i].modular_power( exp << 1, m )
      prod %= m
    end

    prod
  end

  def solution; 'OTg3OTI4MjE=' end
  def best_time; 10.50 end
  def effort; 20 end

  def completed_on; '2018-09-06' end
  def ordinality; 1_927 end
  def population; 778_775 end

  def refs
    ['http://mathworld.wolfram.com/UnitaryDivisorFunction.html',
     'https://www.cut-the-knot.org/blue/LegendresTheorem.shtml',
     'https://oeis.org/A034676',
     'https://oeis.org/A077610']
  end
end
