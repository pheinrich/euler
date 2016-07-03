require 'projectEuler'

# 
class Problem_0128
  def title; 'Hexagonal tile differences' end
  def difficulty; 55 end

  # A hexagonal tile with number 1 is surrounded by a ring of six hexagonal
  # tiles, starting at "12 o'clock" and numbering the tiles 2 to 7 in an anti-
  # clockwise direction.
  #
  # New rings are added in the same fashion, with the next rings being
  # numbered 8 to 19, 20 to 37, 38 to 61, and so on. See diagram showing the
  # first three rings.
  #
  # By finding the difference between tile n and each of its six neighbours we
  # shall define PD(n) to be the number of those differences which are prime.
  #
  # For example, working clockwise around tile 8 the differences are 12, 29,
  # 11, 6, 1, and 13. So PD(8) = 3.
  #
  # In the same way, the differences around tile 17 are 1, 17, 16, 1, 11, and
  # 10, hence PD(17) = 2.
  #
  # It can be shown that the maximum value of PD(n) is 3.
  #
  # If all of the tiles for which PD(n) = 3 are listed in ascending order to
  # form a sequence, the 10th tile would be 271.
  #
  # Find the 2000th tile in this sequence.

  def fill_coords( max, map )
    # * = [0, 0]
    # {*} -> N
    # {*} -> {SW} -> {S} -> {SE} -> {NE} -> {N} -> NW -> N
    # {*} -> {SW} -> {SW} -> {S} -> {S} -> {SE} -> {SE} -> {NE} -> {NE} -> {N} -> {N} -> {NW} -> NW -> N
    # {*} -> {SW} -> {SW} -> {SW} -> {S} -> {S} -> {S} -> {SE} -> {SE} -> {SE} -> {NE} -> {NE} -> {NE} -> {N} -> {N} -> {N} -> {NW} -> {NW} -> NW -> N
    map[[0, 0]] = 1
      
    x, y = 0, -1
    n = 2
    run = 1
    
    while n < max
      map[[x, y]] = n

      # Southwest
      run.times do
        x -= 1
        y += 1
        n += 1
        map[[x, y]] = n
      end
      
      # South
      run.times do
        y += 1
        n += 1
        map[[x, y]] = n
      end
      
      # Southeast
      run.times do
        x += 1
        n += 1
        map[[x, y]] = n
      end

      # Northeast
      run.times do
        x += 1
        y -= 1
        n += 1
        map[[x, y]] = n
      end
      
      # North
      run.times do
        y -= 1
        n += 1
        map[[x, y]] = n
      end
      
      # Northwest
      (run - 1).times do
        x -= 1
        n += 1
        map[[x, y]] = n
      end
      
      n += 1
      x -= 1
      y -= 1
      run += 1
    end

    # Return the number of complete rings.
    return (y + 2).abs
  end

  def fill_diffs( rings, coords, diffs )
    (-rings..rings).each do |x|
      (-rings..rings).each do |y|
        next unless (x + y).abs <= rings
 
        n = coords[[x, y]]
        pd = 0
        
        pd += 1 if (n - coords[[x, y - 1]]).abs.prime?
        pd += 1 if (n - coords[[x - 1, y]]).abs.prime?
        pd += 1 if (n - coords[[x - 1, y + 1]]).abs.prime?
        pd += 1 if (n - coords[[x, y + 1]]).abs.prime?
        pd += 1 if (n - coords[[x + 1, y]]).abs.prime?
        pd += 1 if (n - coords[[x + 1, y - 1]]).abs.prime?

#        puts "#{n}:[#{x}, #{y}] -> #{pd}"
        diffs << n if 3 == pd
      end
    end
  end

  # Pos 0: n even = fho
  #   N  = n + cr (g)            S  = n - cr + 6 (a)
  #   NW = n + cr + 1 (h)        SE = n + cr - 1 (f)
  #   SW = n + 1                 NE = n + cr + cr + 5 (o)
  #
  # Pos 0-1: n even = bh, n odd = ag 
  #   N  = n + cr (g)            S  = n - cr + 6 (a)
  #   NW = n + cr + 1 (h)        SE = n - cr + 5 (b)
  #   SW = n + 1                 NE = n - 1
  #
  # Pos 1: n even = bh, n odd = gi
  #   N  = n + cr (g)            S  = n + 1
  #   NW = n + cr + 1 (h)        SE = n - cr + 5 (b)
  #   SW = n + cr + 2 (i)        NE = n - 1
  #
  # Pos 1-2: n even = bh, n odd = ci
  #   N  = n - 1                 S  = n + 1
  #   NW = n + cr + 1 (h)        SE = n - cr + 5 (b)
  #   SW = n + cr + 2 (i)        NE = n - cr + 4 (c)
  #
  # Pos 2: n even = hj
  #   N  = n - 1                 S  = n + cr + 3 (j)
  #   NW = n + cr + 1 (h)        SE = n + 1
  #   SW = n + cr + 2 (i)        NE = n - cr + 4 (c)
  #
  # Pos 2-3: n even = dj, n odd = ci
  #   N  = n - cr + 3 (d)        S  = n + cr + 3 (j)
  #   NW = n - 1                 SE = n + 1
  #   SW = n + cr + 2 (i)        NE = n - cr + 4 (c)
  #
  # Pos 3: n even = dj, n odd = ik
  #   N  = n - cr + 3 (d)        S  = n + cr + 3 (j)
  #   NW = n - 1                 SE = n + cr + 4 (k)
  #   SW = n + cr + 2 (i)        NE = n + 1
  #
  # Pos 3-4: n even = dj, n odd = ek
  #   N  = n - cr + 3 (d)        S  = n + cr + 3 (j)
  #   NW = n - cr + 2 (e)        SE = n + cr + 4 (k)
  #   SW = n - 1                 NE = n + 1
  #
  # Pos 4: n even = jl
  #   N  = n + 1                 S  = n + cr + 3 (j)
  #   NW = n - cr + 2 (e)        SE = n + cr + 4 (k)
  #   SW = n - 1                 NE = n + cr + 5 (l)
  #
  # Pos 4-5: n even = fl, n odd = ek
  #   N  = n + 1                 S  = n - 1
  #   NW = n - cr + 2 (e)        SE = n + cr + 4 (k)
  #   SW = n - cr + 1 (f)        NE = n + cr + 5 (l)
  #
  # Pos 5: n even = fl, n odd = km
  #   N  = n + cr + 6 (m)        S  = n - 1
  #   NW = n + 1                 SE = n + cr + 4 (k)
  #   SW = n - cr + 1 (f)        NE = n + cr + 5 (l)
  #
  # Pos 5-0*: n even = fl, n odd = gm
  #   N  = n + cr + 6 (m)        S  = n - cr (g)
  #   NW = n + 1                 SE = n - 1
  #   SW = n - cr + 1 (f)        NE = n + cr + 5 (l)
  #
  # Pos 5-0**: n even = fln, n odd = gmn
  #   N  = n + cr + 6 (m)        S  = n - cr (g)
  #   NW = n - cr + 1 (f)        SE = n - 1
  #   SW = n - (cr + cr - 7) (n) NE = n + cr + 5 (l)
  #
  #                n even      n odd
  # a = cr - 6    even              a
  # b = cr - 5          b     even
  # c = cr - 4    even              c
  # d = cr - 3          d     even
  # e = cr - 2    even              e
  # f = cr - 1          f     even
  # g = cr        even              g
  # h = cr + 1          h     even
  # i = cr + 2    even              i
  # j = cr + 3          j     even
  # k = cr + 4    even              k
  # l = cr + 5          l     even
  # m = cr + 6    even              m
  # n = 2cr - 7         n           n
  # o = 2cr + 5         o           o
  
  def walk( n )
    pd3 = [1, 2]
    cr = 12
    base = 8
    
    while pd3.size < n
      fp = (cr - 1).prime?
      hp = (cr + 1).prime?
      op = (2*cr + 5).prime?

      lp = (cr + 5).prime?
      np = (2*cr - 7).prime?
      
      pd3 << base if fp && hp && op
      pd3 << base + cr - 1 if fp && lp && np

#      puts "#{base}: #{pd3.inspect}"
            
      base += cr
      cr += 6
    end
    
    pd3
  end

  def solve( n = 2_000 )
    walk( n )[-1]
#    coords = {}
#    rings = fill_coords( 500, coords )
#    diffs = []
#    fill_diffs( rings, coords, diffs )
#    puts diffs.sort.inspect
  end

  def solution; end
  def best_time; end
  def effort; end

  def completed_on; '2013-01-21' end
  def ordinality; end
  def population; end

  def refs
    ["http://www.redblobgames.com/grids/hexagons/#coordinates"]
  end
end
