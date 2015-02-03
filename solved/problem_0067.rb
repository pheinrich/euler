require 'projectEuler'

# 0.005959s (2/5/13, #~41780)
class Problem_0067
  def title; 'Maximum path sum II' end

  # By starting at the top of the triangle below and moving to adjacent
  # numbers on the row below, the maximum total from top to bottom is 23.
  #
  #             3
  #            7 4
  #           2 4 6
  #          8 5 9 3
  #
  # That is, 3 + 7 + 4 + 9 = 23.
  # 
  # Find the maximum total from top to bottom in 0067_triangle.txt, a 15K text
  # file containing a triangle with one-hundred rows.
  #
  # NOTE: This is a much more difficult version of Problem 18. It is not
  # possible to try every route to solve this problem, as there are 2^99
  # altogether! If you could check one trillion (10^12) routes every second it
  # would take over twenty billion years to check them all. There is an
  # efficient algorithm to solve it. ;o)

  def refs; [] end
  def solution; 7_273 end
  def best_time; 0.005959 end
  
  def completed_on; '2013-02-15' end
  def ordinality; 41_780 end
  def percentile; 87.53 end

  def solve
    t = IO.read( 'resources/0067_triangle.txt' ).split.map(&:to_i)
    t.tree_sum
  end
end
