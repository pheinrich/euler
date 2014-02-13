require 'projectEuler'

# 38.37s (2/12/14, #5799)
class Problem_0094
  def title; 'Almost equilateral triangles' end
  def solution; 518408346 end

  # It is easily proved that no equilateral triangle exists with integral
  # length sides and integral area. However, the almost equilateral triangle
  # 5-5-6 has an area of 12 square units.
  #
  # We shall define an almost equilateral triangle to be a triangle for which
  # two sides are equal and the third differs by no more than one unit.
  #
  # Find the sum of the perimeters of all almost equilateral triangles with
  # integral side lengths and area and whose perimeters do not exceed one
  # billion (1,000,000,000).

  def solve( n = 1_000_000_000 )
    # Since the area of a triangle is A = (bh)/2, we know that an integer area
    # implies b or h (or both) is even.  If t is the length of the non-base
    # sides, h = sqrt( t*t - (b*b)/4 ).  Since A is an integer, h must be an
    # integer and therefore t*t - (b*b)/4 must be square.  That means b is
    # even since 4 must divide b*b.  Assume t = b - 1.
    #
    # Knowing this, we can advance b through the even numbers, checking if
    # t*t - (b*b)/4 (and the corresponding term for u = b + 1) is square.
    limit = (n - 1) / 3
    sum = 0

    sq1, ds1 = 0, 1
    sq2, ds2 = 0, 1
    
    t, b, rt = 3, 4, 5
    dt, du = 11, 16

    while b < limit
      # Use the radical for t = b - 1 to compute the radical for u = b + 1. 
      ru  = rt + du
      du += 8

      # Advance to the next square number less than or equal to the radical
      # for t = b - 1.
      while sq1 < rt
        sq1 += ds1
        ds1 += 2
      end

      # If the square equals the radical, the radical must be square.
      sum += 3*b - 2 if rt == sq1

      # Advance to the next square number less than or equal to the radical
      # for u = b + 1.
      while sq2 < ru
        sq2 += ds2
        ds2 += 2
      end
      
      # If the square equals the radical, the radical must be square.
      sum += 3*b + 2 if ru == sq2

      # Advance t and b and the associated radical. 
      t  += 2
      b  += 2
      rt += dt
      dt += 6
    end

    sum
  end
end
