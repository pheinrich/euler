require 'projectEuler'

# 
class Problem_0150
  def title; 'Searching a triangular array for a sub-triangle having minimum-sum' end
  def difficulty; 55 end

  # In a triangular array of positive and negative integers, we wish to find a
  # sub-triangle such that the sum of the numbers it contains is the smallest
  # possible.
  #
  # See diagram for an example, where it can be easily verified that the
  # marked triangle satisfies this condition having a sum of −42.
  #
  # We wish to make such a triangular array with one thousand rows, so we
  # generate 500500 pseudo-random numbers s_k in the range ±2^19, using a type
  # of random number generator (known as a Linear Congruential Generator) as
  # follows:
  #
  #   t := 0 
  #   for k = 1 up to k = 500500: 
  #       t := (615949*t + 797807) modulo 220
  #       s_k := t−2^19
  #
  # Thus: s_1 = 273519, s_2 = −153582, s_3 = 450905 etc
  #
  # Our triangular array is then formed using the pseudo-random numbers thus:
  #
  #            s_1
  #         s_2  s_3
  #      s_4  s_5  s_6  
  #   s_7  s_8  s_9  s_10
  #           ...
  #
  # Sub-triangles can start at any element of the array and extend down as far
  # as we like (taking-in the two elements directly below it from the next row,
  # the three elements directly below from the row after that, and so on).
  # 
  # The "sum of a sub-triangle" is defined as the sum of all the elements it
  # contains.
  # 
  # Find the smallest possible sub-triangle sum.

  def solve( n = 1_000 )
  end

  def solution; end
  def best_time; end
  def effort; end

  def completed_on; '2013-01-21' end
  def ordinality; end
  def population; end

  def refs; [] end
end
