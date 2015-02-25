require 'projectEuler'

# 0.6866s (3/15/13, #~26359)
class Problem_0052
  def title; 'Permuted multiples' end

  # It can be seen that the number, 125874, and its double, 251748, contain
  # exactly the same digits, but in a different order.
  #
  # Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x
  # contain the same digits.

  def refs; [] end
  def solution; 142_857 end
  def best_time; 0.3779 end

  def completed_on; '2013-03-15' end
  def ordinality; 26_359 end
  def population; 287_828 end

  def solve( n = 6 )
    1.upto( 999_999 ) do |i|
      a = i.to_s.codepoints.sort
      2.upto( n ) do |x|
        break unless (x*i).to_s.codepoints.sort == a
        return i if x == n
      end
    end
  end
end
