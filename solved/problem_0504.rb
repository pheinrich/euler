require 'projectEuler'

class Problem_0504
  def title; 'Square on the Inside' end
  def difficulty; 15 end

  # Let ABCD be a quadrilateral whose vertices are lattice points lying on the
  # coordinate axes as follows:
  #
  # A(a, 0), B(0, b), C(−c, 0), D(0, −d), where 1 ≤ a, b, c, d ≤ m and a, b,
  # c, d, m are integers.
  #
  # It can be shown that for m = 4 there are exactly 256 valid ways to con-
  # struct ABCD. Of these 256 quadrilaterals, 42 of them strictly contain a
  # square number of lattice points.
  #
  # How many quadrilaterals ABCD strictly contain a square number of lattice
  # points for m = 100?

  def area( a, b, c, d )
    (a + c)*(b + d) / 2 
  end
  
  def boundary( a, b, c, d )
    a.gcd( b ) + b.gcd( c ) + c.gcd( d ) + d.gcd( a )
  end

  def interior( a, b, c, d )
    area( a, b, c, d ) - boundary( a, b, c, d ) / 2 + 1
  end

  def solve( m = 100 )
    # According to Pick's Theorem, Area = I + B/2 - 1, where I is the number
    # of interior lattice points and B is the number of boundary lattice
    # points. This is helpful to us since we need to know I for each of the
    # candidate quadrilaterals from the problem statement, which will be
    # given by I = Area - B/2 + 1.
    count = 0
    square, s, ds = {}, 1, 3

    # Create a hash of all the square values we may conceivably encounter, for
    # quick comparison.
    until s > 2*m*m
      square[s] = true
      s += ds
      ds += 2
    end

    # Brute-force search all possible quadrilaterals. There is 4-way symmetry
    # that I'm not exploiting here, but I'll leave that for another day. 
    (1..m).each do |a|
      (1..m).each do |b|
        (1..m).each do |c|
          (1..m).each do |d|
            count += 1 if square[ interior( a, b, c, d ) ]
          end
        end
      end
    end

    count
  end

  def solution; 'Njk0Njg3' end
  def best_time; 63.20 end
  def effort; 10 end

  def completed_on; '2016-08-20' end
  def ordinality; 1_486 end
  def population; 623_789 end

  def refs
    ['https://en.wikipedia.org/wiki/Pick%27s_theorem']
  end
end
