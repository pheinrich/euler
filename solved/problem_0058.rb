require 'projectEuler'

class Problem_0058
  def title; 'Spiral primes' end
  def difficulty; 5 end

  # Starting with 1 and spiralling anticlockwise in the following way, a
  # square spiral with side length 7 is formed.
  #
  #     37 36 35 34 33 32 31
  #     38 17 16 15 14 13 30
  #     39 18  5  4  3 12 29
  #     40 19  6  1  2 11 28
  #     41 20  7  8  9 10 27
  #     42 21 22 23 24 25 26
  #     43 44 45 46 47 48 49
  #
  # It is interesting to note that the odd squares lie along the bottom right
  # diagonal, but what is more interesting is that 8 out of the 13 numbers
  # lying along both diagonals are prime; that is, a ratio of 8/13 ~= 62%.
  #
  # If one complete new layer is wrapped around the spiral above, a square
  # spiral with side length 9 will be formed. If this process is continued,
  # what is the side length of the square spiral for which the ratio of primes
  # along both diagonals first falls below 10%?

  def solve( ratio = 0.1 )
    start = len = 1 
    ds = dc = 2
    diag, primes = 1, 0
    
    begin
      len += 2
      start += ds

      4.times {|i| primes += 1 if (start + i*dc).miller_rabin?}

      ds += 8
      dc += 2
      diag += 4
    end while primes >= ratio * diag

    len
  end

  def solution; 'MjYyNDE=' end
  def best_time; 2.683 end
  def effort; 15 end

  def completed_on; '2013-04-03' end
  def ordinality; 15_930 end
  def population; 310_438 end

  def refs
    ['https://en.wikipedia.org/wiki/Ulam_spiral',
     'https://oeis.org/A200975']
  end
end
