require 'projectEuler'

class Problem_0500
  def title; 'Problem 500!!!' end
  def difficulty; 15 end

  # The number of divisors of 120 is 16.
  # In fact 120 is the smallest number having 16 divisors.
  #
  # Find the smallest number with 2^500500 divisors.
  # Give your answer modulo 500500507.

  def solve( n = 500500, m = 500500507 )
    # Every integer N is a product of some set of prime number powers, as in
    # N = p^α·q^β· ... · r^γ. If N is equal to a single prime power N = p^α,
    # then it will have α + 1 factors: 1, p, ... , p^(α - 1), p^α. Of course,
    # every prime factor will contribute in the same way, so we can calculate
    # the total number of factors by multiplying (α + 1)(β + 1) ... (γ + 1).
    #
    # Ex: # of factors = 48
    #   48 = (α + 1)(β + 1)...(γ + 1)
    #      = 2*2*2*2*3  -->  2^2 * 3 * 5 * 7 * 11 = 4620
    #      = 2*2*2*6    -->  2^5 * 3 * 5 * 7 = 3360
    #      = 2*2*3*4    -->  2^3 * 3^2 * 5 * 7 = 2520  <===
    #      = 2*2*12     -->  2^11 * 3 * 5 = 30720
    #      = 2*3*8      -->  2^7 * 3^2 * 5 = 5760
    #      = 2*4*6      -->  2^5 * 3^3 * 5 = 4320
    #      = 2*24       -->  2^23 * 3 = 25165824
    #      = 3*4*4      -->  2^3 * 3^3 * 5^2 = 5400
    #      = 3*16       -->  2^15 * 3^2 = 294912
    #      = 4*12       -->  2^11 * 3^3 = 55296
    #      = 6*8        -->  2^7 * 3^5 = 31104
    #
    # The problem statement requires us to find some α, β, ... γ such that
    # (α + 1)(β + 1) ... (γ + 1) = 2^500500. That is, we must multiply enough
    # power-of-two terms for the sum of their exponents to total 500500.
    #
    # Ex: # of factors = 2^6
    #   2^6 = (α + 1)(β + 1)...(γ + 1)
    #       = 2^1 * 2^1 * 2^1 * 2^1 * 2^1 * 2^1  -->  2 * 3 * 5 * 7 * 11 * 13 = 30030
    #       = 2^2 * 2^1 * 2^1 * 2^1 * 2^1  -->  2^3 * 3 * 5 * 7 * 11 = 9240
    #       = 2^2 * 2^2 * 2^1 * 2^1  -->  2^3 * 3^3 * 5 * 7 = 7560  <===
    #       = 2^2 * 2^2 * 2^2  -->  2^3 * 3^3 * 5^3 = 27000
    #       = 2^3 * 2^1 * 2^1 * 2^1  -->  2^7 * 3 * 5 * 7 = 13440
    #       = 2^3 * 2^2 * 2^1  -->  2^7 * 3^3 * 5 = 17280
    #       ...
    #       = 2^6  -->  2^63 = 9223372036854775808
    #
    # How do we choose the exponents to minimize the resulting product? If we
    # assume every term has exponent 1 to start, we can then decide if in-
    # creasing the exponent of a lower term is better than including a higher
    # one. For example, we can see 2^3 * 3 * 5 * 7 * 11 > 2^3 * 3^3 * 5 * 7,
    # above; that is, increasing the exponent of 3 is better than including
    # 11.

    # The solution could potentially have n prime factors, although that is
    # unlikely. Generate at least that many, however, so we can check them.
    x = n
    x <<= 1 until x / Math.log( x ) > n
    primes = x.prime_sieve

    # To start, assume that every prime is a factor with an exponent of 1.
    # Also generate the first few powers of 2, minus 1, since those will be
    # the values available to us as we adjust the exponents.
    powers = primes.map {1}
    pow2m1 = (0..8).map {|i| (1 << i) - 1}

    head, tail = 0, n    
    while head < tail
      # We need to determine if increasing the exponent of the current prime
      # factor (and reducing that of the last factor) is better than keeping
      # both exponents as they are. Essentially, is p^x·q^y > p^(x+a)·q^(y-b)?
      # a and b depend on the magnitude of x and y.
      #
      # Dividing through both sides, we see we just need to check whether or
      # or not p^a < q^b, where a, b are the deltas between current/next and
      # current/previous powers of 2, respectively.
      a = pow2m1[1 + powers[head]] - pow2m1[powers[head]]
      b = pow2m1[powers[tail]] - pow2m1[powers[tail] - 1]

      while primes[head]**a < primes[tail]**b
        # As long as it will result in a smaller product, reduce the larger
        # factor's exponent and increase that of the smaller prime.
        powers[head] += 1
        powers[tail] -= 1

        # If the larger factor's contribution has been reduced to 1 (it has an
        # exponent of 0), shorten the list of factors to exclude it.
        tail -= 1 if 0 == powers[tail]
        
        # Recompute the exponents necessary for comparison. 
        a = pow2m1[1 + powers[head]] - pow2m1[powers[head]]
        b = pow2m1[powers[tail]] - pow2m1[powers[tail] - 1]
      end

      # Move to the next lowest prime, to see if we can optimize its exponent
      # as well.
      head += 1
    end

    # Combine all the prime factors with non-zero exponents to produce the
    # final result. Compute over a modulus, since the number is HUGE (the
    # product of just the first 8 terms has 73 digits and there are 500084
    # terms).
    (0...tail).reduce( 1 ) {|acc, i| (acc * primes[i]**pow2m1[powers[i]]) % m}
  end

  def solution; 'MzU0MDcyODE=' end
  def best_time; 0.6969 end
  def effort; 20 end

  def completed_on; '2016-08-19' end
  def ordinality; 1_816 end
  def population; 623_527 end

  def refs
    ['http://www.cut-the-knot.org/blue/NumberOfFactors.shtml',
     'http://math.stackexchange.com/a/491624']
  end
end
