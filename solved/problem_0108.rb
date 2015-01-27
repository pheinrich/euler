require 'projectEuler'

# 0.00008321s (1/27/15, #7736)
class Problem_0108
  def title; 'Diophantine reciprocals I' end
  def solution; 180_180 end

  # In the following equation x, y, and n are positive integers.
  #
  #      1   1   1
  #      - + - = -
  #      x   y   n
  #
  # For n = 4 there are exactly three distinct solutions:
  #
  #      1    1   1
  #      - + -- = -
  #      5   20   4
  #
  #      1    1   1
  #      - + -- = -
  #      6   12   4
  #
  #      1    1   1
  #      - +  - = -
  #      8    8   4
  #
  # What is the least value of n for which the number of distinct solutions
  # exceeds one-thousand?
  #
  # NOTE: This problem is an easier version of Problem 110; it is strongly
  # advised that you solve this one first.

  def solve( min = 1_000 )
    #        1        1        1
    #   (xyn)- + (xyn)- = (xyn)-  =>  ny + nx = xy  =>  xy - ny = nx 
    #        x        y        n
    #                            nx             nx - n^2 + n^2
    #   y(x - n) = nx  =>  y = ------  =>  y = ----------------  =>
    #                          x - n                x - n
    #        (x - n)n + n^2                 n^2
    #   y = ----------------  =>  y = n + -------
    #            x - n                     x - n
    #
    # So it's clear that x - n | n^2 and x - n > 0, which means x > n. If we
    # set k = x - n, then x = n + k and y = n + n^2 / k, which means there is
    # a solution for every k > 0 that divides n^2. That is, the number of
    # solutions is given by the number of positive divisors of n^2. Half of
    # these solutions will be duplicates, however, since factors are paired
    # and transposing them in the equations for x and y above generate the
    # same result.
    #
    # Note that square numbers have one unpaired factor, their square root.
    # n^2 is obviously a square number, so we are looking for an n where
    # [(n^2).factors.count / 2] + 1 > 1000 ==> (n^2).factors.count > 1998.
    #
    # To count the number of factors of a number, note that if N = p^α (that
    # is, N is a power of a prime), then N has α + 1 factors:
    #
    #   1, p, ..., p^(α-1), p^α
    #
    # If N = (p^α)(p^β)...(p^γ) (i.e. the product of prime powers), each prime
    # factor contributes factors similarly, for a total factor count of:
    #
    #   (α + 1)(β + 1)...(γ + 1)
    #
    # So we need (α + 1)(β + 1)...(γ + 1) > 1998. Since N = (p^α)(p^β)...(p^γ)
    # = n^2 is a square number, we need the smallest square number > 1998.
    min = Math.sqrt( (min - 1) << 1 ).ceil**2
    pf = min.prime_factors.reverse

    # The prime factors of min represent α, β, ..., γ (excess 1). Minimize the
    # N by substituting the first (lowest) primes into the equation above. 
    p = 100.prime_sieve
    n2 = pf.each_with_index.reduce( 1 ) {|acc, (e, i)| acc * p[i]**(e - 1)}

    # Now that we've found n^2, return the desired n.
    Math.sqrt( n2 ).to_i
  end

  def refs
    ['http://bit.ly/1Eo6u1v',
     'http://www.cut-the-knot.org/blue/NumberOfFactors.shtml']
  end
end
