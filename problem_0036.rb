require 'projectEuler'

# Double-base palindromes
class Problem_0036
  # The decimal number, 585 = 1001001001 (binary), is palindromic in both
  # bases.
  #
  # Find the sum of all numbers, less than one million, which are palindromic
  # in base 10 and base 2.
  #
  # (Please note that the palindromic number, in either base, may not include
  # leading zeros.)

  def self.solve( n )
    puts( (0...n).select {|i| i.to_s.palindromic? && i.to_s(2).palindromic?}.reduce( :+ ) )
  end
end

ProjectEuler.time do
  # 872187
  Problem_0036.solve( 1000000 )
end
