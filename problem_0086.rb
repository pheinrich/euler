require 'projectEuler'

# 
class Problem_0086
  def title; 'Cuboid route' end
  def solution;  end

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

  def dist( a, b, c, x )
    d1 = Math.sqrt( b*b + x*x )
    d2 = Math.sqrt( a*a + (c - x)**2 )

    return d1 + d2, (x / d1) - (c - x) / d2
  end

  def newton( a, b, c )
    x1, x2 = 0, c
    y, dy = 0, 0

    begin
      x = (x1 + x2) / 2.0
      y, dy = dist( a, b, c, x )

      x1 = x if 0 > dy
      x2 = x if 0 < dy
    end until 0.001 > dy.abs

    y
  end

  def solve( n = 2000 )#1_000_000 )
    cuboids = {}
    cuboids.default_proc = proc do |hash, key|
      hash[key] = newton( key[0], key[1], key[2] )
    end
    
    sum = limit = 0

    while sum < n
      limit += 1
      puts "limit: #{limit}"

      (1..limit).each do |a|
        (1..limit).each do |c|
          y1 = cuboids[[a, limit, c]]
 #         puts "[#{a}, #{limit}, #{c}] = #{y1}"
          y2 = cuboids[[limit, c, a]]
 #         puts "[#{limit}, #{c}, #{a}] = #{y2}"
          y3 = cuboids[[c, a, limit]]
 #         puts "[#{c}, #{a}, #{limit}] = #{y3}"

          y = [y1, y2, y3].min
          sum += 1 if y.to_i == y.round(7)
          puts "#{y}: #{sum}"
        end
      end
  
      (1..limit-1).each do |b|
        (1..limit).each do |c|
          y1 = cuboids[[limit, b, c]]
#          puts "[#{limit}, #{b}, #{c}] = #{y1}"
          y2 = cuboids[[b, c, limit]]
#          puts "[#{b}, #{c}, #{limit}] = #{y2}"
          y3 = cuboids[[c, limit, b]]
#          puts "[#{c}, #{limit}, #{b}] = #{y3}"

          y = [y1, y2, y3].min
          sum += 1 if y.to_i == y.round(7)
          puts "#{y}: #{sum}"
        end
      end

      (1..limit-1).each do |a|
        (1..limit-1).each do |b|
          y1 = cuboids[[a, b, limit]]
#          puts "[#{a}, #{b}, #{limit}] = #{y1}"
          y2 = cuboids[[b, limit, a]]
#          puts "[#{b}, #{limit}, #{a}] = #{y2}"
          y3 = cuboids[[limit, a, b]]
#          puts "[#{limit}, #{a}, #{b}] = #{y3}"

          y = [y1, y2, y3].min
          sum += 1 if y.to_i == y.round(7)
          puts "#{y}: #{sum}"
        end
      end
    end

    limit
  end
end
