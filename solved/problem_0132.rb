require 'projectEuler'

# 0.5559s (7/26/16, #4358)
class Problem_0132
  def title; 'Large repunit factors' end
  def difficulty; 45 end

  # A number consisting entirely of ones is called a repunit. We shall define
  # R(k) to be a repunit of length k.
  #
  # For example, R(10) = 1111111111 = 11×41×271×9091, and the sum of these
  # prime factors is 9414.
  #
  # Find the sum of the first forty prime factors of R(10^9).

  def solve( k = 1_000_000_000, n = 40 )
    # The R(k) can be expressed as (10^k - 1) / 9, which means that:
    #
    #   px = (10^k - 1) / 9 for some k, x
    #   (10^k - 1) / 9 % p = 0
    #   (10^k - 1) % 9p = 0
    #   [(10^k % 9p) - (1 % 9p)] % 9p = 0
    #   (10^k % 9p) - (1 % 9p) = 0
    #   10^k % 9p = 1 % 9p
    #   10^k % 9p = 1
    #
    # Therefore, p is a factor of R(k) if 10^k ≣ 1 (mod 9p). We can use
    # modular exponentiation to compute the remainder for successive prime
    # numbers until we've collected as many as necessary.
    factors = []
    max = k / 2_000

    # Be prepared to go back for a larger collection of primes, if we don't
    # grab enough at first.
    while factors.length < n && max < 1_000_000_000
      max <<= 1
      factors = max.prime_sieve.select {|p| 1 == 10.modular_power( k, 9*p )} 
    end

    factors[0...n].reduce( :+ )
  end

  def solution; 843_296 end
  def best_time; 0.5300 end
  def effort; 10 end

  def completed_on; '2016-07-26' end
  def ordinality; 4_358 end
  def population; 581_231 end

  def refs
    ["http://oeis.org/A002275"]
  end
end
