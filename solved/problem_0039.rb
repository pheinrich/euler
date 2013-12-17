require 'projectEuler'

# Integer right triangles
class Problem_0039
  # If p is the perimeter of a right angle triangle with integral length
  # sides, {a,b,c}, there are exactly three solutions for p = 120.
  #
  #     {20,48,52}, {24,45,51}, {30,40,50}
  #
  # For which value of p <= 1000, is the number of solutions maximised?

  def self.solve( n )
    count = Array.new( 1 + n, 0 )
    u, v, k = 1, 2, 1

    while true
      a = k*(v*v - u*u)
      b = k*(2*u*v)
      c = k*(v*v + u*u)

      p = a + b + c

      if n >= p
        # If p isn't too big, increment its popularity.
        count[p] += 1
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
        v += 2 while !v.coprime?( u )
      end
    end

    puts "count(%d) = %d" % [count.index( count.max ), count.max]
  end
end

ProjectEuler.time do
  # count(840) = 8 (0.001001s)
  Problem_0039.solve( 1000 )
end
