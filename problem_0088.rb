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
    len = seq.length
    pad = k - 1 - len
    digit = 0

    while true
      seq[digit] += 1
#      puts "#{seq.inspect}"

      # If the updated digit is valid, check the product as well.  If it's
      # also valid, this sequence is a candidate.
      if seq[digit] < k
        prod = seq.inject( :* )
        return prod - 1, pad + seq.inject( :+ ) unless k < prod
      end

      # Short circuit if our product is too big even at the beginning.
      return nil, nil if 2 == seq[0]

      # The digit or product got too big, so advance to the next digit in
      # preparation for incrementing it.
      digit += 1
      if digit >= seq.length
        # If the next digit doesn't exist yet, tack it on (and reduce the
        # number of padding digits by one.
        seq << 1
        pad -= 1
      end

      # Short-circuit if we can't add any more digits.
      return nil, nil if pad <= 0

      # Reset all least-significant digits to match the value of the digit
      # we're about to increment. 
      seq[0, digit] = [1 + seq[digit]] * digit
    end
  end

  def sumprod_min( n )
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
    min
  end

  def solve( first = 2, last = 12 )#_000 )
    (first..last).map {|i| sumprod_min( i )}.uniq.inject( :+ )
  end
end
