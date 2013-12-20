require 'projectEuler'

# Quadratic primes
class Problem_0027
  # Euler published the remarkable quadratic formula:
  #
  #     n^2 + n + 41
  #
  # It turns out that the formula will produce 40 primes for the consecutive
  # values n = 0 to 39. However, when n = 40, 40^2 + 40 + 41 = 40(40 + 1) + 41
  # is divisible by 41, and certainly when n = 41, 41^2 + 41 + 41 is clearly
  # divisible by 41.
  #
  # Using computers, the incredible formula  n^2 - 79n + 1601 was discovered,
  # which produces 80 primes for the consecutive values n = 0 to 79. The
  # product of the coefficients, -79 and 1601, is -126479.
  #
  # Considering quadratics of the form:
  #
  #     n^2 + an + b, where |a| < 1000 and |b| < 1000
  #
  #     where |n| is the modulus/absolute value of n
  #     e.g. |11| = 11 and |-4| = 4
  #
  # Find the product of the coefficients, a and b, for the quadratic
  # expression that produces the maximum number of primes for consecutive
  # values of n, starting with n = 0.

  P = 1000.prime_sieve

  def self.solve( u, v )
    max, i, j = 0, 0, 0

    # Brute force, assuming a, b are prime.  Valid assumption?
    for a in P
      break if a >= u

      for b in P
        break if b >= v

        n = 0
        while (n*n + a*n + b).prime?
          n += 1
        end
        max, i, j = n, a, b if n > max

        n = 0
        while (n*n + a*n - b).prime?
          n += 1
        end
        max, i, j = n, a, -b if n > max

        n = 0
        while (n*n - a*n + b).prime?
          n += 1
        end
        max, i, j = n, -a, b if n > max

        n = 0
        while (n*n - a*n - b).prime?
          n += 1
        end
        max, i, j = n, -a, -b if n > max
      end
    end

    puts "%d = %d x %d, length %d" % [i*j, i, j, max]
  end
end

ProjectEuler.time do
  # -59231 = -61 x 971, length 71 (0.4720s)
  Problem_0027.solve( 1000, 1000 )
end
