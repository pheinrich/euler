require 'projectEuler'

# 0.005430s (2/3/13, #52844)
class Problem_0017
  def title; 'Number letter counts' end
  def difficulty; 5 end

  # If the numbers 1 to 5 are written out in words: one, two, three, four,
  # five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
  #
  # If all the numbers from 1 to 1000 (one thousand) inclusive were written
  # out in words, how many letters would be used?
  #  
  # NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
  # forty-two) contains 23 letters and 115 (one hundred and fifteen) contains
  # 20 letters. The use of "and" when writing out numbers is in compliance
  # with British usage.

  def solve( n = 1_000 )
    (1..n).inject( 0 ) {|sum, i| sum + i.in_words.delete(' -').length}
  end

  def solution; 21_124 end
  def best_time; 0.003458 end
  def effort; 15 end

  def completed_on; '2013-02-03' end
  def ordinality; 52_844 end
  def population; 277_901 end

  def refs; [] end
end
