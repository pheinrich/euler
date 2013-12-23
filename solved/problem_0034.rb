require 'projectEuler'

# 39.26s
class Problem_0034
  def title; 'Digit factorials' end
  def solution; 40_730 end

  # 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
  #
  # Find the sum of all numbers which are equal to the sum of the factorial of
  # their digits.
  #
  # Note: as 1! = 1 and 2! = 2 are not sums they are not included.

  def solve()
    f = (0..9).map( &:fact )

    # Determine the largest number of digits possible with the powers given.
    lim = 0
    lim += 1 while 10**lim - 1 <= f[9] * lim
    lim = 10**lim - 1

    # Brute force every number with that many digits or fewer.
    (3..lim).select {|i| i == i.to_s.chars.inject( 0 ) {|a, x| a + f[x.to_i]}}.reduce( :+ )
  end
end
