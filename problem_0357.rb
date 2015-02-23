require 'projectEuler'

# 
class Problem_0357
  def title; 'Prime generating integers' end

  # Consider the divisors of 30: 1,2,3,5,6,10,15,30.
  # It can be seen that for every divisor d of 30, d+30/d is prime.
  #
  # Find the sum of all positive integers n not exceeding 100 000 000
  # such that for every divisor d of n, d+n/d is prime.

  def refs
    ["https://oeis.org/A080715" ]
  end

  def solution; end
  def best_time; end

  def completed_on; '2015-??-??' end
  def ordinality; end
  def percentile; end

  def match( i )
    f = i.factors
    f.length == f.count {|j| (j + i/j).prime?}
  end

  def solve( n = 100_000_000 )
  end
end
