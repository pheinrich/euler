require 'projectEuler'

class Problem_0234
  def title; 'Semidivisible numbers' end
  def difficulty; 50 end

  # For an integer n ≥ 4, we define the lower prime square root of n, denoted
  # by lps(n), as the largest prime ≤ √n and the upper prime square root of n,
  # ups(n), as the smallest prime ≥ √n.
  #
  # So, for example, lps(4) = 2 = ups(4), lps(1000) = 31, ups(1000) = 37. Let
  # us call an integer n ≥ 4 semidivisible, if one of lps(n) and ups(n)
  # divides n, but not both.
  #
  # The sum of the semidivisible numbers not exceeding 15 is 30, the numbers
  # are 8, 10 and 12. 15 is not semidivisible because it is a multiple of both
  # lps(15) = 3 and ups(15) = 5. As a further example, the sum of the 92 semi-
  # divisible numbers up to 1000 is 34825.
  #
  # What is the sum of all semidivisible numbers not exceeding 999966663333?

  def solve( n = 999966663333 )
    # Extend the range of our prime sieve slightly to ensure we include the
    # prime just on the other side of our upper bound.
    limit = Math.sqrt( n )
    p = (limit + 10*Math.log10( limit )).to_i.prime_sieve
    semis = Hash.new( 0 )

    # For each pair of primes, effectively "sieve" the squares in between
    # (that is, the numbers whose square roots fall between the two primes).
    (0...p.length-1).each do |i|
      lps, ups = p[i], p[i + 1]
      first, last = lps*lps, ups*ups

      # Step forward from the lower bound, marking potential semidivisibles.
      (first + lps).step( last, lps ) {|i| semis[i] ^= 1}

      # Step backward from the upper bound, doing the same. Note that since
      # we're using XOR to mark candidates, marking them twice (which happens
      # if both lps(n) and ups(n) divide n) automatically clears the flag.
      (last - ups).step( first, -ups ) {|i| semis[i] ^= 1}
    end

    # Drop all candidates divisible by both upper and lower prime square roots
    # and sum the rest.
    semis.select! {|k, v| 1 == v && k < n}
    semis.keys.reduce( :+ )
  end

  def solution; 'MTI1OTE4NzQzODU3NDkyNzE2MQ==' end
  def best_time; 4.720 end
  def effort; 40 end
  
  def completed_on; '2015-01-23' end
  def ordinality; 2_198 end
  def population; 484_245 end

  def refs
    ['https://oeis.org/A157939']
  end

  # Pattern discovery:
  #    r = 2              3                                               5
  #    n = 4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
  #
  #  r|n = 1     1     1  1        1        1        1        1        1  1
  #  R|n = 1     1        1  1              1              1              1
  #                    X     X     X
end
