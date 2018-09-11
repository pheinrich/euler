require 'projectEuler'

class Problem_0142
  def title; 'Perfect Square Collection' end
  def difficulty; 45 end

  # Find the smallest x + y + z with integers x > y > z > 0 such that x + y,
  # x − y, x + z, x − z, y + z, y − z are all perfect squares.

  def match( x, y, z, hash, array )
    hash.has_key?( array[x] - array[y] ) &&
    hash.has_key?( array[x] - array[z] ) &&
    hash.has_key?( array[y] - array[z] ) &&
    hash.has_key?( x + y + 2 ) && hash.has_key?( x - y )
  end

  def solve( n = 1_000_000 )
    hash = {}
    array = []

    s = 1
    sq = 1
    delta = 3

    while sq < n
      hash[sq] = s
      array << sq

      s += 1
      sq += delta
      delta += 2
    end

    x, y, z = 2, 1, 0
    until match( x, y, z, hash, array )
      x += 1
      if x > array.length - 1
        y += 1
        if y > array.length - 2
          z += 1
          if z > array.length - 3
            puts "Not found"
            break
          end
          y = z + 1
        end
        x = y + 1
      end
    end

    puts "#{x + 1} + #{y + 1} + #{z + 1}"
    x + y + z + 3
  end

  def solution; '' end
  def best_time; 1 end
  def effort; 45 end

  def completed_on; '20??-??-??' end
  def ordinality; 1 end
  def population; 1 end

  def refs; [] end
end
