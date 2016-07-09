require 'projectEuler'

# 66.57s (7/8/16, #688) 
class Problem_0549
  def title; 'Divisibility of factorials' end
  def difficulty; 10 end

  # The smallest number m such that 10 divides m! is m=5.
  # The smallest number m such that 25 divides m! is m=10.
  #
  # Let s(n) be the smallest number m such that n divides m!.
  # So s(10)=5 and s(25)=10.
  # Let S(n) be ∑s(i) for 2 ≤ i ≤ n.
  # S(100)=2012.
  #
  # Find S(10^8).

  # Return the value of s(n) when n = p^k for some prime p.
  def sofpp( p, k )
    s = 0

    # Starting with p, advance through multiples of p until we have seen k
    # occurrences among the factorizations along the way. 
    while 0 < k
      s += p      

      # Divide the current multiple of p until we've extracted the highest
      # power possible.
      cur = s
      while 0 == cur % p
        k -= 1
        cur /= p
      end
    end

    s
  end

  # Compute s(n) for all numbers up to and including n.
  def sofn_sieve( n )
    s = Array.new( 1 + n, 0 )
    limit = Math.sqrt( n )
    smp = []
    
    (2..n/2).each do |m|
      if 0 == s[m]
        s[m] = m
        smp << m if m < limit
      end
      
      sm, thresh = s[m], n / m

      smp.each do |p|
        break if p > thresh
        
        if 0 != m % p
          s[p * m] = sm
        else
          k, q = 2, m / p
          
          while 0 == q % p
            q /= p
            k += 1
          end
          
          s[p * m] = [sofpp( p, k ), s[q]].max
          break
        end
      end
    end

    s.each_with_index {|e, i| s[i] = i if 0 == e}
    s
  end

  def solve( n = 100_000_000 )
    # To clarify, s(n) identifies the smallest factorial divisible by n.
    #
    #     n   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
    #   s(n)  1  2  3  4  5  3  7  4  6  5 11  4 13  7  5  6 17  6 19  5
    #
    # From this it's clear that s(n) = n when n is prime. We can use the
    # fact that s(p^k * m) is max {s(p^k), s(m)} to decompose values along
    # the way.
    s = sofn_sieve( n )
    s.reduce( :+ ) - 1
  end

  def solution; 476_001_479_068_717 end
  def best_time; 66.57 end
  def effort; 75 end
  
  def completed_on; '2016-07-08' end
  def ordinality; 688 end
  def population; 576_755 end

  def refs
    ["http://blog.janmr.com/2010/10/prime-factors-of-factorial-numbers.html",
     "http://www.cut-the-knot.org/blue/LegendresTheorem.shtml",
     "http://math.stackexchange.com/a/229327",
     "http://codereview.stackexchange.com/a/129868"]
  end
end
