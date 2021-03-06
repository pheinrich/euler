class Array
  # Return an integer satisfying a series of congruences whose moduli and
  # remainders are the 2-tuples of this array. For example:
  #
  #  x ≡ 2 (mod 3) --> [3, 2]
  #  x ≡ 3 (mod 5) --> [5, 3]
  #  x ≡ 2 (mod 7) --> [7, 2]
  #
  # So, [[3, 2], [5, 3], [7, 2]].chinese_rem = 23.
  #
  # http://rosettacode.org/wiki/Chinese_remainder_theorem#C
  # Problems:  134
  def chinese_rem
    prod = self.reduce( 1 ) {|acc, (m, r)| acc * m}

    sum = self.reduce( 0 ) do |acc, (m, r)|
      p = prod / m 
      inv = p.inverse( m )

      return nil if inv.nil?
      acc + r * inv * p
    end
   
    sum % prod
  end

  # Return the kth convergent for a simply periodic continued fraction.
  #
  # Problems:  65, 66
  def convergent( k )
    p, q = [1, 0], [0, 1]
    i = 0
  
    until 0 > k
      p.unshift( self[i] * p[0] + p[1] )
      q.unshift( self[i] * q[0] + q[1] )
      
      k -= 1
      i += 1
      i = 1 unless i < self.length
    end
  
    Rational( p[0], q[0] )
  end

  # Return true if no two subsets of an array sum to the same value. The
  # optional polys parameter allows for precomputation of intermediate values
  # (to optimize multiple calls on sets of similar size). If an empty array is
  # passed in, this method will initialize it as necessary so it can be
  # reused on subsequent calls.
  #
  # Problems:  103, 106
  def dissociated?( polys = nil )
    arr = self.sort
    polys ||= []
  
    # Precompute (if necessary) which subsets should be pairwise compared to
    # guarantee that this ordered set is dissociated.
    unless 0 < polys.size
      max = 1 << arr.size
  
      (arr.size >> 1).times do |hw|
        # Start with the smallest polynomial having h bits.
        base = (2 << hw) - 1
  
        while base < max
          # Compare the base to every similar-weighted polynomial up to the limit.
          cmp = base.bitseq
    
          while cmp < max
            # Only consider sets sharing no bits.
            polys << [base, cmp] if 0 == base & cmp && base.straddle?( cmp )
            cmp = cmp.bitseq
          end
    
          base = base.bitseq
        end
      end
    end
  
    sums = {}
  
    # Pairwise compare the subsets identified above.    
    for p, q in polys
      # For each set bit in the binary polynomials, add the corresponding
      # array entry. Memoize the sums so we calculate it only once for any
      # given polynomial.
      sums[p] = arr.each_with_index.map {|a, i| 1 == (p >> i) & 1 ? a : 0}.reduce( :+ ) unless sums[p]
      sums[q] = arr.each_with_index.map {|a, i| 1 == (q >> i) & 1 ? a : 0}.reduce( :+ ) unless sums[q]
    
      # If we found sets that are pairwise equal, short circuit.
      return false if sums[p] == sums[q] 
    end
    
    # All subset sums are unique.
    true
  end
  
  # Given that S(A) is the sum of all elements in A, return true if for
  # subsets B and C, S(B) > S(C) whenever |B| > |C|. This method assumes the
  # elements are presorted in ascending order.
  #
  # Problems:  103
  def domcard?
    arr = self.sort

    # The sum of the smallest n elements should always be greater than the sum
    # of the n - 1 largest elements.
    1.upto( arr.size >> 1 ).each do |n|
      return false unless arr[0, n + 1].reduce( :+ ) > arr[-n, n].reduce( :+ ) 
    end
  
    # Subsets of higher cardinality will sum higher than subsets of lower
    # cardinality.
    true
  end

  # Create a Lagrange Polynomial interpolation function for the points in this
  # array. Its order will equal the length of the array (caution: large arrays
  # may suffer ringing). Array elements are expected to be (x, y) 2-tuples.
  #
  # http://www1.maths.leeds.ac.uk/~kersale/2600/Notes/appendix_E.pdf
  # Problems:  101
  def lagrange_interp_func
    lambda {|x|
      # Calculate the intermediate multipliers L_k(x).
      l = self.map.with_index do |a, i|
        points = self.reject.with_index {|p, j| j == i}
        points.inject( 1.0 ) {|acc, p| acc * (x - p[0]) / (self[i][0] - p[0])}
      end

      # Weight each term by its multiplier and combine. 
      self.each_with_index.reduce( 0 ) {|acc, (p, i)| acc + p[1]*l[i]}
    }
  end

  # Multiply two polynomials whose coefficients are represented by the entries
  # in two arrays.
  #
  # Problems:  172, 203
  def multpoly( poly )
    result = Array.new( self.size + poly.size - 1, 0 )

    self.each_with_index do |ai, i|
      poly.each_with_index do |bj, j|
        result[i + j] += ai * bj
      end
    end

    result
  end

  # Create a polynomial generating function from an array of coefficients. For
  # example, the array [0, 0, 0, 1] corresponds to f(x) = x^3, since
  # x^3 = (0)(x^0) + (0)(x^1) + (0)(x^2) + (1)(x^3). Similarly, the array
  # [2, -1, 0, 0, 3, -2, 0, 1] -> f(x) = x^6 - 2x^4 + 3x^3 - x + 2.
  #
  # The resulting function can be evaluated at any x using the call() method
  # of the object returned. 
  #
  # Problems:  101 
  def poly_gen_func
    lambda {|x| self.each_with_index.inject( 0 ) {|acc, (a, i)| acc + (a * x**i)}}
  end

  # Aggregate tree node weights from the bottom up.
  #
  # Problems:  18, 67
  def tree_sum
    d = Math.sqrt( 1 + (self.length << 3) )
    raise ArgumentError, 'Array length not triangular' if d != d.to_i
  
    rows = (d.to_i - 1) >> 1
    from = self[rows*(rows - 1)/2, rows]
  
    (rows - 1).downto( 1 ) do |i|
      to = i*(i - 1)/2
      i.times {|j| from[j] = self[to + j] + from[j, 2].max}
    end
  
    from[0]
  end
end

class Integer
  # Ruby uses one bit for sign and one bit to identify integer values (as
  # opposed to pointers to objects). 
  FIXMAX = (1 << (0.size << 3) - 2) - 1
  FIXMIN = -(1 << (0.size << 3) - 2)

  # Returns the next larger integer having the same number of set bits.
  #
  # http://hackersdelight.org/hdcodetxt/snoob.c.txt
  # Problems:  105, 111, 121, 491
  def bitseq
    return 0 if 0 == self 

    smallest = self & -self
    ripple = self + smallest
    newsmall = ripple & -ripple
    ones = ((newsmall / smallest) >> 1) - 1
    
    ripple | ones
  end

  # Scores an integer on how "bouncy" it is:
  #
  #   0 = digits do not rise or fall, e.g. "222222"
  #   1 = digits strictly increase left to right, e.g. "134468"
  #   2 = digits strictly decrease left to right, e.g. "66420"
  #   3 = digits rise and fall left to right, e.g. "155349"
  #
  # Problems:  112
  def bounce
    x, r = self, self % 10
    last, score = r, 0

    while 0 < x && 3 > score
      x, r = x / 10, x % 10

      score |= 1 if r < last
      score |= 2 if r > last
      last = r
    end

    score
  end

  # Calculates a binomial coefficient. This effectively counts the number of
  # k-subsets (k distinct items from a set) possible with n items.
  #
  # Problems:  493
  def choose( k )
    return 0 if 0 > k || k > self
    return 1 if 0 == k
    (self - k + 1).upto( self ).inject( :* ) / k.fact
  end

  def stirling( k )
    return 0 if 0 > k || k > self
    return 1 if 1 == k || k == self
    (0..k).inject( 0 ) {|acc, j| acc + (-1)**(k - j) * k.choose( j ) * j**self} / k.fact
  end

  # Returns the Hamming weight (the number of set bits) in an integer.
  # The integer should fit in 32 bits.
  #
  # Problems:  315
  def hamming
    val = self - ((self >> 1) & 0x55555555)
    val = (val & 0x33333333) + ((val >> 2) & 0x33333333)
    val = ((val + (val >> 4)) & 0x0f0f0f0f) * 0x01010101
    (val >> 24) & 0x3f
  end

  # Counts k-multisubsets (k-subsets allowing for replacement but without re-
  # gard for order).
  def multichoose( k )
    (self + k - 1).choose( k )
  end

  # Sum the digits, then the digits of the result, repeating the process until
  # a single digit is generated.
  def digital_root
    0 == self ? 0 : 1 + (self - 1) % 9
  end

  # Solves Bézout's identity for known a and b: ax + by = gcd(a, b). This
  # method actually returns several quantities [x, y, gcd, qa, qb]:
  #
  #  x, y     Bézout coefficients
  #  gcd      greatest common divisor of a and b
  #  qa, qb   quotients of a and b with gcd (a/gcd and b/gcd)
  #
  # http://en.wikipedia.org/wiki/Extended_Euclidean_algorithm#Pseudocode
  def extgcd( number )
    r, pr = number, self
    s, ps = 0, 1
    t, pt = 1, 0

    while 0 != r
      q = pr / r
      pr, r = r, pr - q*r
      ps, s = s, ps - q*s
      pt, t = t, pt - q*t
    end

    # Adjust signs if necessary.
    s = -s if 0 > s ^ number
    t = -t if 0 > t ^ self

    return ps, pt, pr, t, s
  end

  # Return a sorted array of divisors.
  #
  # Problems:  12, 622
  def factors
    return [0] if 0 == self

    arr = [1]
    max = Math.sqrt( self ).to_i
    
    arr += (2..max).select {|x| 0 == self % x}
    arr |= arr.map {|x| self / x}
    arr.sort!
  end

  # Return the kth term in the Fibonacci sequence. This is a fast matrix
  # exponentiation implementation and has been generalized to include terms
  # for negative k.
  #
  # https://stackoverflow.com/a/45765630
  # Problems:  137, 138, 140, 301
  def fib
    return 0 if 0 == self

    bits = self.abs.to_s( 2 ).chars[1..-1]
    v1, v2, v3 = 1, 1, 0

    bits.each do |c|
      calc = v2*v2
      v1, v2, v3 = v1*v1 + calc, (v1+v3)*v2, v3*v3 + calc
      v1, v2, v3 = v1 + v2, v1, v2 if '1' == c
    end

    # Adjust for negative indices.
    v2 = -v2 if 0 > self && self.even?
    v2
  end

  # Returns the kth term in the Fibonacci sequence mod some integer value.
  #
  # Problems:  304
  def fibmod( m )
    return 0 if 0 == self

    bits = self.abs.to_s( 2 ).chars[1..-1]
    v1, v2, v3 = 1, 1, 0

    bits.each do |c|
      calc = (v2*v2) % m
      v1, v2, v3 = (v1*v1 + calc) % m, ((v1+v3)*v2) % m, (v3*v3 + calc) % m
      v1, v2, v3 = (v1 + v2) % m, v1, v2 if '1' == c
    end

    # Adjust for negative indices.
    v2 = -v2 % m if 0 > self && self.even?
    v2
  end

  # https://en.wikipedia.org/wiki/Pisano_period
  def pisano_period
    raise ArgumentError, 'Pisano period only valid for positive, non-zero divisors' if 1 > self
    return 1 if 1 == self

    if 1_000_000 < self && !self.miller_rabin?
      # For large n = (p1^e1)(p2^e2)...(pm^em), make use of the fact that the
      # Pisano period will be the lcm of the Pisano periods of the individual
      # prime factor powers.
      f = self.prime_factors
      f.uniq.map {|i| (i**f.count( i )).pisano_period}.reduce( 1 ) {|acc, i| acc.lcm( i )}
    else
      # Otherwise, divide Fibonacci terms until we see successive remainders
      # of 0 and 1, indicating a sequence is restarting.
      curr, succ = 0, 1
      fib = curr + succ

      (0..6*self).each do |i|
        fib = (curr + succ) % self
        curr, succ = succ, fib
        return i + 1 if 0 == curr && 1 == succ
      end
    end
  end

  # Returns true if this number is divisible by the sum of its digits.
  def harshad?( base = 10 )
    0 < self && 0 == self % sum_digits( base )
  end

  # Returns the multiplicative inverse if it exists for a specific modulus.
  # The result will satisfy the congruence a·t ≡ 1 (mod n). This is just a
  # slightly modified extgcd(), detecting the case when a and n are not
  # coprime, in which case there is no corresponding multiplicative inverse.
  #
  # http://en.wikipedia.org/wiki/Extended_Euclidean_algorithm#Computing_multiplicative_inverses_in_modular_structures   
  def inverse( modulus )
    return 1 if 1 == modulus

    t, nt = 0, 1
    r, nr = modulus, self

    while 0 != nr
      q = r / nr
      t, nt = nt, t - q*nt
      r, nr = nr, r - q*nr 
    end

    # If the number and modulus aren't coprime (gcd > 1), there can't be an
    # inverse, so return nil. Also adjust negative results to be positive.
    if 1 < r
      t = nil
    elsif 0 > t
      t += modulus
    end

    t
  end

  # Return the lower prime square root, which is the largest prime less than
  # or equal to the square root of a number. 
  def lps
    raise ArgumentError, 'lower prime square root only valid for 4+' if 4 > self
    r = Math.sqrt( self ).floor

    while true
      return r if r.prime?

      r -= 1
      r -= 1 while 0 == r & 1
    end
  end

  # Return the upper prime square root, which is the smallest prime greater
  # than or equal to the square root of a number. 
  def ups
    raise ArgumentError, 'upper prime square root only valid for 4+' if 4 > self
    r = Math.sqrt( self ).ceil

    while true
      return r if r.prime?

      r += 1
      r += 1 while 0 == r & 1
    end
  end
    
  # Return true if an integer is palindromic in base 10 (reads the same back-
  # wards and forwards). Only modestly faster than string-based version.
  #
  # Problems:  125
  def palindrome?
    return false if 0 > self

    x, div = self, 1
    div *= 10 until div * 10 > x

    while 0 < x
      q, r = x / div, x % div
      return false if q != x % 10

      x = r / 10
      div /= 100
    end

    true
  end

  # Return true if an integer contains a single instance of each numeral 1-9
  # in base 10.
  #
  # http://stackoverflow.com/questions/15189341/fast-algorithm-for-pandigital-check/15190627#15190627
  # Problems:  104, 118
  def pandigital?
    return false if 123456789 > self || 987654321 < self
    return false if self != 9 * ((0x1c71c71d * self) >> 32) 

    n, digits = self, 0
    while 0 < n
      quot = (0x1999999a * n) >> 32
      bit = 1 << (n - 10 * quot)

      return false if 0 != (digits & bit)
      digits |= bit
      n = quot
    end

    true
  end

  # Return an array of all prime numbers that divide a number.  Entries may be
  # duplicated (e.g. 234 = 2 x 3 x 3 x 13).
  #
  # Problems:  3, 47, 108, 110
  def prime_factors
    arr = []
    val, lim = self, self**0.5
    i = 2
  
    # Divide by prime numbers.  Stop when n has gotten too small to divide by
    # the latest prime (all smaller primes will have already been used).
    while i <= lim do
      while 0 == val % i
        # If the current prime is a factor, keep factoring it out as long as
        # possible.  Non-prime multiples of previous factors won't get here.     
        arr << i
        val /= i
      end
  
      # Advance to the next candidate.
      i = 1 if i == 2 
      i += 2
    end
    arr << val if 1 < val
  
    arr
  end

  # Returns true if a number is prime, otherwise false.
  #
  # Problems:  7, 27, 35, 37, 41, 46, 111, 128
  def prime?
    return true if 2 == self
    return false if 0 > self || 1 == self || 0 == self & 1
    return false if 3 < self && 1 != self % 6 && 5 != self % 6

    i = 3
    max = Math.sqrt( self ).to_i

    # Since we've already eliminated even numbers, we only have to check for
    # odd factors (since any odd non-prime will have at least one).
    while i <= max
      return false if 0 == self % i
      i += 2
    end
    
    true
  end

  # https://dzone.com/articles/miller-rabin-prime-test-ruby
  #
  # Problems:  58, 60, 118, 146, 304, 387
  def miller_rabin?
    return true if 2 == self
    return false if 0 > self || 1 == self || 0 == self & 1
    return false if 3 < self && 1 != self % 6 && 5 != self % 6
    
    d = self - 1
    d >>= 1 while 0 == d & 1
    
    20.times do
      a = 1 + rand( self - 2 )
      t = d
      y = a.modular_power( t, self )
      
      while t != self - 1 && 1 != y && y != self - 1
        y = (y * y) % self
        t <<= 1
      end
      
      return false if y != self - 1 && 0 == 1 & t
    end
    
    true
  end

  # Determine if this number is coprime with another.
  #
  # Problems:  127, 129, 130, 139
  def coprime?( number )
    return 1 == gcd( number )
  end

  # Return the sum of factors for each number less than n.
  #
  # Problems:  95
  def factorsum_sieve
    s = Array.new( self, 0 )
    i = 1

    while i < self
      (2*i...self).step( i ) {|j| s[j] += i}
      i += 1
    end

    s
  end

  # Return an array of generalized pentagonal numbers up to n.
  def genpents
    s = []
    a, b, c, d, sign = 0, 1, 0, 2, 1

    begin
      s << a
      a += b
      b += c
      c += (sign * d)
      d += 1
      sign = -sign
    end until self < a 

    s
  end

  # Return the partition function p(n) for an array of values.  A recurrence
  # relation is used to calculate this value, so computing it for n involves
  # computing it for every number less than n.  That makes a sieve approach
  # convenient since it effectively caches the intermediate results.
  #
  # Problems:  76, 78
  def partition_sieve
    s = Array.new( 1 + self, 0 )
    pents = self.genpents
    sign = [-1, 1, 1, -1]
  
    s[0] = 1
    (1..self).each do |i|
      (1...pents.length).each do |j|
        break if pents[j] > i
        s[i] += sign[j % 4] * s[i - pents[j]]
      end
    end
  
    s
  end

  # Return an array of prime numbers less than the maximum specified.  Use the
  # segmented Sieve of Eratosthenes to generate the array.
  #
  # Problems:  10, 27, 37, 49, 50, 51, 60, 70, 87, 108, 110, 118, 123, 130,
  #            131, 132, 133, 134, 187, 204, 234, 243, 315, 347, 357, 429,
  #            500, 518
  def prime_sieve( window = 65535 )
    max = Math.sqrt( self )
    smallPrimes = Array.new( 1 + max ) {|i| i & 1}

    smallPrimes[2] = 1
    i, ii, dii = 3, 9, 16

    # Identify small primes up to the square root of the upper bound.
    while ii <= max
      ii.step( max, i ).each {|j| smallPrimes[j] = 0} if 0 < smallPrimes[i]
      i, ii, dii = i + 2, ii + dii, dii + 8
    end

    currset, nextset, primes = [], [], [2]
    i, ii, dii = 2, 4, 5
    last = 3

    # Identify primes one sliding window at a time.
    0.step( self, window ) do |low|
      sieve = Array.new( window, 1 )
      high = [low + window - 1, self].min

      # Incrementally generate primes up to the square root of the current
      # upper bound of the current window. These are the primes we'll need
      # for sieving this window.
      while ii <= high
        if 0 < smallPrimes[i]
          currset << i
          nextset << (ii - low)
        end

        i, ii, dii = i + 1, ii + dii, dii + 2
      end

      # Sieve the current window
      (1...currset.length).each do |i|
        j = nextset[i]
        k = currset[i]*2

        while j < window
          sieve[j] = 0
          j += k
        end

        nextset[i] = j - window
      end

      # Collect all the identified primes in the current window.
      while last <= high
        primes << last if 0 < sieve[last - low]
        last += 2
      end
    end

    primes
  end

  # Return the prime factor powers for all values up to n. That is, factor
  # k = (p_1^e_1)(p_2^e_2)...(p_m^e_m) <= n and return an array of the p^e
  # values for each.
  #
  # Problem:  407
  def primefactor_sieve
    raise ArgumentError, 'cannot sieve factors for 0 or negative numbers' if 1 > self

    s = Array.new( 1 + self ) {Hash.new}
    s[1][1] = 1

    i = 2
    while i <= self
      m = i
      while m <= self
        (m..self).step( m ) {|j| s[j].has_key?( i ) ? s[j][i] *= i : s[j][i] = i}
        m *= i
      end

      i = 3 if 2 == i
      i += 2 until i > self || 0 == s[i].length
    end

    s.map( &:values )
  end

  # Return the sum of prime factors for each number less than n.
  def primefactorsum_sieve
    s = Array.new( self, 0 )

    i = 2
    while i < self
      (i...self).step( i ) {|j| s[j] += i}
      i += 1 until i > self || 0 == s[i]
    end

    s
  end

  # Return the prime partition function for every value less than n.
  #
  # http://math.stackexchange.com/questions/89240/prime-partition.
  # Problems:  77
  def primepartition_sieve
    sopf = self.primefactorsum_sieve
    s = Array.new( sopf )

    (2...self).each do |i|
      (1...i).each do |j|
        s[i] += sopf[j] * s[i - j]
      end
      s[i] /= i
    end

    s
  end

  # Return an array of values representing the count of Pythagorean triples
  # that sum to each integer up to and including n.  For more information, see
  #
  # http://en.wikipedia.org/wiki/Pythagorean_triple#Generating_a_triple.
  # Problems:  39, 75
  def pytriple_sieve
    s = Array.new( 1 + self, 0 )
    u, v, k = 1, 2, 1

    while true
      a = k*(v*v - u*u)
      b = k*(2*u*v)
      c = k*(v*v + u*u)

      p = a + b + c

      if self >= p
        # If p isn't too big, increment its popularity.
        s[p] += 1
        k += 1
      else
        if k > 1
          # If p is too big for the current k, advance v.
          v += 2
          k = 1
        elsif v > u + 1
          # If p is too big for the current v, advance u.
          u += 1
          v = u + 1
        else
          # If p is too big for the current u, we're done.
          break
        end

        # Skip invalid triples.
        v += 2 until v.coprime?( u )
      end
    end

    s
  end

  # Return the product of prime factors for each number less than n.
  #
  # Problems:  124, 127
  def radical_sieve
    s = Array.new( self, 1 )
  
    i = 2
    while i < self
      (i...self).step( i ) {|j| s[j] *= i}
      i += 1 until i > self || 1 == s[i]
    end
  
    s
  end

  # Returns true if at least one bit in our binary representation can't be
  # associated with a matching, higher bit in the comparand.
  #
  # Problems:  103, 105, 106
  def straddle?( n )
    m, u, v = self, 0, 0
  
    while 0 < m || 0 < n
      if 1 == m & 1
        u += 1
        v -= 1 if 0 < v
      end
      
      if 1 == n & 1
        u -= 1 if 0 < u
        v += 1
      end
      
      m >>= 1
      n >>= 1
    end
    
    0 < u && 0 < v
  end

  # Returns the reduced residue of an integer (i.e. numbers less than n that
  # are relatively prime to n). Cardinality of this set will always be ɸ(n),
  # Euler's Totient function, by definition. 
  def totatives
    raise ArgumentError, 'cannot calculate totatives for negative numbers' if 0 > self

    t = Array.new( self ) {|i| i}
    val, lim = self, self**0.5

    # Divide by prime numbers in the same way as prime_factors().
    i = 2
    while i <= lim do
      if 0 == val % i
        # Every time we find a prime divisor, sieve its multiples.
        j = i
        while j < self
          (j..self).step( j ) {|k| t[k] = nil}
          j += 1
          j += 1 until j > self || t[j].nil?
        end

        # Repeatedly factor this divisor.
        val /= i while 0 == val % i
      end

      # Advance to the next prime candidate.
      i = 1 if i == 2 
      i += 2
    end

    t[0] = nil
    t.compact
  end

  # Return an array of totient values for integers less than or equal to this
  # one.  Use an approach similar to Eratosthenes' Sieve to fill the array.
  #
  # Problems:  69, 214, 407
  def totient_sieve
    # Sieve integers up to n similar to Eratosthenes, but instead of elim-
    # nating prime multiples, multiply by the corresponding totient component
    # (1 - 1/p).  Upon completion, our sieve will hold the totient of every
    # number <= n.
    s = Array.new( 1 + self ) {|i| i}

    i = 2
    while i < self
      r = 1 - (1.0 / i)
      (i..self).step( i ) {|j| s[j] *= r}
      i += 1 until i > self || i == s[i]
    end

    s.map! {|i| i.to_i}
  end

  # Reverses and adds a number repeatedly until a palindrome is generated (or
  # too many attempts have been made).
  #
  # Problems:  55
  def lychrel?
    n = self
    s = n.to_s

    50.times do
      n += s.reverse.to_i
      s = n.to_s
      return false if s.palindromic?
    end

    true
  end

  # Add a unary factorial (!) function to all integers.
  #
  # Problems:  15, 20, 34, 53, 74, 121, 491
  def fact
    raise Math::DomainError, 'Factorial non-extendable to negative integers' if 0 > self
    (1..self).reduce( :* ) || 1
  end

  # Compute the sum of the decimal digits in this number.
  #
  # Problems:  16, 20, 56, 65, 119, 387
  def sum_digits( base = 10 )
    n, sum = self.abs, 0
    sum, n = sum + n % base, n = n / base while 0 < n
    sum
  end

  # Return the length the Collatz sequence associated with a number.
  #
  # Problems:  14
  def collatz_length
    return 0 if self < 1
 
    len = 1
    val = self

    while 1 != val
      val = (1 == val & 1) ? 3*val + 1 : val >> 1
      len += 1
    end
    
    len
  end

  # Return the length of a Farey sequence whose order matches this integer.
  #
  # Problems:  72
  def farey_length
    # By definition, |Fn| = 1 + ∑ φ(i), which involves prime factorization of
    # all integers less than or equal to n.  This is CPU-intensive, so we'll
    # sieve the totients all at once.
    1 + self.totient_sieve.inject( :+ ) 
  end

  # Returns true if a number forms part of an amicable pair.
  #
  # Problems:  21
  def amicable?
    return false if 0 == self
    p = self.factors.reduce( :+ ) - self
    p != self && p.factors.reduce( :+ ) - p == self
  end

  # Returns true if the sum of a number's divisors equals the number.
  def perfect?
    self.factors.reduce( :+ ) == self << 1
  end

  # Returns true if the sum of a number's divisors is greater than the number.
  #
  # Problems:  23
  def abundant?
    self.factors.reduce( :+ ) > self << 1
  end

  # Returns true if the sum of a number's divisiors is less than the number.
  def deficient?
    self.factors.reduce( :+ ) < self << 1
  end

  # Returns the radical, equivalent to the product of distinct prime factors.
  # By definition, the will be a square-free number.
  #
  # Problems:  127
  def rad
    self.prime_factors.uniq.reduce( :* )
  end

  # Returns true if no prime factor is repeated.
  #
  # Problems:  203
  def square_free?
    self.rad == self
  end

  # Return the continued fraction for the square root of an integer.
  #
  # §3.3.1 of http://hal-enpc.archives-ouvertes.fr/docs/00/69/17/62/PDF/ComparisonQuadraticIrrationals.pdf
  # Problems:  64, 66
  def sqrt_cf
    f = Math.sqrt( self )
    lim = f.floor
    return [lim] if f == lim
  
    quots = [[0, 1, lim]]
    i = 0
  
    for q in quots
      m = q[1] * q[2] - q[0]
      d = (self - m*m) / q[1]
      a = ((lim + m) / d).floor
  
      # Stop as soon as the fraction becomes periodic.
      break if quots.include?( [m, d, a] )
  
      quots << [m, d, a]
      i += 1
    end
  
    # The last element of each entry holds the partial denominator.
    quots.map {|q| q[2]}
  end

  # Count the numbers less than n that are coprime to n.
  def totient
    raise ArgumentError, 'totient requires positive integer' unless 0 < self

    # Euler's product formula.
    (self * self.prime_factors.uniq.inject( 1 ) {|p, i| p * (1 - 1.0/i)}).to_i
  end

  NIW_SML = %w(zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
  NIW_MED = %w(twenty thirty forty fifty sixty seventy eighty ninety)
  NIW_LRG = %w(thousand million billion trillion quadrillion quintillion sextillion septillion octillion nonillion decillion)

  # Express a number in English words.
  #
  # Problems:  17
  def in_words( depth = 0 )
    if 999 < self
      q, r = self / 1000, self % 1000
      "#{q.in_words( 1 + depth )} #{NIW_LRG[depth]}%s" % (0 != r ? " #{r.in_words( depth )}" : "")
    elsif 99 < self
      q, r = self / 100, self % 100
      "#{q.in_words( 1 + depth )} hundred%s" % (0 != r ? " and #{r.in_words( depth )}" : "")
    elsif 19 < self
      q, r = self / 10 - 2, self % 10
      "#{NIW_MED[q]}%s" % (0 != r ? "-#{NIW_SML[r]}" : "")
    else
      NIW_SML[self]
    end
  end
end

class Numeric
  # Perform exponentiation over a modulus, returning (b^e) % m. The exponent
  # e must be an integer with no more than 32 bits.
  #
  # Problems:  48, 97, 130, 132, 429
  def modular_power( e, m )
    result = 1
    base = self

    while 0 < e
      result = (result * base) % m if 1 == (e & 1)
      base = (base * base) % m
      e >>= 1;
    end

    result
  end

  # Perform tetration over a modulus, returning b^(b^(b^(... b^e))) % m, where
  # the base is raised to itself e times. The base cannot exceed 32 bits.
  #
  # http://www.nerdparadise.com/forum/openmic/5415/
  # Problems:  188
  def modular_tetrate( e, m )
    raise ArgumentError, "base and exponent must be coprime" unless self.coprime?( m )

    tot = m.totient
    base = self

    (e - 2).times {base = self.modular_power( base, tot )}
    self.modular_power( base,  m )
  end
end

class String
  # Creates a mask based on repeated characters.
  #
  # Problems:  98
  def make_mask
    # Replace each char with the index of its first appearance in the array.
    ch = self.split( '' ).map {|d| self.index( d )}

    # Compact indices so there are no gaps.  For example, "01111557" becomes
    # "01111223".
    (ch.max - ch.uniq.length).times do
      (0..9).each {|d| ch.map! {|c| c > d ? c - 1 : c} unless ch.include?( d )}
    end

    # Convert to a string of printable characters.
    ch.map {|c| (c + 48).chr}.join
  end

  # Returns true if a string equals its reverse.
  #
  # Problems:  36
  def palindromic?
    reverse.start_with?( self[0, length >> 1] )
  end
end

module ProjectEuler
  # Zeros in on an arithmetic value using binary search and a comparator
  # function that returns true for increasing values. (That is, when the
  # search should be narrowed to the upper half of a range.)
  #
  # Problems:  115, 123
  def self.bsearch( min, max, func )
    while min + 1 < max
      mid = (min + max) / 2

      if func.call( mid )
        min = mid
      else
        max = mid
      end
    end

    max
  end

  # Measures execution time of a code block.  Used for every problem.
  def self.time
    start = Time.now.to_f
    yield
    puts "%.10f%s" % [Time.now.to_f - start, 's']
  end

  # A class representing a bit-packed array of boolean values.
  class BitField
    include Enumerable
    attr_reader :size, :field

    BITWIDTH_LOG2 = 5
    BITWIDTH_MASK = (1 << BITWIDTH_LOG2) - 1

    def initialize( size, field = nil )
      @size = size
      @field = field || Array.new( 1 + (size - 1 >> BITWIDTH_LOG2), 0 )
    end

    def []=( pos, val )
      idx, bit = pos >> BITWIDTH_LOG2, 1 << (pos & BITWIDTH_MASK)

      @field[idx] |= bit if 0 != val
      @field[idx] &= ~bit if 0 == val
    end

    def []( pos )
      @field[pos >> BITWIDTH_LOG2] >> (pos & BITWIDTH_MASK) & 1
    end

    def each( &block )
      @size.times {|pos| yield self[pos]}
    end

    def hamming
      @field.reduce( 0 ) {|acc, i| acc + i.hamming}
    end
  end

  # A class representing vertices and the edges between them.
  #
  # Problems:  81, 82, 83, 107
  class Graph < Hash
    def initialize( rows = nil )
    
      self.default_proc = proc do |hash, key|
        hash[key] = [] unless hash.has_key?( key )
        hash[key]
      end

      # Initialize edge weights from an array of values, if provided.
      if rows
        w, h = rows[0].length, rows.length
        (0...w).each {|i| (0...h).each {|j| connect( i, j, rows[j][i] ) if rows[j][i]}}
      end
    end

    def add( src )
      self[src] = [] unless self.has_key?( src )
      self
    end

    def connect( src, dst, fwd, back = nil )
      edge = self[src].find {|edge| edge[0] == dst}
      if edge then edge[1] = fwd else self[src] << [dst, fwd] end

      if back
        edge = self[dst].find {|edge| edge[0] == src}
        if edge then edge[1] = back else self[dst] << [src, back] end
      end

      self
    end

    def biconnect( src, dst, len )
      connect( src, dst, len, len )
    end

    def disconnect( src, dst )
      self[src].delete_if {|edge| dst == edge[0]}
      self
    end

    def neighbors( src )
      self[src].map {|edge| edge[0]}.compact
    end

    def len( src, dst )
      edge = self[src].find {|edge| edge[0] == dst}
      edge ? edge[1] : Float::INFINITY
    end

    # Find the least-cost path between a source node and all others, or to a
    # single, specific destination node.
    def dijkstra( src, dst = nil )
      dist = Hash.new( Float::INFINITY )
      dist[src] = 0

      unvisited = self.keys.uniq
      until unvisited.empty?
        # Find the next nearest vertex (the one closest to the source based on
        # distances computed so far).
        nearest = unvisited.min_by {|node| dist[node]}

        # If distance is infinite, no more nodes can be reached.
        break if Float::INFINITY == dist[nearest]

        # If we're looking for a specific node and reached it, cut out early.
        return dist[dst] if dst && nearest == dst        

        # Refine distances for this node's neighbors. 
        neighbors = self.neighbors( nearest ) & unvisited
        neighbors.each do |node|
          alt = dist[nearest] + self.len( nearest, node )
          dist[node] = alt if alt < dist[node]
        end

        # Mark this node as visited.
        unvisited.delete( nearest )
      end

      # Return the distances from src to every node, or infinity if we were
      # looking for a specific node but never found it. 
      return dst ? Float::INFINITY : dist
    end

    # Returns the minimum spanning tree of an undirected graph (assumes for-
    # ward and backward weights are equal for each edge.
    def min_span
      mst = Graph.new

      parent = Hash.new
      dist = Hash.new( Float::INFINITY )
      dist[ self.keys[0] ] = 0

      unvisited = self.keys.uniq
      until unvisited.empty?
        # Find the next nearest vertex not already in the MST.
        nearest = unvisited.min_by {|node| dist[node]}

        # Add it to the MST, linking back to the parent node we previously saw
        # for it. (If none, this is the first addition.)
        mst.biconnect( nearest, parent[nearest], dist[nearest] ) if parent[nearest]

        # Based on the node we just added, update current distance and parent
        # on record for each of its children not yet in the MST.
        (self[nearest].transpose[0] || []).select {|v| unvisited.include?( v )}.each do |child|
          # Don't change parents unless the new one has a shorter path to the
          # child node.
          if dist[child] > self.len( nearest, child )
            parent[child] = nearest 
            dist[child] = self.len( nearest, child )
          end
        end

        unvisited.delete( nearest )
      end

      mst
    end

    # Return the sum of all (forward and backward) edge weights. For undirect-
    # ed graphs, assume result must be halved.
    def total_weight
      self.values.reduce( 0 ) {|acc, v| acc + (v.transpose[1] || [0]).reduce( :+ )}
    end

    # Return the maximum flow from src to dst, where the forward and backward
    # weights indicate flow capacity between nodes.
    def ford_fulkerson( src, dst, residue = nil )
      nodes = self.keys
      src = nodes.index( src )
      dst = nodes.index( dst )

      # Short-circuit if one or both of src/dst aren't even in the network.
      return 0 if src.nil? || dst.nil?

      # Start with a matrix representation of all the edges, for simplicity.
      residual = Array.new( nodes.size ) do |i|
        Array.new( nodes.size ) do |j|
          d = self.len( nodes[i], nodes[j] )
          Float::INFINITY == d ? 0 : d
        end
      end

      path = {}
      maxFlow = 0

      while( reachable?( src, dst, residual, path ) )
        flow = Float::INFINITY

        # Find the minimum residual capacity of all the edges along the path
        # discovered in our search.
        node = dst
        while node != src
          parent = path[node]
          flow = [flow, residual[parent][node]].min
          node = parent
        end

        # Reduce the residual capacity of each edge along the discovered path
        # by the minimum we just found.
        node = dst
        while node != src
          parent = path[node]
          residual[parent][node] -= flow
          residual[node][parent] += flow
          node = parent
        end

        # Add the flow for this path to the total.
        maxFlow += flow
      end

      # Create a graph representing the residual, if requested.
      if residue
        for src in residual.each_index
          for dst in residual.each_index
            capacity = residual[src][dst]
            residue.connect( nodes[src], nodes[dst], capacity ) if 0 < capacity
          end
        end
      end
 
      maxFlow
    end

    protected

    # Return true if there is a path from the source node to the destination
    # node. If so, path may be used to collect nodes along the way.
    def reachable?( src, dst, residual, path )
      queue = [src]
      path[src] = nil

      # Keep track of all visited nodes.
      visited = residual.each_index.map {|i| i == src}

      node = src
      while node
        # Traverse the graph breadth-first.
        residual.each_index do |i|
          next if visited[i] || 0 == residual[node][i]

          queue << i
          visited[i] = true
          path[i] = node
        end

        node = queue.shift
      end

      # Return true if we found a path from src to dst.
      visited[dst]
    end
  end

  # A class representing a cost or profit matrix on which we can call the
  # Kuhn-Munkres (aka the Hungarian algorithm) to solve the Assignment
  # Problem. Modelled directly on http://bit.ly/22Fxrai.
  #
  # Problems:  345
  class KuhnMunkres
    Label = Struct.new( :job, :worker )
    Match = Struct.new( :job, :worker )
    Slack = Struct.new( :value, :worker )

    # Return an array of job indices corresponding to the optimal assignment
    # by worker to minimize total cost.   
    def self.minimize_cost( matrix )
      @matrix = matrix.map( &:dup )
      
      # Reduce each row by its minimum value.
      @matrix.map! do |row|
        min = row.min
        row.map {|c| c - min}
      end
  
      # Reduce each column by its minimum value.
      @matrix = @matrix.transpose.map do |col|
        min = col.min
        col.map {|c| c - min}
      end.transpose
  
      # Compute an initial feasible solution by assigning zero labels to the
      # workers and by assigning to each job a label equal to the minimum cost
      # among its incident edges.
      @label = @matrix.map {|row| Label.new( row.min, 0 )} 
      @match = @matrix.map {Match.new( -1, -1 )}
  
      @matrix.each_index do |w|
        @matrix.each_index do |j|
          # Find a valid matching by greedily selecting among zero-cost matchings.
          # This is a heuristic to jump-start the augmentation algorithm.
          @match[w].job, @match[j].worker = j, w if -1 == @match[w].job &&
                                                    -1 == @match[j].worker &&
                                                     0 == @matrix[w][j] - @label[w].worker - @label[j].job
        end
      end
   
      # While there are still unassigned workers, try to find augmenting paths
      # that will allow better assignments.  
      w = @match.index {|m| -1 == m.job}
      while w
        find_matching( w )
        
        # Keep going as long as there are unassigned workers.
        w = @match.index {|m| -1 == m.job}
      end
  
      @match.map {|m| m.job}
    end
    
    # Return an array of job indices corresponding to the optimal assignment
    # by worker to maximize total profit.   
    def self.maximize_profit( matrix )
      # Convert each element from an edge weight to an edge cost. 
      max = matrix.flatten.max
      minimize_cost( matrix.map {|row| row.map {|c| max - c}} )
    end

    # Computes the total cost (or profit) for the array of worker job assign-
    # ments specified.
    def self.total( matrix, assignments )
      assignments.each_with_index.reduce( 0 ) {|acc, (j, i)| acc + matrix[i][j]}
    end

    protected
  
    def self.find_matching( w )
      committedWorkers = (0...@matrix.size).map {|idx| idx == w}
      parentWorkerByCommittedJob = @matrix.map {-1}
      minSlack = (0...@matrix.size).map {|j| Slack.new( @matrix[w][j] - @label[w].worker - @label[j].job, w)}
  
      while true do
        slack = Slack.new( Float::INFINITY, -1 )
        job = -1
   
        parentWorkerByCommittedJob.each_with_index do |parent, j|
          if -1 == parent && minSlack[j].value < slack.value
            slack = minSlack[j].dup
            job = j
          end 
        end
        
        if 0 < slack.value
          # Update labels with the specified slack by adding the slack value for
          # committed workers and by subtracting the slack value for committed jobs.
          # In addition, update the minimum slack values appropriately.
          committedWorkers.each_with_index {|busy, w| @label[w].worker += slack.value if busy}
          parentWorkerByCommittedJob.each_with_index do |parent, j|
            if -1 == parent
              minSlack[j].value -= slack.value
            else
              @label[j].job -= slack.value
            end
          end
        end
  
        parentWorkerByCommittedJob[job] = slack.worker;
  
        if -1 == @match[job].worker
          # An augmenting path has been found.
          committedJob = job
          while -1 != committedJob
            parentWorker = parentWorkerByCommittedJob[committedJob]
            temp = @match[parentWorker].job
  
            @match[parentWorker].job = committedJob
            @match[committedJob].worker = parentWorker
            committedJob = temp
          end
          
          return
        else
          # Update slack values since we increased the size of the committed
          # workers set.
          worker = @match[job].worker
          committedWorkers[worker] = true
          
          parentWorkerByCommittedJob.each_with_index do |parent, j|
            next if -1 != parent
            
            value = @matrix[worker][j] - @label[worker].worker - @label[j].job
            minSlack[j] = Slack.new( value, worker ) if minSlack[j].value > value
          end
        end
      end
    end
  end

  # A class representing card hands used in Poker.
  #
  # Problems:  54
  class PokerHand
    include Comparable
  
    RANK = "0123456789TJQKA"
  
    def initialize( cards )
      @cards = cards.sort {|x, y| RANK.index( y[0] ) <=> RANK.index( x[0]) }
      @suits = @cards.map {|card| card[1]}.join
      @cards = @cards.map {|card| card[0]}.join
    end
  
    def <=>( other )
      self.rank <=> other.rank
    end
  
    def straight?
      4 == RANK.index( @cards[0] ) - RANK.index( @cards[-1] )
    end
  
    def flush?
      @suits =~ /(.)\1\1\1\1/
    end
  
    def rank
      r = h = 0
  
      case @cards
      when /(.)\1\1\1/
        # Four of a kind
        r = 7
        h = RANK.index( $1 )
      when /(.)\1(.)\2\2|(.)\3\3(.)\4/
        # Full house
        r = 6
        a, b = RANK.index( $1 ), RANK.index( $2 ) if $1
        a, b = RANK.index( $3 ), RANK.index( $4 ) if $3
        h = a > b ? (a << 4) | b : (b << 4) | a
      when /(.)\1\1/
        # Three of a kind
        r = 3
        h = RANK.index( $1 )
      when /(.)\1.*(.)\2/
        # Two pairs
        r = 2
        a, b = RANK.index( $1 ), RANK.index( $2 )
        h = a > b ? (a << 4) | b : (b << 4) | a
      when /(.)\1/
        # Pair
        r = 1
        h = RANK.index( $1 )
      else
        if flush?
          r = straight? ? 8 : 5
        elsif straight?
          r = 4
        end
      end
  
      @cards.chars.reduce( (r << 8) | h ) {|a, c| (a << 4) | RANK.index( c )}
    end
  end

  # A class representing Roman numerals
  #
  # Problems:  89
  class Roman
    CHARS = {'I' => 1, 'V' => 5, 'X' => 10, 'L' => 50, 'C' => 100, 'D' => 500, 'M' => 1000}
    SRAHC = CHARS.invert
    FORMS = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX']

    # Compute the integer equivalent of a Roman numeral string.
    def self.to_i( s )
      last = 1001
      total = acc = 0

      s.chars.each do |c|
        value = CHARS[c]

        if value < last
          total += acc
          acc = value
        elsif value > last
          total += value - acc
          acc = 0
        else
          acc += value
        end

        last = value
      end

      total += acc
    end

    # Return the string representation of an integer value.
    def self.from_i( n )
      raise ArgumentError, 'Roman numerals must be less than 5000' unless 5000 > n
      i, m = 1, n
      acc = []

      while 0 < n
        n, d = n / 10, n % 10
        acc.unshift( FORMS[d - 1].gsub( /[XVI]/, 'X'=>SRAHC[10*i], 'V'=>SRAHC[5*i], 'I'=>SRAHC[i] ) ) if 0 < d
        i *= 10
      end

      acc.unshift( 'MMM' ) unless 4000 > m
      acc.join
    end
  end

  # A Su Doku puzzle solver.
  #
  # Problems:  96
  class SuDoku
    DIGITS = (1..9).to_a
  
    def self.constraints( grid )
      r, c, s = [], [], []
  
      # Determine which values are missing from each row, column, and subsquare.
      (0...9).each do |i| 
        r[i] = DIGITS - grid[i]
        c[i] = DIGITS - grid.map {|row| row[i]}
        s[i] = DIGITS - grid.map {|row| row[i%3 * 3, 3]}[i/3 * 3, 3].flatten
      end
  
      return r, c, s
    end

    # Return a solved version of the puzzle provided, or nil if it is not
    # solvable.
    def self.solve( puzzle )
      grid = puzzle.map( &:dup )
  
      # Substitute values as long as there are empty squares.
      while 0 < grid.flatten.count( 0 )
        r, c, s = constraints( grid )
        min, x, y = DIGITS, 0, 0
    
        # Look at each blank square in the grid and determine which values would
        # be valid there. 
        (0...9).each do |i|
          (0...9).each do |j|
            next unless 0 == grid[j][i]
    
            # Only values that are missing from the corresponding row, column,
            # and subsquare are valid.  This may be more than one number, or
            # none.  If none, the puzzle isn't solvable.
            vals = r[j] & c[i] & s[j/3 * 3 + i/3]
            return nil if 0 == vals.count
  
            # If exactly one number is valid here, hooray.  Go ahead and insert
            # it, then recompute the constraints.
            if 1 == vals.count
              grid[j][i] = vals[0]
              r, c, s = constraints( grid )
            end
  
            # Chances are (for difficult puzzles), there will be no single
            # choices.  Keep track of the first space with the fewest options
            # for later guessing.
            min, x, y = vals, i, j if vals.count < min.count
          end
        end
  
        # If there were no "easy wins" above, we must pick a square and insert
        # each of its candidate values in turn, looking for one that leads to a
        # solution.  
        if 1 < min.count
          guess = nil
  
          # Substitute each candidate value for the chosen square and solve.
          for v in min
            grid[y][x] = v
  
            # If the grid isn't solvable, recursively try the next value.  One
            # of them is guaranteed to work.
            guess = solve( grid )
            break if guess
          end
  
          # Return the solution, or nil if this path was a dead end.  In that
          # case, we'll end up backtracking in order to try a different branch.
          return guess
        end
      end
  
      grid
    end
  end

  # A simple tree structure representing parent and child nodes.
  #
  # Problems:  122, 387
  class Tree
    attr_accessor :value, :parent, :children

    def initialize( value = 0, parent = nil )
      @value = value
      @parent = parent
      @children = []
    end

    def add( value )
      @children << Tree.new( value, self )
    end

    # Do a depth-first iteration of the tree, starting with this node. The
    # function supplied will be called for each node visited.
    def dfi( func, depth = 0 )
      func.call( self, depth )
      @children.each {|c| c.dfi( func, 1 + depth )}
    end

    # Do a breadth-first iteration of the tree, starting with this node. The
    # function supplied will be called for each node visited, and should
    # return true to terminate processing. In that case, the last node to be
    # visited will be returned, otherwise this function returns nil.
    def bfi( func )
      stack, node = [], self

      while node && !func.call( node )
        stack += node.children
        node = stack.shift
      end

      node
    end
  end
end
