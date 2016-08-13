require 'projectEuler'

class Problem_0204
  def title; 'Generalised Hamming Numbers' end
  def difficulty; 30 end

  # A Hamming number is a positive number which has no prime factor larger
  # than 5. So the first few Hamming numbers are 1, 2, 3, 4, 5, 6, 8, 9, 10,
  # 12, 15. There are 1105 Hamming numbers not exceeding 10^8.
  #
  # We will call a positive number a generalised Hamming number of type n, if
  # it has no prime factor larger than n. Hence the Hamming numbers are the
  # generalised Hamming numbers of type 5.
  #
  # How many generalised Hamming numbers of type 100 are there which don't
  # exceed 10^9?

  def tally( p, first, x, lgx, prod, found )
    mult, log = 1, (lgx / Math.log( p[first] )).floor

    while 0 <= log
      pm = prod * mult
      break if pm > x

      if first < p.size - 1
        tally( p, first + 1, x, lgx, pm, found )
      else
        found[pm] = true
      end

      mult *= p[first]
      log -= 1
    end
    
    found.size
  end

  def solve( x = 1_000_000_000, y = 100 )
    # This problem is asking us to find positive integers that may be formed
    # by multiplying powers of certain small prime numbers. Took me a while to
    # parse the question, since I kept thinking any multiple of the small
    # primes would count--but that's definitely not true (since its multiplier
    # must ALSO be one of the target primes).
    #
    # In the end, this boils down to recursive grouping.
    found = {}
    tally( p = y.prime_sieve, 0, x, Math.log( x ), 1, found )
  end

  def solution; 'Mjk0NDQ3Mw==' end
  def best_time; 12.31 end
  def effort; 30 end

  def completed_on; '2016-08-12' end
  def ordinality; 5_332 end
  def population; 621_706 end

  def refs
    ['https://en.wikipedia.org/wiki/Smooth_number',
     'http://oeis.org/A051037']
  end
end
