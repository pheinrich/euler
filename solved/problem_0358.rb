require 'projectEuler'

class Problem_0358
  def title; 'Cyclic numbers' end
  def difficulty; 25 end

  # A cyclic number with n digits has a very interesting property:
  # When it is multiplied by 1, 2, 3, 4, ... n, all the products have exactly
  # the same digits, in the same order, but rotated in a circular fashion!
  #
  # The smallest cyclic number is the 6-digit number 142857:
  #   142857 × 1 = 142857
  #   142857 × 2 = 285714
  #   142857 × 3 = 428571
  #   142857 × 4 = 571428
  #   142857 × 5 = 714285
  #   142857 × 6 = 857142
  #
  # The next cyclic number is 0588235294117647 with 16 digits:
  #   0588235294117647 × 1 = 0588235294117647
  #   0588235294117647 × 2 = 1176470588235294
  #   0588235294117647 × 3 = 1764705882352941
  #   ...
  #   0588235294117647 × 16 = 9411764705882352
  #
  # Note that for cyclic numbers, leading zeros are important.
  # 
  # There is only one cyclic number for which, the eleven leftmost digits are
  # 00000000137 and the five rightmost digits are 56789 (i.e., it has the form
  # 00000000137...56789 with an unknown number of digits in the middle). Find
  # the sum of all its digits.

  def prefix?( p, pre )
    s = "%.#{pre.length + 1}f" % [1.0 / p]
    s[2..-1].start_with?( pre )
  end

  def suffix?( p, suf )
    m = 10**suf.length
    num = (10.modular_power( p - 1, m ) - 1) % m
    suf.to_i == (num * p.inverse( m )) % m
  end

  def solve( pre = '00000000137', suf = '56789' )
    # Cyclic numbers have the form (b^{p-1} - 1)/p (a Fermat quotient), where
    # b is the number base and p is a prime that doesn't divide b. p = 7, 17
    # produce the (base-10) examples given in the problem statement. Not all
    # primes result in a cyclic number.
    #
    # Our goal is to find the prime p whose Fermat quotient q(p) in base 10
    # has specific start/end digits:
    #
    #   q(p) = 00000000137...
    #   q(p) % 100_000 = 56789
    #
    # In the first case, if we take the prefix string to be a fractional value
    # right of a decimal point, we can then directly compute the smallest p
    # possible. Similarly, verifying the last digits requires a simple modulo
    # check.

    # Find the first prime whose reciprocal matches the prefix specified.
    p = (1 / "0.#{pre.next}".to_f).to_i
    p += 1 if p.even?
    p += 2 until p.miller_rabin?

    sum = 0

    # Check primes until we find one that generates a cyclic number matching
    # the start/end digits we want. len keeps track of the cycle length, which
    # must be maximal (p - 1) in order for the number to be cyclic.
    while true
      # Check the current prime for start/end match and advance if not.
      until prefix?( p, pre ) && suffix?( p, suf )
        p += 2
        p += 2 until p.miller_rabin?
      end

      # We found a matching prime, so now do long division to produce the
      # decimal expansion of its associated (potential) cyclic number.
      len, r, sum = 0, 1, 0
      begin
        len, x = len + 1, r * 10
        d, r = x / p, x % p
        sum += d
      end while r != 1

      # If this prime generates a cyclic number, we're done.
      break if len == p - 1
      p += 2
    end

    sum
  end

  def solution; 'MzI4NDE0NDUwNQ==' end
  def best_time; 107.3 end
  def effort; 25 end

  def completed_on; '2018-10-30' end
  def ordinality; 1_302 end
  def population; 794_002 end

  def refs
    ['https://en.wikipedia.org/wiki/Cyclic_number']
  end
end
