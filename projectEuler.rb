class Integer
  # Return a sorted array of divisors.
  def factors
    return [0] if 0 == self

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
    raise Math::DomainError, 'Factorial non-extendable to negative integers' if 0 > self
    (1..self).reduce( :* ) || 1
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

  # Returns true if a number forms part of an amicable pair.
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
  def abundant?
    self.factors.reduce( :+ ) > self << 1
  end

  # Returns true if the sum of a number's divisiors is less than the number.
  def deficient?
    self.factors.reduce( :+ ) < self << 1
  end

  NIW_SML = %w(zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
  NIW_MED = %w(twenty thirty forty fifty sixty seventy eighty ninety)
  NIW_LRG = %w(thousand million billion trillion quadrillion quintillion)

  # Express a number in English words.
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

class String
  def palindromic?
    reverse.start_with?( self[0, length >> 1] )
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

  # Aggregate tree node weights from the bottom up.
  def self.tree_sum( t )
    d = Math.sqrt( 1 + (t.length << 3) )
    raise ArgumentError, 'Array length not triangular' if d != d.to_i

    rows = (d.to_i - 1) >> 1
    from = t[rows*(rows - 1)/2, rows]

    (rows - 1).downto( 1 ) do |i|
      to = i*(i - 1)/2
      i.times {|j| from[j] = t[to + j] + from[j, 2].max}
    end

    from[0]
  end
end
