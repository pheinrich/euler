require 'projectEuler'

# 0.8722s (2/17/13)
class Problem_0036
  def title; 'Double-base palindromes' end
  def solution; 872_187 end

  # The decimal number, 585 = 1001001001 (binary), is palindromic in both
  # bases.
  #
  # Find the sum of all numbers, less than one million, which are palindromic
  # in base 10 and base 2.
  #
  # (Please note that the palindromic number, in either base, may not include
  # leading zeros.)

  def solve( n = 1_000_000 )
    (0...n).select {|i| i.to_s.palindromic? && i.to_s( 2 ).palindromic?}.reduce( :+ )
  end
end
