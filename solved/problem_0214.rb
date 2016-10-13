require 'projectEuler'

class Problem_0214
  def title; 'Totient Chains' end
  def difficulty; 214 end

  # Let φ be Euler's totient function, i.e. for a natural number n, φ(n) is
  # the number of k, 1 ≤ k ≤ n, for which gcd(k,n) = 1.
  #
  # By iterating φ, each positive integer generates a decreasing chain of
  # numbers ending in 1. E.g. if we start with 5 the sequence 5,4,2,1 is gen-
  # erated. Here is a listing of all chains with length 4:
  #
  #   5,4,2,1
  #   7,6,2,1
  #   8,4,2,1
  #   9,6,2,1
  #   10,4,2,1
  #   12,4,2,1
  #   14,6,2,1
  #   18,6,2,1
  #
  # Only two of these chains start with a prime, their sum is 12.
  #
  # What is the sum of all primes less than 40000000 which generate a chain of
  # length 25?

  def solve( n = 40_000_000, len = 25 )
    t = n.totient_sieve
    sum, last = 0, false
    len -= 1

    # Brute-force approach because n is tractable. Sieve all the totients,
    # then go back and replace each entry with its totient's entry plus one.
    # If the totient is one less than the current index, the value must be
    # prime, so add it to the total if its chain is the correct length.
    (2...n).each do |i|
      sum += i if t[i] == i - 1 && last
      t[i] = 1 + t[t[i]]
      last = t[i] == len
    end

    sum
  end

  def solution; 'MTY3NzM2NjI3ODk0Mw==' end
  def best_time; 34.29 end
  def effort; 5 end

  def completed_on; '2016-10-13' end
  def ordinality; 3_874 end
  def population; 640_943 end

  def refs; [] end
end
