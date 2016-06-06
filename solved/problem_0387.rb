require 'projectEuler'

# 4.343s (3/15/15, #1183)
class Problem_0387
  def title; 'Harshad Numbers' end

  # A Harshad or Niven number is a number that is divisible by the sum of its
  # digits. 201 is a Harshad number because it is divisible by 3 (the sum of
  # its digits.) When we truncate the last digit from 201, we get 20, which is
  # a Harshad number. When we truncate the last digit from 20, we get 2, which
  # is also a Harshad number.
  #
  # Let's call a Harshad number that, while recursively truncating the last
  # digit, always results in a Harshad number a right truncatable Harshad
  # number.
  #
  # Also: 
  # 201 / 3 = 67 which is prime.
  # Let's call a Harshad number that, when divided by the sum of its digits,
  # results in a prime a strong Harshad number.
  #
  # Now take the number 2011 which is prime. When we truncate the last digit
  # from it we get 201, a strong Harshad number that is also right trun-
  # catable.
  # 
  # Let's call such primes strong, right truncatable Harshad primes.
  #
  # You are given that the sum of the strong, right truncatable Harshad primes
  # less than 10000 is 90619.
  #
  # Find the sum of the strong, right truncatable Harshad primes less than
  # 10^14.

  def build( node, depth, max, strong )
    # Exit if we've built the tree deep enough.
    return if max < depth

    # Append each digit in turn to see if the result is a Harshad number.
    (0..9).each do |i|
      v = node.value * 10 + i
      
      sd = v.sum_digits
      q, r = v / sd, v % sd

      # This node is a right truncatable Harshad number, so if the new number
      # is Harshad, it's also right truncatable. Keep track of strong right
      # truncatable Harshad numbers in a separate list. 
      if 0 == r
        node.add( v )
        strong << v if q.prime?
      end
    end
  end

  def solve( n = 100_000_000_000_000 )
    strong = []
    total = 0

    # Build a tree of right truncatable Harshad numbers for each non-zero
    # digit. Collect all the strong right truncatable Harshad numbers along
    # the way.
    (1..9).each do |i|
      root = ProjectEuler::Tree.new( i )
      root.dfi( lambda {|node, depth| build( node, depth, Math.log10( n ) - 3, strong )} )
    end

    # Try form strong right truncatable Harshad primes from each strong right
    # truncatable Harshad number.
    strong.each do |s|
      for i in [1, 3, 7, 9]
        p = s*10 + i
        total += p if p.prime?
      end
    end

    total
  end

  def solution; 696_067_597_313_468 end
  def best_time; 4.343 end
  def effort; 75 end
  
  def completed_on; '2015-03-15' end
  def ordinality; 1_183 end
  def percentile; 470_129 end
  
  def refs
    ["http://en.wikipedia.org/wiki/Harshad_number",
     "http://oeis.org/A005349",
     "http://oeis.org/A097569"]
  end
end
