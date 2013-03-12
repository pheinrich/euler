require 'projectEuler'

# Consecutive prime sum
class Problem_0050
  # The prime 41 can be written as the sum of six consecutive primes:
  #
  #     41 = 2 + 3 + 5 + 7 + 11 + 13
  #
  # This is the longest sum of consecutive primes that adds to a prime below
  # one-hundred.
  #
  # The longest sum of consecutive primes below one-thousand that adds to a
  # prime, contains 21 terms, and is equal to 953.
  #
  # Which prime, below one-million, can be written as the sum of the most
  # consecutive primes?

  def self.solve( n )
    h = Hash.new
    ProjectEuler.eratosthenes( n ).each {|i| h[i] = true}

    p = h.keys
    max = run = 1

    0.upto( p.length - 2 ) do |u|
      s = p[u]
      (u+1).upto( p.length - 1 ) do |v|
        s += p[v]

        break if s >= n
        max, run = s, v - u if v - u > run && h[s]
      end
    end

    puts "%d (%d primes)" % [max, 1 + run]
  end
end

ProjectEuler.time do
  # 997651 (543 primes)
  Problem_0050.solve( 1000000 )
end
