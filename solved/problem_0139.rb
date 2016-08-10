require 'projectEuler'

class Problem_0139
  def title; 'Pythagorean tiles' end
  def difficulty; 50 end

  # Let (a, b, c) represent the three sides of a right angle triangle with
  # integral length sides. It is possible to place four such triangles to-
  # gether to form a square with length c.
  #
  # For example, (3, 4, 5) triangles can be placed together to form a 5 by 5
  # square with a 1 by 1 hole in the middle and it can be seen that the 5 by 5
  # square can be tiled with twenty-five 1 by 1 squares (see diagram).
  #
  # However, if (5, 12, 13) triangles were used then the hole would measure 7
  # by 7 and these could not be used to tile the 13 by 13 square.
  #
  # Given that the perimeter of the right triangle is less than one-hundred
  # million, how many Pythagorean triangles would allow such a tiling to take
  # place?

  def solve( n = 100_000_000 )
    u, v, k = 1, 2, 1
    count = 0

    # Generate a continuous sequence of Pythagorean Triples.
    while true
      a = k*(v*v - u*u)
      b = k*(2*u*v)
      c = k*(v*v + u*u)

      p = a + b + c

      if n > p
        # We found one, so check the size of the hole and see if we could tile
        # the covered square with it.
        d = (a - b).abs
        count += 1 if d == d.gcd( c )
        
        # Advance to the next potential triple.
        k += 1
      else
        if k > 1
          # If p is too big for the current k, advance v.
          v += 2
          k = 1
        elsif v > u + 1
          # If p is too big for the current v, advance u.
          u += 1
          v = u + 1
        else
          # If p is too big for the current u, we're done.
          break
        end

        # Skip invalid triples.
        v += 2 until v.coprime?( u )
      end
    end
    
    count
  end

  def solution; 'MTAwNTc3NjE=' end
  def best_time; 45.14 end
  def effort; 10 end

  def completed_on; '2016-08-10' end
  def ordinality; 3_800 end
  def population; 621_006 end

  def refs
    ['https://en.wikipedia.org/wiki/Pythagorean_triple']
  end
end
