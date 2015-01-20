require 'projectEuler'

# 2808s (1/20/15, #4108)
class Problem_0134
  def title; 'Prime pair connection' end
  def solution; 18_613_426_663_617_118 end

  # Consider the consecutive primes p1 = 19 and p2 = 23. It can be verified
  # that 1219 is the smallest number such that the last digits are formed by
  # p1 whilst also being divisible by p2.
  #
  # In fact, with the exception of p1 = 3 and p2 = 5, for every pair of con-
  # secutive primes, p2 > p1, there exist values of n for which the last
  # digits are formed by p1 and n is divisible by p2. Let S be the smallest of
  # these values of n.
  #
  # Find ∑ S for every pair of consecutive primes with 5 ≤ p1 ≤ 1000000.

  def solve( min = 5, max = 1_000_000 )
    p = (max + 10*Math.log( max )).to_i.prime_sieve
    first = p.find_index( min )
    last = p.find_index {|n| n > max}
    sum = 0

    (first...last).each do |i|
      order = 10**(Math.log10( p[i] ).to_i + 1)
      k = 1
      k += 1 while (k*p[i + 1] - p[i]) % order != 0
      sum += k*p[i + 1]
    end
    
    sum
  end
end
