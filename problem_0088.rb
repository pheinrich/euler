require 'projectEuler'

# 
class Problem_0088
  def title; 'Product-sum numbers' end
  def solution;  end

  # A natural number, N, that can be written as the sum and product of a given
  # set of at least two natural numbers, {a1, a2, ... , ak} is called a
  # product-sum number: N = a1 + a2 + ... + ak = a1 × a2 × ... × ak.
  #
  # For example, 6 = 1 + 2 + 3 = 1 × 2 × 3.
  #
  # For a given set of size, k, we shall call the smallest N with this
  # property a minimal product-sum number. The minimal product-sum numbers for
  # sets of size, k = 2, 3, 4, 5, and 6 are as follows.
  #
  #     k=2: 4 = 2 × 2 = 2 + 2
  #     k=3: 6 = 1 × 2 × 3 = 1 + 2 + 3
  #     k=4: 8 = 1 × 1 × 2 × 4 = 1 + 1 + 2 + 4
  #     k=5: 8 = 1 × 1 × 2 × 2 × 2 = 1 + 1 + 2 + 2 + 2
  #     k=6: 12 = 1 × 1 × 1 × 1 × 2 × 6 = 1 + 1 + 1 + 1 + 2 + 6
  #
  # Hence for 2≤k≤6, the sum of all the minimal product-sum numbers is
  # 4+6+8+12 = 30; note that 8 is only counted once in the sum.
  #
  # In fact, as the complete set of minimal product-sum numbers for 2≤k≤12 is
  # {4, 6, 8, 12, 15, 16}, the sum is 61.
  #
  # What is the sum of all the minimal product-sum numbers for 2≤k≤12000?

  def advance(k, seq)
    digit, pad = 0, k - 1 - seq.length

    while true
      seq[digit] += 1

      # If the updated digit is valid, check the product as well.  If it's
      # also valid, this sequence is a candidate.
      if seq[digit] < k
        prod = seq.inject( :* )
        return prod - 1, pad + seq.inject( :+ ) unless k < prod
      end

      # Short circuit if our product is too big even at the beginning, or if
      # we can't add any more digits
      return nil, nil if 0 == pad || 2 == seq[0]

      # The digit or product got too big, so advance to the next digit in
      # preparation for incrementing it.
      digit += 1
      if digit >= seq.length
        # If the next digit doesn't exist yet, tack it on (and reduce the
        # number of padding digits by one.
        seq << 1
        pad -= 1
      end

      # Reset all least-significant digits to match the value of the digit
      # we're about to increment. 
      seq[0, digit] = [1 + seq[digit]] * digit
    end
  end

  def sumprod_min( n )
#    print '.' if 0 == n % 100
#    puts if 0 == n % 1000

    min, s = n << 1, [2, n]
    seq = [1]

    while true
      prod, sum = advance( n, seq )
      break unless prod

      quot, rem = sum.divmod( prod )
      if 0 == rem
        sum += quot
        if sum < min
          min, s = sum, seq.reverse + [quot]
        end
      end
    end 

#    puts "#{n}: #{s.inspect} = #{min}"
    @h[min] += 1
    min
  end

  def rpf( n )
    hash = {}
    pf = n.prime_factors

    puts "#{n}: #{pf.inspect}"
    prod = pf.inject( :* )
    sum = pf.inject( :+ )

    hash[n - sum + pf.count] = 1
    puts "  0000 -> #{n - sum + pf.count} (count = #{pf.count}, sum = #{sum})"

    (1...(2**pf.count)-2).each do |i|
      print "  %04b -> " % i
      if (i & (~i + 1)) == i
        puts "power of two"
        next
      end
      count, sum, prod = 1, 0, 1

      pf.count.times do |j|
        if 1 == i & 1
          prod *= pf[j]
        else
          sum += pf[j]
          count += 1
        end
        i >>= 1
      end

      sum += prod
      hash[n - sum + count] = 1
      puts "#{n - sum + count} (count = #{count}, sum = #{sum})"
    end

    hash
  end

  def solve
    # http://en.wikipedia.org/wiki/Multiplicative_partition
    # http://math.wvu.edu/~mays/Papers/apf7.pdf
    rpf( 16 ).keys.inspect
  end

  def solve2( first = 2, last = 500 )#_000 )
    @h = Hash.new {|h, k| h[k] = 0}
    s = (first..last).map {|i| sumprod_min( i )}
#    puts "#{s.uniq.sort.inspect}"
    s.uniq.inject( :+ )
  end
end
