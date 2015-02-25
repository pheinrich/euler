require 'projectEuler'

# 0.5725s (3/12/13, #~23891)
class Problem_0050
  def title; 'Consecutive prime sum' end

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

  def refs; [] end
  def solution; 997_651 end
  def best_time; 0.3705 end

  def completed_on; '2013-03-12' end
  def ordinality; 23_891 end
  def population; 287_083 end

  def solve( n = 1_000_000 )
    h = Hash.new
    n.prime_sieve.each {|i| h[i] = true}

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

    max # puts "%d (%d primes)" % [max, 1 + run]
  end
end
