require 'projectEuler'

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
    return 0 if 2 == n || 5 == n

    x, k = 1, 1
    until 0 == x
      x = (10*x + 1) % n
      k += 1
    end

    k
  end

  def solve( n = 100_000 )
    # OEIS.org shows that the sequence described above, starting with [11, 17,
    # 41, 73] (A178070), contains primes such that the multiplicative order of
    # 10 (mod p) takes the form 2^i * 5^j, with i,j >= 0. The multiplicative
    # order is the smallest power k such that 10^k ≡ 1 (mod p), which is the
    # same as saying 10^k % p = 1.
    #
    # We can prepare a table of valid multiplicative order values; we just
    # need to store all 2^i * 5^j combinations less than the 100k from the
    # problem statement. The max i, j are easily derived:
    #
    #   2^i < n            5^j < n
    #   ln 2^i < ln n      ln 5^j < ln n
    #   i(ln 2) < ln n     j(ln 5) < ln n
    #   i < ln n / ln 2    j < ln n / ln 5
    #
    # Once A(p) is computed for each potential prime, we just need to compare
    # it to the table entries to determine if it's valid.
    p = n.prime_sieve
    log = Math.log2( n )
    orders = {}

    # Build the table of valid multiplicative order values. We'll just use the
    # larger of the i, j limits, taking advantage of the fact that log2 2 = 1.
    # The table will (harmlessly) have entries for p > n, but still be small. 
    (0..log).each do |i|
      (0..log).each do |j|
        orders[2**i * 5**j] = true
      end
    end

    # Drop all the primes whose A(n) is not 2^i * 5^j and sum.
    p.reject! {|q| orders.has_key?( aofn( q ) )}
    p.reduce( :+ )
  end

  def solution; 'NDUzNjQ3NzA1' end
  def best_time; 15.66 end
  def effort; 15 end

  def completed_on; '2016-07-27' end
  def ordinality; 3_757 end
  def population; 581_299 end

  def refs
    ['http://oeis.org/A178070']
  end
end
