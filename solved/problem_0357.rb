require 'projectEuler'

# 31.75s (3/13/15, #2807)
class Problem_0357
  def title; 'Prime generating integers' end
  def difficulty; 10 end

  # Consider the divisors of 30: 1,2,3,5,6,10,15,30.
  # It can be seen that for every divisor d of 30, d+30/d is prime.
  #
  # Find the sum of all positive integers n not exceeding 100 000 000
  # such that for every divisor d of n, d+n/d is prime.

  def solve( n = 100_000_000 )
    # Observe that:
    #   1. n must be 1 or even
    #   2. n + 1 must be prime
    #   3. n/2 + 2 must be prime
    #   4. (n - 2) % 4 = 0 for n > 1, so (n + 1) % 4 = 3 for n > 1
    p = {}
    n.prime_sieve.each {|i| p[i] = 1}

    # From observation 2, we can work backward to compute candidate values of
    # n from known primes.
    primes = p.keys.select do |i|
      # Skip primes that don't satisfy observation 4. 
      next if 3 != i % 4

      # Test every divisor up to the square root of each candidate.
      cand, d = i - 1, 1      
      begin
        d += 1
        q, r = cand / d, cand % d

        match = p.has_key?( d+q ) if 0 == r
      end while match && d < q

      match
    end

    # Add one since it isn't included in the primes array. Adjust down to
    # account for each n = p-1.
    1 + primes.reduce( :+ ) - primes.length
  end

  def solution; 1_739_023_853_137 end
  def best_time; 31.75 end
  def effort; 20 end
  
  def completed_on; '2015-03-13' end
  def ordinality; 2_807 end
  def percentile; 469_765 end

  def refs
    ["https://oeis.org/A080715",
     "https://oeis.org/A268403"]
  end
end
