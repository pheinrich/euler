require 'projectEuler'

# Digit fifth powers
class Problem_0030
  # Surprisingly there are only three numbers that can be written as the sum
  # of fourth powers of their digits:
  #
  #     1634 = 1^4 + 6^4 + 3^4 + 4^4
  #     8208 = 8^4 + 2^4 + 0^4 + 8^4
  #     9474 = 9^4 + 4^4 + 7^4 + 4^4
  #
  # As 1 = 1^4 is not a sum it is not included.
  #
  # The sum of these numbers is 1634 + 8208 + 9474 = 19316.
  #
  # Find the sum of all the numbers that can be written as the sum of fifth
  # powers of their digits.

  def self.solve( n )
    p = (0..9).map {|i| i**n}

    # Determine the largest number of digits possible with the powers given.
    lim = 0
    lim += 1 while 10**lim - 1 <= p[9] * lim
    lim = 10**lim - 1

    # Brute force every number with that many digits or fewer.
    puts (2..lim).select {|i| i == i.to_s.chars.inject( 0 ) {|a, x| a + p[x.to_i]}}.reduce( :+ )
  end
end

ProjectEuler.time do
  # 443839
  Problem_0030.solve( 5 )
end
