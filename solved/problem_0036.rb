require 'projectEuler'

class Problem_0036
  def title; 'Double-base palindromes' end
  def difficulty; 5 end

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

  def solution; 'ODcyMTg3' end
  def best_time; 0.5548 end
  def effort; 0 end

  def completed_on; '2013-02-17' end
  def ordinality; 36_697 end
  def population; 280_631 end

  def refs; [] end
end
