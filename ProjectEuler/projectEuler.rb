module ProjectEuler
  def self.time
    start = Time.now.to_f
    yield
    puts "%.10f%s" % [Time.now.to_f - start, 's']
  end
  
  def self.prime_factors( n )
    arr = []
    i = 2

    # Divide by prime numbers.  Stop when n has gotten too small to divide by
    # the latest prime (all smaller primes will have already been used).
    while i <= n do
      while n % i == 0 do
        # If the current prime is a factor, keep factoring it out as long as
        # possible.  Non-prime multiples of previous factors won't get here.     
        arr << i
        n /= i
      end

      # Advance to the next candidate. 
      i = 1 if 2 == i
      i += 2
    end

    arr
  end

  def self.prime?( n )
    return true if 2 == n
    return false if 2 > n || 0 == n % 2

    i = 3
    max = Math.sqrt( n ).to_i

    # Since we've already eliminated even numbers, we only have to check for
    # odd factors (since any odd non-prime will have at least one).
    while i <= max
      return false if 0 == n % i
      i += 2
    end
    
    true
  end

  # Use the Sieve of Eratosthenes to initialize an array prime numbers.
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
end
