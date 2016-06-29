require 'projectEuler'

# 
class Problem_0126
  def title; 'Cuboid layers' end
  def difficulty; 55 end

  # The minimum number of cubes to cover every visible face on a cuboid
  # measuring 3 x 2 x 1 is twenty-two (see diagram).
  #
  # If we then add a second layer to this solid it would require forty-six
  # cubes to cover every visible face, the third layer would require seventy-
  # eight cubes, and the fourth layer would require one-hundred and eighteen
  # cubes to cover every visible face.
  #
  # However, the first layer on a cuboid measuring 5 x 1 x 1 also requires
  # twenty-two cubes; similarly the first layer on cuboids measuring
  # 5 x 3 x 1, 7 x 2 x 1, and 11 x 1 x 1 all contain forty-six cubes.
  #
  # We shall define C(n) to represent the number of cuboids that contain n
  # cubes in one of its layers. So C(22) = 2, C(46) = 4, C(78) = 5, and
  # C(118) = 8.
  #
  # It turns out that 154 is the least value of n for which C(n) = 10.
  #
  # Find the least value of n for which C(n) = 1000.

  def cover2( x, y, z, n )
    2*(x*y + y*z + z*x) + 4*n*(x + y + z) + 4*n*(n - 1)
  end

  def c_of_n( n )
    total = 0
    x, y, z, d = 1, 1, 1, 0

    sum = (x*y + y*z + z*x) << 1
    while sum <= n
      total += 1 if sum == n

      sum += (x + y + z + 2*d) << 2
      d += 1
      
      if sum > n
        z += 1
        d = 0
        sum = (x*y + y*z + z*x) << 1
        
        if sum > n
          y += 1
          z = y
          sum = (x*y + y*z + z*x) << 1
          
          if sum > n
            x += 1
            y = x
            z = y
            sum = (x*y + y*z + z*x) << 1
          end
        end
      end
    end
    
    total
  end

  # From the problem description provided, it's clear that the number of cubes
  # necessary to cover a cuboid will initially equal its surface area. This
  # value grows as a function of the number of layers. To cover a cuboid with
  # dimensions x, y, z to a depth of d, N blocks will be necessary:
  #
  #   N = 2(xy + yz + zx) + 4d(x + y + z) + 4d(d - 1)
  #
  # The problem is to find the lowest N with exactly 1,000 unique solutions
  # [x, y, z, d], with x, y, z >= 1, d >= 0, all integers. We could try a
  # brute-force search (calculate N for all values of x, y, z, d in some
  # range) and count collisions, but it's unclear how we would limit the
  # search.
  #
  # Alternatively, we could work to find valid solutions for each N, instead.
  # Since we're dealing with a Diophantine equation, our strategy involves
  # substituting reasonable values for enough unknowns to leave an equation of
  # only one variable, which we can then solve for. How we choose "reasonable"
  # values and knowing when to stop depend on the equation.
  #
  # We can infer several facts from the equation above:
  #
  #   1) N >= 2(xy + yz + zx), N >= 4d(x + y + z), N >= 4d(d - 1)
  #   2) N/2 - xy - 2dx - 2dy - 2d^2 + 2d must be a positive integer
  #   3) All of the terms in 1) must be integers
  #   4) N/2, being an integer, implies that N is even
  #   5) Since x, y >= 1, the minimum value of (x + y + 2d) is 2
  #   6) N/2 - xy - 2dx - 2dy - 2d^2 + 2d >= x + y + 2d >= 2
  #   7) N/2 >= xy + 2dx + 2dy + 2d^2 - 2d + 2 => N >= 6
  #   8) N/2 - xy - 2dx - 2dy - 2d^2 + 2d is a multiple of x + y + 2d
  # 
  def solve( c = 100 )
    n = 6
    n += 2 until c == c_of_n( n )
    puts "c_of_n( #{n} ) = #{c_of_n( n )}"
    n 
  end

  def solution; end
  def best_time; end
  def effort; end

  def completed_on; '2013-01-21' end
  def ordinality; end
  def population; end

  def refs
    ["https://en.wikipedia.org/wiki/Diophantine_equation",
     "http://mathforum.org/library/drmath/view/61325.html",
     "http://stackoverflow.com/questions/5513129/solving-a-linear-diophantine-equationsee-description-for-examples/6704483#6704483",
     "http://stackoverflow.com/questions/10620461/efficient-algorithm-to-generate-all-solutions-of-a-linear-diophantine-equation-w"]
  end
end
