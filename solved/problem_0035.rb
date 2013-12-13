require 'projectEuler'

# Circular primes
class Problem_0035
  # The number, 197, is called a circular prime because all rotations of the
  # digits: 197, 971, and 719, are themselves prime.
  #
  # There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37,
  # 71, 73, 79, and 97.
  #
  # How many circular primes are there below one million?

  def self.solve( n )
    total = 0

    (2...n).each do |i|
      str = i.to_s.chars.to_a
      prime = true

      # Rotate every digit into the first position as long as the resulting
      # number continues to be prime.
      str.length.times do
        prime = str.join.to_i.prime?
        break if !prime
        str.rotate!
      end

      total += 1 if prime
    end

    puts total
  end
end

ProjectEuler.time do
  # 55 (9.877s)
  Problem_0035.solve( 1000000 )
end
