require 'projectEuler'

class Problem_0108
  def title; 'Diophantine reciprocals I' end
  def difficulty; 30 end

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

  P = 100.prime_sieve

  def solve( sols = 1_000 )
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
    r = Math.sqrt( (sols - 1) << 1 ).ceil
    pf = r.prime_factors * 2
    pf = pf.sort.reverse.map {|f| (f/2.0 - 0.5).round}

    # The prime factors of min represent α, β, ..., γ (excess 1). Minimize the
    # N by substituting the first (lowest) primes into the equation above.
    # Take a shortcut to n = √n^2 by subtracting the excess from each factor
    # and dividing by 2.
    pf.each_with_index.reduce( 1 ) {|acc, (e, i)| acc * P[i]**e}
  end

  def solution; 'MTgwMTgw' end
  def best_time; 0.00003386 end
  def effort; 25 end

  def completed_on; '2015-01-27' end
  def ordinality; 7_736 end
  def population; 457_323 end
  
  def refs; [] end
end
