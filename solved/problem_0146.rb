require 'projectEuler'

class Problem_0146
  def title; 'Investigating a Prime Pattern' end
  def difficulty; 50 end

  # The smallest positive integer n for which the numbers n^2+1, n^2+3, n^2+7,
  # n^2+9, n^2+13, and n^2+27 are consecutive primes is 10. The sum of all
  # such integers n below one-million is 1242490.
  #
  # What is the sum of all such integers n below 150 million?

  def solve2( n = 150_000_000 )
    # Brute force.
    sum = 10
    i = 20

    while i < n
      if 0 != i % 3
        i2 = i*i

        # Must verify that the primes are consecutive (i.e. there aren't any
        # primes hiding between entries).
        if (i2 + 1).miller_rabin? &&
           (i2 + 3).miller_rabin? &&
           (i2 + 7).miller_rabin? &&
           (i2 + 9).miller_rabin? &&
          !(i2 + 11).miller_rabin? &&
           (i2 + 13).miller_rabin? &&
          !(i2 + 17).miller_rabin? &&
          !(i2 + 19).miller_rabin? &&
          !(i2 + 21).miller_rabin? &&
          !(i2 + 23).miller_rabin? &&
           (i2 + 27).miller_rabin?
          
          sum += i
          i += 315410
        end
      end

      # From observation that 10 | a_n in similar sequences.
      i += 10
    end

    sum
  end

  def solution; 'Njc2MzMzMjcw' end
  def best_time; 1088 end
  def effort; 30 end

  def completed_on; '2016-08-02' end
  def ordinality; 3_411 end
  def population; 618_739 end

  def refs
    ['http://oeis.org/A057015',
     'http://oeis.org/A057095',
     'https://en.wikipedia.org/wiki/Prime_k-tuple']
  end
end
