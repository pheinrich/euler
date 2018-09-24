require 'projectEuler'

class Problem_0587
  def title; 'Concave triangle' end
  def difficulty; 20 end

  # A square is drawn around a circle as shown on the left in diagram 1. We
  # shall call the blue shaded region the L-section. A line is drawn from the
  # bottom left of the square to the top right as shown on the right in the
  # first diagram. We shall call the orange shaded region a concave triangle.
  #
  # It should be clear that the concave triangle occupies exactly half of the
  # L-section.
  #
  # Two circles are placed next to each other horizontally, a rectangle is
  # drawn around both circles, and a line is drawn from the bottom left to the
  # top right as shown in the second diagram.
  #
  # This time the concave triangle occupies approximately 36.46% of the
  # L-section.
  #
  # If n circles are placed next to each other horizontally, a rectangle is
  # drawn around the n circles, and a line is drawn from the bottom left to
  # the top right, then it can be shown that the least value of n for which
  # the concave triangle occupies less than 10% of the L-section is n = 15.
  #
  # What is the least value of n for which the concave triangle occupies less
  # than 0.1% of the L-section?

  def evalIntegralAt( x )
    # Evaluate the antiderivative of a circle of radius 1, tangent to both x
    # and y axes in the first quadrant. The formula for the whole circle is
    # (x - 1)^2 + (y - 1)^2 = 1, so the lower half would be described by
    # y = 1 - √(1 - (x - 1)^2). Integrating this, we get the result below.
    -((x - 1) * Math.sqrt( -x * (x - 2) ) - 2*x + Math.asin( x - 1 )) / 2
  end

  def solve( n = 0.001 )
    # Intersect the circle with a straight line through the origin determined
    # by the number of circles we want to test. The total area of the concave
    # triangle will be the sum of the area under that straight line (from 0 to
    # the abscissa of this intersection point) plus the area under the circle
    # (from that abscissa to 1).
    ratio = n * (evalIntegralAt( 1 ) - evalIntegralAt( 0 ))
    area, circles = 0, 0

    begin
      circles += 1

      # Combine the straight line and circle equations and solve the resulting
      # quadratic to find where they intersect. We only care about the value of
      # x < 1, since that corresponds to the top of the concave triangle.
      a, b, c = 1 + circles*circles, -2*circles*(circles + 1), circles*circles
      x = (-b - Math.sqrt( b*b - 4*a*c )) / (2*a)

      # Compute the area under the straight line up to where it intersects the
      # first circle. Since that line has the equation y = x / circles, the
      # corresponding antiderivative is y = x^2 / 2*circles.
      area = x*x / (2*circles)

      # Compute the area under the circle graph.
      area += evalIntegralAt( 1 ) - evalIntegralAt( x )
    end while area > ratio

    circles
  end

  def solution; 'MjI0MA==' end
  def best_time; 0.001838 end
  def effort; 5 end

  def completed_on; '20??-??-??' end
  def ordinality; 1_937 end
  def population; 783_522 end

  def refs; [] end
end
