require 'projectEuler'

class Problem_0091
  def title; 'Right triangles with integer coordinates' end
  def difficulty; 25 end

  # The points P (x1, y1) and Q (x2, y2) are plotted at integer co-ordinates
  # and are joined to the origin, O(0,0), to form ΔOPQ (see diagram 1).
  #
  # There are exactly fourteen triangles containing a right angle that can be
  # formed when each co-ordinate lies between 0 and 2 inclusive; that is,
  # 0 ≤ x1, y1, x2, y2 ≤ 2 (see diagram 2).
  #
  # Given that 0 ≤ x1, y1, x2, y2 ≤ 50, how many right triangles can be
  # formed?

  def solve( w = 50, h = 50 )
    # Trivially countable triangles with right angle at origin, on x-axis, or
    # on y-axis.
    tris = 3 * w * h

    # Visit each point and imagine the right angle positioned there.  The
    # third point will be along the line through that point, perpendicular to
    # line from the point to the origin. 
    (1..w).each do |x|
      (1..h).each do |y|

        # Use the gcd to normalize the slope.
        gcd = x.gcd( y )

        # Extend the perpendicular both directions away from the point,
        # counting steps (each representing a valid triangle) until we reach
        # the edge of the grid.
        tris += [gcd * (w - x) / y, gcd * y / x].min
        tris += [gcd * x / y, gcd * (h - y) / x].min
      end
    end
        
    tris
  end

  def solution; 'MTQyMzQ=' end
  def best_time; 0.001917 end
  def effort; 35 end
  
  def completed_on; '2014-01-10' end
  def ordinality; 7_570 end
  def population; 384_701 end

  def refs
    ['https://oeis.org/A155154']
  end
end
