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

  def cover( x, y, z, n )
    total  = 2 * (x*y + y*z + z*x)
    total += (n << 2) * (x + y + z)
    total += (n*n - n) << 2
  end
  
  def cover2( x, y, z, n )
    2*(x*y + y*z + z*x) + 4*n*(x + y + z) + 4*n*(n - 1)
    
    # Given any MIN < x, y, z, n < MAX, what are all possible values for the
    # expression above?
    #
    # 2 * [(xy + yz + zx) + 2n(x + y + z) + 2n(n - 1)] =
    # 2 * [(xy + yz + zx) + 2n[(x + y + z) + (n - 1)]] =
    # 2 * [(xy + yz + zx) + 2n(x + y + z + n - 1)] =
    # 2 * [xy + yz + zx + 2nx + 2ny + 2nz + 2nn - 2n] =
    # 2 * [2nx + xy + 2ny + yz + 2nz + zx + 2nn - 2n] =
    # 2 * [x(2n + y) + y(2n + z) + z(2n + x) + n(2n + 2)]
  end

  def cover3( x, y, z, max, memo )
    a = (x*y + y*z + z*x) << 1
    b = (x + y + z) << 2
    
    (0..max).each do |n|
      t = a + n*b + ((n*n - n) << 2)
#      puts "(#{x}, #{y}, #{z}) = #{t} (level #{n})"
      memo[t] += 1
    end
  end

  def recurse( sum, memo )
    # Recursively solve the Diophantine equation that describes the number of
    # blocks needed to cover a cuboid of dimensions x, y, z to a depth of n:
  end

  # From the problem description provided, it's clear that the number of cubes
  # necessary to cover a cuboid will initially equal its surface area. This
  # value grows as a function of the number of layers. To cover a cuboid with
  # dimensions x, y, z to a depth of n, N blocks will be necessary:
  #
  #   N = 2(xy + yz + zx) + 4n(x + y + z) + 4n(n - 1)
  #
  # The problem is to find the lowest N with exactly 1,000 unique solutions
  # [x, y, z, n], with x, y, z >= 1, n >= 0, all integers. We could try a
  # brute-force search (calculate N for all values of x, y, z, n in some
  # range) and count collisions, but it's unclear how we would limit the
  # search.
  #
  # Alternatively, we could work to find valid solutions for each N, instead.
  # Since we're dealing with a Diophantine equation, our strategy involves
  # substituting reasonable values for enough unknowns to leave an equation of
  # only one variable, which we can then solve for. How we choose "reasonable"
  # values and knowing when to stop depend on the equation.
  #
  # Assume we are going to supply x, y, and n, then solve for z. In that case,
  #
  #   N = 2(xy + yz + zx) + 4n(x + y + z) + 4n(n - 1)
  #     = 2xy + 2yz + 2zx + 4nx + 4ny + 4nz + 4n^2 - 4n
  #     = (2xy + 4nx + 4ny + 4n^2 - 4n) + (2yz + 2zx + 4nz)
  #   N - (2xy + 4nx + 4ny + 4n^2 - 4n) = z(2x + 2y + 4n)
  #   z = [N - (2xy + 4nx + 4ny + 4n^2 - 4n)] / (2x + 2y + 4n)
  #     = N/2 - xy - 2nx - 2ny - 2n^2 + 2n / (x + y + 2n)
  #
  # From this we can infer:
  #
  #   1) N/2 - xy - 2nx - 2ny - 2n^2 + 2n must be a positive integer
  #   2) All of the terms in 1) must be integers
  #   3) N/2, being an integer, implies that N is even
  #   4) Since x, y >= 1, the minimum value of (x + y + 2n) is 2
  #   5) N/2 - xy - 2nx - 2ny - 2n^2 + 2n >= x + y + 2n >= 2
  #   6) N/2 >= xy + 2nx + 2ny + 2n^2 - 2n + 2 => N >= 6
  #   7) N/2 - xy - 2nx - 2ny - 2n^2 + 2n is a multiple of x + y + 2n
  # 
  def solve( n = 1_000 )
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
