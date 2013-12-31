require 'projectEuler'

# 20.32s (12/17/13, #~10787)
class Problem_0070
  def title; 'Totient permutation' end
  def solution; 8_319_823 end

  # Euler's Totient function, φ(n) [sometimes called the phi function], is
  # used to determine the number of positive numbers less than or equal to n
  # which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are
  # all less than nine and relatively prime to nine, φ(9)=6.
  #
  # The number 1 is considered to be relatively prime to every positive
  # number, so φ(1)=1.
  #
  # Interestingly, φ(87109)=79180, and it can be seen that 87109 is a
  # permutation of 79180.
  #
  # Find the value of n, 1 < n < 10^7, for which φ(n) is a permutation of n
  # and the ratio n/φ(n) produces a minimum.

  def solve( n = 10_000_000 )
    # To minimize n/φ(n), maximize denominator. φ(n) = n ∏(p - 1/p) over p|n.
    # That means every prime factor makes the denominator smaller, so the
    # fewer (and larger) the prime factors, the better.
    primes = (n / 2).prime_sieve.reverse
    limit = primes.each_with_index.min_by {|i| (i[0].to_f - Math.sqrt( n )).abs}[1]
    match = 0
    min = 5

    # Check all the products < n of two distinct primes. 
    primes[0..limit].each do |i|
      primes.reverse_each do |j|
        p = i*j
        break unless n > p

        # Totient calculation is simplified with only two prime factors.
        t = (i-1) * (j-1)
        next unless p.to_s.chars.sort == t.to_s.chars.sort

        # Save the lowest value seen so far.
        r = p.to_f / t
        match, min = p, r if min > r
      end
    end
    
    match
  end
end
