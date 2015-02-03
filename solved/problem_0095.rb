require 'projectEuler'

# 9.751s (2/14/14, #6859)
class Problem_0095
  def title; 'Amicable chains' end

  # The proper divisors of a number are all the divisors excluding the number
  # itself. For example, the proper divisors of 28 are 1, 2, 4, 7, and 14. As
  # the sum of these divisors is equal to 28, we call it a perfect number.
  #
  # Interestingly the sum of the proper divisors of 220 is 284 and the sum of
  # the proper divisors of 284 is 220, forming a chain of two numbers. For
  # this reason, 220 and 284 are called an amicable pair.
  #
  # Perhaps less well known are longer chains. For example, starting with
  # 12496, we form a chain of five numbers:
  #
  #     12496 -> 14288 -> 15472 -> 14536 -> 14264 (-> 12496 -> ...)
  #
  # Since this chain returns to its starting point, it is called an amicable
  # chain.
  #
  # Find the smallest member of the longest amicable chain with no element
  # exceeding one million.

  def refs; [] end
  def solution; 14_316 end
  def best_time; 9.751 end

  def completed_on; '2014-02-14' end
  def ordinality; 6_859 end
  def percentile; 98.27 end

  def solve( n = 1_000_000 )
    # Compute the sum of all factors for each number less than n.
    s = n.factorsum_sieve
    longest = []

    # For each value, count the chain links.
    (2...n).each do |x|
      cur, chain = x, []

      # Follow the chain until the sum exceeds the limit, or until we see a
      # value more than once.
      begin
        chain << cur
        cur = s[cur]
      end while cur < n && !chain.include?( cur )

      # If we stopped because we saw the starting value again, it's a chain
      # satisfying our criteria.  Keep track of the longest one seen so far.
      longest = chain if cur == x && chain.length > longest.length 
    end

    longest[0]
  end
end
