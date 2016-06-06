require 'projectEuler'

# 7.234s (2/15/13, #~33914)
class Problem_0035
  def title; 'Circular primes' end
  def difficulty; 5 end

  # The number, 197, is called a circular prime because all rotations of the
  # digits: 197, 971, and 719, are themselves prime.
  #
  # There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37,
  # 71, 73, 79, and 97.
  #
  # How many circular primes are there below one million?

  def solve( n = 1_000_000 )
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

    total
  end

  def solution; 55 end
  def best_time; 4.673 end
  def effort; 5 end

  def completed_on; '2013-02-15' end
  def ordinality; 33_914 end
  def population; 280_879 end

  def refs; [] end
end
