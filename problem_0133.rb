require 'projectEuler'

# 
class Problem_0133
  def title; 'Repunit nonfactors' end
  def difficulty; 50 end

  # A number consisting entirely of ones is called a repunit. We shall define
  # R(k) to be a repunit of length k; for example, R(6) = 111111.
  #
  # Let us consider repunits of the form R(10^n).
  #
  # Although R(10), R(100), or R(1000) are not divisible by 17, R(10000) is
  # divisible by 17. Yet there is no value of n for which R(10^n) will divide
  # by 19. In fact, it is remarkable that 11, 17, 41, and 73 are the only four
  # primes below one-hundred that can be a factor of R(10^n).
  #
  # Find the sum of all the primes below one-hundred thousand that will never
  # be a factor of R(10^n).

  def aofn( n )
    return 0 if 0 == n % 2 || 0 == n % 5

    m, n = 1, 9*n
    m += 1 while 1 != 10.modular_power( m, n )
    m
  end

  def solve( n = 100_000 )
    # OEIS.org shows that the sequence described above, starting with [11, 17,
    # 41, 73] (A178070), contains primes such that the multiplicative order of
    # 10 (mod p) takes the form 2^i * 5^j, with i,j >= 0. The multiplicative
    # order is the smallest power k such that 10^k ≣ 1 (mod p), which is the
    # same as saying 10^k % p = 1.
    p = n.prime_sieve
  end

  def solution; end
  def best_time; end
  def effort; end

  def completed_on; '2013-01-21' end
  def ordinality; end
  def population; end

  def refs
    ["http://oeis.org/A178070"]
  end
end
