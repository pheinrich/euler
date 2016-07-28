require 'projectEuler'

class Problem_0102
  def title; 'Triangle containment' end
  def difficulty; 15 end

  # Three distinct points are plotted at random on a Cartesian plane, for
  # which -1000 ≤ x, y ≤ 1000, such that a triangle is formed.
  #
  # Consider the following two triangles:
  #
  #      A(-340,495), B(-153,-910), C(835,-947)
  #
  #      X(-175,41), Y(-421,-714), Z(574,-645)
  #
  # It can be verified that triangle ABC contains the origin, whereas triangle
  # XYZ does not.
  #
  # Using 0102_triangles.txt, a 27K text file containing the coordinates of
  # one thousand "random" triangles, find the number of triangles for which
  # the interior contains the origin.
  #
  # NOTE: The first two examples in the file represent the triangles in the
  # example given above.

  def ccw?( p1, p2 )
    # >0 if line p1-p2 moves counterclockwise around origin
    # =0 if line p1-p2 passes through origin
    # <0 if line p1-p2 moves clockwise around origin
    p1[0] * (p2[1] - p1[1]) - p1[1] * (p2[0] - p1[0]) 
  end

  def winding( verts )
    count = 0
    verts << verts[0]

    (0..2).each do |i|
      p, q = verts[i], verts[1 + i]

      if 0 < p[1]
        count -= 1 if 0 >= q[1] && 0 > ccw?( p, q )
      else
        count += 1 if 0 < q[1] && 0 < ccw?( p, q ) 
      end
    end

    count
  end

  def solve
    tris = IO.read( 'resources/0102_triangles.txt' ).split( /,|\s/ ).map( &:to_i )
    tris.each_slice( 2 ).each_slice( 3 ).count {|tri| 0 != winding( tri )}
  end

  def solution; 'MjI4' end
  def best_time; 0.002387 end
  def effort; 20 end
  
  def completed_on; '2014-01-12' end
  def ordinality; 10_992 end
  def population; 385_228 end
  
  def refs; [] end
end
