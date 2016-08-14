require 'projectEuler'

class Problem_0347
  def title; 'Largest integer divisible by two primes' end
  def difficulty; 15 end

  # The largest integer ≤ 100 that is only divisible by both the primes 2 and
  # 3 is 96, as 96=32*3=2^5*3. For two distinct primes p and q let M(p,q,N) be
  # the largest positive integer ≤N only divisible by both p and q and
  # M(p,q,N)=0 if such a positive integer does not exist.
  #
  # E.g. M(2,3,100)=96.
  # M(3,5,100)=75 and not 90 because 90 is divisible by 2, 3 and 5.
  # Also M(2,73,100)=0 because there does not exist a positive integer ≤ 100
  # that is divisible by both 2 and 73.
  #
  # Let S(N) be the sum of all distinct M(p,q,N). S(100)=2262.
  #
  # Find S(10 000 000).

  def m( u, lgu, v, lgv, limit )
    # Seems like there should be a simple way to maximize this function using
    # basic calculus, but I couldn't get the derivatives to work for me. Still
    # not sure what I was doing wrong.
    max = 0

    # Just try every combination of exponents, up to the log limit for each
    # prime, keeping track of the largest value.
    a = u
    lgu.times do
      b = v
      lgv.times do
        n = a * b
        max = [max, n].max unless n > limit
        b *= v
      end
      a *= u
    end

    max
  end

  def solve( n = 10_000_000 )
    primes = n.prime_sieve
    found = {}

    root = Math.sqrt( n ).floor
    lgn = Math.log( n )

    u = 0
    until primes[u] > root
      lgu = (lgn / Math.log( primes[u] )).floor
      v = u + 1

      until primes[u] * primes[v] > n
        lgv = (lgn / Math.log( primes[v] )).floor

        found[m( primes[u], lgu, primes[v], lgv, n )] = true
        v += 1
      end
      u += 1
    end

    found.keys.reduce( :+ )
  end

  def solution; 'MTExMDk4MDAyMDQwNTI=' end
  def best_time; 8.009 end
  def effort; 20 end

  def completed_on; '2016-08-13' end
  def ordinality; 2_459 end
  def population; 621_990 end

  def refs; [] end
end
