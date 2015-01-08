class Array
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

  # Create a Lagrange Polynomial interpolation function for the points in this
  # array. Its order will equal the length of the array (caution: large arrays
  # may suffer ringing). Array elements are expected to be (x, y) 2-tuples.
  # http://www1.maths.leeds.ac.uk/~kersale/2600/Notes/appendix_E.pdf
  #
  # Problems:  101
  def lagrange_interp_func
    Proc.new {|x|
      # Calculate the intermediate multipliers L_k(x).
      l = self.map.with_index do |a, i|
        points = self.reject.with_index {|p, j| j == i}
        points.inject( 1.0 ) {|acc, p| acc * (x - p[0]) / (self[i][0] - p[0])}
      end

      # Weight each term by its multiplier and combine. 
      self.each_with_index.reduce( 0 ) {|acc, (p, i)| acc + p[1]*l[i]}
    }
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
    Proc.new {|x| self.each_with_index.inject( 0 ) {|acc, (a, i)| acc + (a * x**i)}}
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
  # Calculates a binomial coefficient.
  def choose( k )
    return 0 if 0 > k || k > self
    return 1 if 0 == k
    (self - k + 1).upto( self ).inject( :* ) / k.fact
  end

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

  # Return the kth term in the Fibonacci sequence. This is an iterative
  # implementation (not recursive) and has been generalized to include terms
  # for negative k.
  def fib
    # Do this iteratively instead of recursively to spare the stack.
    curr, succ = 1, 0
    self.abs.times { curr, succ = succ, curr + succ }

    # Adjust for negative indices.
    succ = -succ if 0 > self && self.even?
    succ
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

  # Return the prime partition function for every value less than n.  For more
  # info, see http://math.stackexchange.com/questions/89240/prime-partition.
  #
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
  # Problems:  69, 72
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
  # Problems:  48, 97
  def modular_power( e, m )
    (1..e).inject( 1 ) {|c| (c * self) % m}
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
  # Measures execution time of a code block.  Used for every problem.
  def self.time
    start = Time.now.to_f
    yield
    puts "%.10f%s" % [Time.now.to_f - start, 's']
  end

  # A class representing vertices and the edges between them.
  #
  # Problems:  81, 82, 83
  class Graph < Hash
    def initialize
      self.default_proc = proc do |hash, key|
        hash[key] = [] unless hash.has_key?( key )
        hash[key]
      end
    end

    def add( src )
      self[src] << [] unless self.has_key?( src )
      self
    end

    def connect( src, dst, fwd, back = nil )
      self[src] << [dst, fwd]
      self[dst] << [src, back] if back
      self
    end

    def biconnect( src, dst, len )
      connect( src, dst, len, len )
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
        unvisited.delete nearest
      end

      # Return the distances from src to every node, or infinity if we were
      # looking for a specific node but never found it. 
      return dst ? Float::INFINITY : dist
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
        n, d = n.divmod( 10 )
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
end

