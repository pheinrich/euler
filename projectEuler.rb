  class Integer
  # Return a sorted array of divisors.
  def factors
    arr = [1]
    max = Math.sqrt( self ).to_i
    
    arr += (2..max).select {|x| 0 == self % x}
    arr |= arr.map {|x| self / x}
    arr.sort!
  end

  # Return an array of all prime numbers that divide a number.  Entries may be
  # duplicated (e.g. 234 = 2 x 3 x 3 x 13).
  def prime_factors
    arr = []
    val = self
    i = 2
  
    # Divide by prime numbers.  Stop when n has gotten too small to divide by
    # the latest prime (all smaller primes will have already been used).
    while i <= val do
      while val % i == 0 do
        # If the current prime is a factor, keep factoring it out as long as
        # possible.  Non-prime multiples of previous factors won't get here.     
        arr << i
        val /= i
      end
  
      # Advance to the next candidate. 
      i = 1 if 2 == i
      i += 2
    end
  
    arr
  end

  # Returns true if a number is prime, otherwise false.
  def prime?
    return true if 2 == self
    return false if 2 > self || 0 == self % 2

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

  # Add a unary factorial (!) function to all integers.
  def fact
    (1..self).reduce( :* ) || 0
  end

  # Compute the sum of the decimal digits in this number.
  def sum_digits( base = 10 )
    self.to_s( base ).split( "" ).inject( 0 ) {|sum, n| sum + n.to_i}
  end

  # Return the Collatz sequence for the specified number.
  def collatz
    return nil if self < 1

    arr = [self]
    val = self

    while 1 != val
      val = (1 == val & 1) ? 3*val + 1 : val >> 1
      arr << val
    end
    
    arr
  end

  # Return the length the Collatz sequence associated with a number.
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
end

module ProjectEuler
  def self.time
    start = Time.now.to_f
    yield
    puts "%.10f%s" % [Time.now.to_f - start, 's']
  end

  # Return an array of prime numbers less than the maximum specified.  Use the
  # Sieve of Eratosthenes to generate the array.
  def self.eratosthenes( n )
    s = Array.new( n ) {|i| i}
    s[0] = s[1] = nil

    max = Math.sqrt( n )
    i = 2

    while i < max
      (2*i...n).step( i ) {|j| s[j] = nil}
      i += 1
      i += 1 while i < max && !s[i]
    end
    
    s.compact!
  end

  # Perform exponentiation over a modulus, returning (b^e) % m.
  def self.modular_power( b, e, m )
    (1..e).inject( 1 ) {|c| (c * b) % m}
  end

  UNDER_20  = %w(one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
  OVER_20   = %w(twenty thirty forty fifty sixty seventy eighty ninety)

  # Express a number in English words.
  def self.number_in_words( n )
    return "zero" if 0 == n
    return UNDER_20[n - 1] if 20 > n

    if 999 < n
      return "too big"
    elsif 99 < n
      hundreds, tens = (n / 100) - 1, n % 100
      return "#{UNDER_20[hundreds]} hundred" if 0 == tens
      return "%s hundred and %s" % [UNDER_20[hundreds], number_in_words( tens )]
    else
      tens, ones = (n / 10) - 2, n % 10
      return OVER_20[tens] if 0 == ones
      return "%s-%s" % [OVER_20[tens], UNDER_20[ones - 1]]
    end
  end

  THOUSANDS = %w(thousand million billion trillion quadrillion quintillion )
  def self.niw( n, depth = 0 )
    return "too big" if 0xffffffffffffffff < n
  
    if 999 < n
      s = "%s %s" % [niw( n / 1000, 1 + depth ), THOUSANDS[depth]]
      n %= 1000
    end
 
    if 99 < n
      hundreds, tens = (n / 100) - 1, n % 100
      return "#{UNDER_20[hundreds]} hundred" if 0 == tens
      return "%s hundred and %s" % [UNDER_20[hundreds], number_in_words( tens )]
    else
      tens, ones = (n / 10) - 2, n % 10
      return OVER_20[tens] if 0 == ones
      return "%s-%s" % [OVER_20[tens], UNDER_20[ones - 1]]
    end
  end
end
