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
  #       t := (615949*t + 797807) modulo 2^20
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

  def linear_cong( size )
    s = Array.new( size )

    # Use the linear congruential generator (provided in the problem state-
    # ment) to initialize the triangular array.
    sum = 0

    size.times do |k|
      sum = (615_949*sum + 797_807) % 1_048_576
      s[k] = sum - 524_288
    end
    
    s
  end

  def solve( n = 1_000 )
    min = 0
    t = Array.new( n )

    # Initialize the lowest level of triangular sums with the array elements
    # themselves (produced by the linear congruential generator).
    t[0] = linear_cong( n*(n + 1) / 2 )

    # Sum progressively larger triangular areas, anchored at each array
    # element, and stack the results in consecutive arrays.
    (1...n).each do |height|
      rows = n - height
      count = rows*(rows + 1) / 2
      t[height] = Array.new( count )

      k = 0
      rows.times do |row|
        (0..row).each do
          # Compute the total sum starting at the kth element by adding the
          # subtriangles of its immediate children, then substracting the
          # elements those subtriangles share (to avoid counting them twice).
          # The sum of the shared items is equal to the subtriangle sum of
          # the element both children share.
          t[height][k] = t[0][k] + t[height-1][k+row+1] + t[height-1][k+row+2]
          t[height][k] -= t[height-2][k+2*(row+2)] if 1 < height

          # Update the current minimum, if appropriate, and advance to the
          # next triangle element.
          min = [min, t[height][k]].min
          k += 1
        end
      end
    end

    min
  end

  def solution; 'LTI3MTI0ODY4MA==' end
  def best_time; 99.93 end
  def effort; 15 end

  def completed_on; '2016-08-02' end
  def ordinality; 2_670 end
  def population; 618_901 end

  def refs; [] end
end
