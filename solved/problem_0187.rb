require 'projectEuler'

# 11.95s (1/24/15, #6876)
class Problem_0187
  def title; 'Semiprimes' end

  # A composite is a number containing at least two prime factors. For ex-
  # ample, 15 = 3 × 5; 9 = 3 × 3; 12 = 2 × 2 × 3.
  #
  # There are ten composites below thirty containing precisely two, not neces-
  # sarily distinct, prime factors: 4, 6, 9, 10, 14, 15, 21, 22, 25, 26.
  #
  # How many composite integers, n < 10^8, have precisely two, not necessarily
  # distinct, prime factors?

  def refs; ["http://mathworld.wolfram.com/Semiprime.html"] end
  def solution; 17_427_258 end
  def best_time; 3.398 end

  def completed_on; '2015-01-24' end
  def ordinality; 6_876 end
  def population; 456_579 end

  def solve( n = 100_000_000 )
    p = (n / 2).prime_sieve
    first, last = 0, p.length - 1
    sum = 0

    while first < last
      limit = n / p[first]
      last -= 1 while limit < p[last]

      sum += last - first + 1
      first += 1 
    end

    sum
  end
end
