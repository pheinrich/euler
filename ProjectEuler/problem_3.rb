require 'ProjectEuler'

class Problem_3
  # The prime factors of 13195 are 5, 7, 13 and 29.
  #
  # What is the largest prime factor of the number 600851475143?

  def self.solve( n )
    f = n
    i = 2

    # Divide by prime numbers.  Stop when n has gotten too small to divide by
    # the latest prime (all smaller primes will have already been used).
    while i <= n / i do

      while n % i == 0 do
        # If the current prime is a factor, keep factoring it out as long as
        # possible.  Non-prime multiples of previous factors won't get here.     
        f = i
        n /= i
      end

      # Advance to the next candidate. 
      i += 1
    end

    puts 1 < n ? n : f
  end
end

ProjectEuler.time do
  Problem_3.solve( 600851475143 )
end
