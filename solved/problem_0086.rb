require 'projectEuler'

class Problem_0086
  def title; 'Cuboid route' end
  def difficulty; 35 end

  # A spider, S, sits in one corner of a cuboid room, measuring 6 by 5 by 3,
  # and a fly, F, sits in the opposite corner. By travelling on the surfaces
  # of the room the shortest "straight line" distance from S to F is 10 and
  # the path is shown (see diagram).
  #
  # However, there are up to three "shortest" path candidates for any given
  # cuboid and the shortest route doesn't always have integer length.
  #
  # By considering all cuboid rooms with integer dimensions, up to a maximum
  # size of M by M by M, there are exactly 2060 cuboids for which the shortest
  # route has integer length when M=100, and this is the least value of M for
  # which the number of solutions first exceeds two thousand; the number of
  # solutions is 1975 when M=99.
  #
  # Find the least value of M such that the number of solutions first exceeds
  # one million.

  def solve( n = 1_000_000 )
    sum = limit = 0
    
    while sum < n
      limit += 1
      limit2 = limit * limit
      
      2.upto( limit << 1 ) do |bc|
        d = Math.sqrt( limit2 + bc*bc )
        sum += (bc > limit ? 1 + limit - (1 + bc)/2 : bc/2) if d.to_i == d
      end
    end

    limit
  end

  def solution; 'MTgxOA==' end
  def best_time; 1.328 end
  def effort; 100 end

  def completed_on; '2014-01-04' end
  def ordinality; 6_000 end
  def population; 383_384 end

  def refs
    ['https://oeis.org/A143714',
     'https://oeis.org/A143715']
  end
end
