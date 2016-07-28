require 'projectEuler'

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

  def max_x( n )
    (Math.sqrt( 6*n ) / 6).to_i
  end

  def max_y( x, n )
    (-x + Math.sqrt( x*x + n/2 )).to_i
  end
  
  def max_z( x, y, n )
    (n - 2*x*y) / (2*x + 2*y)
  end

  def populate( n, memo )
    mx = max_x( n )
    (1..mx).each do |x|
      
      my = max_y( x, n )
      (x..my).each do |y|

        mz = max_z( x, y, n )
        (y..mz).each do |z|
          sum = (x*y + y*z + z*x) << 1
          d = 0

          while sum <= n
            memo[[x, y, z, d]] = sum
            sum += (x + y + z + 2*d) << 2
            d += 1
          end
        end
      end
    end
  end

  # From the problem description provided, it's clear that the number of cubes
  # necessary to cover a cuboid will initially equal its surface area. This
  # value grows as a function of the number of layers. To cover a cuboid with
  # dimensions x, y, z to a depth of d, N blocks will be necessary:
  #
  #   N = 2(xy + yz + zx) + 4d(x + y + z) + 4d(d - 1)
  #
  # The problem is to find the lowest N with exactly 1,000 unique solutions
  # [x, y, z, d], with x, y, z >= 1, d >= 0, all integers. We could solve the
  # Diophantine equation above for progressively larger values of N, stopping
  # as soon as the solution count reaches 1,000, but it turns out this takes
  # too much time. We could compute N for every x, y, z, d in some range, but
  # we need to choose the ranges correctly to be time-efficient.
  #
  # Given N, we can compute the theoretical maximum value for x, assuming y
  # and z are at least the same size and d = 0:
  #
  #   N = 2(xy + yz + zx) + 4d(x + y + z) + 4d(d - 1)
  #     = 2(xx + xx + xx)
  #     = 6x^2
  #   x = √6N / 6
  #
  # Similarly, we can compute the maximum value of y for each x when z is
  # at least as great as y, and d = 0:
  #
  #   N = 2(xy + yz + zx) + 4d(x + y + z) + 4d(d - 1)
  #     = 2(xy + yy + xy)
  #     = 2(y^2 + xy)
  #   2y^2 + 4xy - N = 0
  #   y = [-4x ± √(16x^2 + 8N)] / 4
  #     = [-4x ± √16√(x^2 + N/2)] / 4
  #     = -x ± √(x^2 + N/2)
  #
  # And finally, given x and y, we can find the largest possible z when d = 0:
  #
  #   N = 2(xy + yz + zx) + 4d(x + y + z) + 4d(d - 1)
  #     = 2(xy + yz + zx)
  #     = 2[xy + z(x + y)]
  #   N/2 - xy = z(x + y)
  #   z = (N - 2xy) / 2(x + y)
  #
  # Now for some arbitrary N, we can compute the values of x, y, z that will
  # yield a result too large when substituted into the closed-form expression
  # above. We assume that calculating the sums for all x, y, z valid for N
  # will also generate sums for N - 1, N - 2, etc. By memo-izing those sums
  # we can then look for the first value to appear 1,000 times. 
  def solve( c = 1_000 )
    memo = {}

    # Make a best-guess estimate of how large N must be before we'll find
    # enough sums. 
    populate( 20*c, memo )

    # Count all the unique sums we encountered.
    counts = Hash.new {0}
    memo.values.each {|v| counts[v] += 1}

    # Assume at least one sum appeared c times. If not -> nil error.
    counts.select {|k, v| v == c}.sort[0][0]
  end

  def solution; 'MTg1MjI=' end
  def best_time; 8.667 end
  def effort; 35 end

  def completed_on; '2016-06-30' end
  def ordinality; 3_052 end
  def population; 609_885 end

  def refs
    ['https://en.wikipedia.org/wiki/Diophantine_equation',
     'http://mathforum.org/library/drmath/view/61325.html',
     'http://stackoverflow.com/questions/5513129/solving-a-linear-diophantine-equationsee-description-for-examples/6704483#6704483',
     'http://stackoverflow.com/questions/10620461/efficient-algorithm-to-generate-all-solutions-of-a-linear-diophantine-equation-w']
  end
end
