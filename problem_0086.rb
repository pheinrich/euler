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

  def solve( n = 50 )
    sum = limit = 0

    while sum < n
      limit += 1
      puts "#{limit} (sum = #{sum})"
      
      (1..limit).each do |a|
        aa = a*a
        (1..limit).each do |b|
          bb = b*b
          (1..limit).each do |c|
            dd = aa + bb + c*c
  
            dd += 2*b*c if a > b && a > c
            dd += 2*a*c if b > a && b > c
            dd += 2*a*b if c > a && c > b
  
            sum += 1 if Math.sqrt( dd ).to_i**2 == dd
          end
        end
      end
    end

    limit
  end
end
