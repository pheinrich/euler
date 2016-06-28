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

  def solve( n = 1_000 )
    max = 150
    memo = Hash.new {0}

    (1..max).each do |x|
      (x..max).each do |y|
        (y..max).each do |z|
          cover3( x, y, z, 50, memo )
        end
      end
    end

    puts "memo.size = #{memo.keys.size}"
    puts "memo.max = #{memo.max_by {|k, v| v}}"
    puts memo.keys.select {|k| memo[k] == 1000}.sort.inspect
    nil
  end

  def solution; end
  def best_time; end
  def effort; end

  def completed_on; '2013-01-21' end
  def ordinality; end
  def population; end

  def refs; [] end
end
