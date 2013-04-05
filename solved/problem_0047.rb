require 'projectEuler'

# Distinct primes factors
class Problem_0047
  # The first two consecutive numbers to have two distinct prime factors are:
  #
  #     14 = 2 x 7
  #     15 = 3 x 5
  #
  # The first three consecutive numbers to have three distinct prime factors
  # are:
  #
  #     644 = 2^2 x 7 x 23
  #     645 = 3 x 5 x 43
  #     646 = 2 x 17 x 19.
  #
  # Find the first four consecutive integers to have four distinct primes
  # factors. What is the first of these numbers?

  def self.solve( n )
    cur = 2
    arr = Array.new( n, 1 )

    while arr[0] != arr[-1] - n + 1
      begin
        cur += 1
      end while n != cur.prime_factors.uniq.length
      
      arr << cur
      arr.shift
    end

    puts arr[0]
  end
end

ProjectEuler.time do
  # 134043
  Problem_0047.solve( 4 )
end
