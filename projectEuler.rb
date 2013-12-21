class Array
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
end

class Integer
  # Return a sorted array of divisors.
  #
  # Problems:  12
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
  #
  # Problems:  3, 5, 47
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
  # Problems:  7, 27, 35, 37, 41, 46, 50, 58, 60
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

  # Determine if this number is coprime with another.
  #
  # Problems:  39
  def coprime?( number )
    return 1 == gcd( number )
  end

  # Return an array of prime numbers less than the maximum specified.  Use the
  # Sieve of Eratosthenes to generate the array.
  #
  # Problems:  10, 27, 37, 49, 50, 51, 60, 70
  def prime_sieve
    s = Array.new( self ) {|i| i}
    s[0] = s[1] = nil

    max = Math.sqrt( self )
    i = 2

    while i < max
      (2*i...self).step( i ) {|j| s[j] = nil}
      i += 1
      i += 1 while max > i && !s[i]
    end
    
    s.compact!
  end

  # Return an array of values representing the count of Pythagoreon triples
  # that sum to each integer up to and including n.  For more information, see
  # http://en.wikipedia.org/wiki/Pythagorean_triple#Generating_a_triple.
  #
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

# Return an array of totient values for integers less than or equal to this
  # one.  Use an approach similar to Eratosthenes' Sieve to fill the array.
  #
  # Problems:  72
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
  # Problems:  15, 20, 34, 53
  def fact
    raise Math::DomainError, 'Factorial non-extendable to negative integers' if 0 > self
    (1..self).reduce( :* ) || 1
  end

  # Compute the sum of the decimal digits in this number.
  #
  # Problems:  16, 20, 56, 65
  def sum_digits( base = 10 )
    self.to_s( base ).split( "" ).inject( 0 ) {|sum, n| sum + n.to_i}
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

  # Return the continued fraction for the square root of an integer.
  #
  # Problems:  64, 66
  def sqrt_cf
    # From §3.3.1 of http://hal-enpc.archives-ouvertes.fr/docs/00/69/17/62/PDF/ComparisonQuadraticIrrationals.pdf
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
  #
  # Problems:  69
  def totient
    raise ArgumentError, 'totient requires positive integer' unless 0 < self

    # Euler's product formula.
    (self * self.prime_factors.uniq.inject( 1 ) {|p, i| p * (1 - 1.0/i)}).to_i
  end

  NIW_SML = %w(zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
  NIW_MED = %w(twenty thirty forty fifty sixty seventy eighty ninety)
  NIW_LRG = %w(thousand million billion trillion quadrillion quintillion)

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
  # Perform exponentiation over a modulus, returning (b^e) % m.
  #
  # Problems:  48
  def modular_power( e, m )
    (1..e).inject( 1 ) {|c| (c * self) % m}
  end
end

class String
  # Returns true if a string equals its reverse.
  #
  # Problems:  36
  def palindromic?
    reverse.start_with?( self[0, length >> 1] )
  end
end

module ProjectEuler
  # Measures execution time of a code block.  Used for every problem.
  def self.time
    start = Time.now.to_f
    yield
    puts "%.10f%s" % [Time.now.to_f - start, 's']
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
end

