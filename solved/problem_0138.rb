require 'projectEuler'

class Problem_0138
  def title; 'Special isosceles triangles' end
  def difficulty; 45 end

  # Consider the isosceles triangle with base length, b = 16, and legs, L =
  # 17 (see diagram).
  #
  # By using the Pythagorean theorem it can be seen that the height of the
  # triangle, h = √(17^2 − 8^2) = 15, which is one less than the base length.
  #
  # With b = 272 and L = 305, we get h = 273, which is one more than the base
  # length, and this is the second smallest isosceles triangle with the prop-
  # erty that h = b ± 1.
  #
  # Find ∑ L for the twelve smallest isosceles triangles for which h = b ± 1
  # and b, L are positive integers.

  def solve( n = 12 )
    (1..n).map {|i| (6*i + 3).fib / 2}.reduce( :+ )
  end

  def solution; 'MTExODA0OTI5MDQ3MzkzMg==' end
  def best_time; 0.00009298 end
  def effort; 0 end

  def completed_on; '2016-08-10' end
  def ordinality; 3_973 end
  def population; 620_980 end

  def refs
    ['http://oeis.org/A007805']
  end
end
