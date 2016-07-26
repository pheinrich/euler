require 'projectEuler'

# 0.09701s (7/26/16, #5074)
class Problem_0131
  def title; 'Prime cube partnership' end
  def difficulty; 40 end

  # There are some prime values, p, for which there exists a positive integer,
  # n, such that the expression n^3 + n^2·p is a perfect cube.
  #
  # For example, when p = 19, 8^3 + 8^2×19 = 12^3.
  #
  # What is perhaps most surprising is that for each prime with this property
  # the value of n is unique, and there are only four such primes below
  # one-hundred.
  #
  # How many primes below one million have this remarkable property?

  def solve( n = 1_000_000 )
    # Brute-force computation yields the four primes < 100 mentioned in the
    # problem statement: [7, 19, 37, 61]. From there, OEIS.org quickly un-
    # covers the Cuban Primes (A002407), which take several alternative forms:
    #
    #   1. p = (x^3 - y^3) / (x - y) where x = y + 1
    #   2. p = 1 + 3k(k + 1) where k = ⌊√(p/3)⌋
    #   3. p such that n^2(p + n) is a cube (as above)
    #   4. 4p = 1 + 3n^2
    #
    # Rearranging the last form and solving for n we get n = √(12p - 3) / 3,
    # which tells us the only primes matching the criteria are the ones for
    # which the discriminant 12p - 3 is a perfect square. We can shave a few
    # milliseconds, however, by using the second form instead, since it means
    # computing the square root of a smaller number.
    p = n.prime_sieve
    p.count do |i|
      k = Math.sqrt( i / 3.0 ).to_i
      k*(k + 1) == (i - 1) / 3.0
    end
  end

  def solution; 173 end
  def best_time; 0.08028 end
  def effort; 20 end

  def completed_on; '2016-07-26' end
  def ordinality; 5_074 end
  def population; 581_183 end

  def refs
    ["http://burningmath.blogspot.com/2013/09/how-to-know-or-check-if-number-is.html",
     "http://www.mathgoodies.com/articles/numbers.html",
     "http://oeis.org/A002407"]
  end
end
