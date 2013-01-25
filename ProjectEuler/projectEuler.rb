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
      i += 1
    end

    arr
  end

  # Perform exponentiation over a modulus, returning (b^e) % m.
  def self.modular_power( b, e, m )
    (1..e).inject( 1 ) {|c| (c * b) % m}
  end
end
