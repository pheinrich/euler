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

  # We can classify every tile according to its angular position around the
  # unit circle, setting position 0 at the top since that's where each row
  # starts in the problem statement. Positions 1-5 then follow every 60° as we
  # work our way counter-clockwise. Depending on which of these positions each
  # tile falls (or between which pair of positions), we use different formulae
  # to calculate its six neighbors to the N, NW, SW, S, SE, and NE:
  # 
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
  # From these formula, we can derive the difference between a tile and each
  # of its neighbors. If we arrange all potential differences in ascending
  # order, it becomes obvious that for n even or odd, some deltas will always
  # be even, and thus can never be prime (>2).
  #
  # Furthermore, we can see that only in certain positions will a tile ever
  # differ from three neighbors by odd amounts (position 0 and just to the
  # right of position 0). In all other cases, at most two deltas will be odd,
  # meaning PD(n) will be 2 or less.
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
  #
  def solve( n = 2_000 )
    pd3 = [1, 2]
    base, ring = 8, 12
    
    while pd3.size < n
      # Only at position 0 and one tile to the right will there ever be three
      # odd deltas, so those are the only ones we have to check for primality.
      # Both share a delta of f = cr - 1.
      if (ring - 1).prime?
        # Check the other odd deltas for position 0. 
        pd3 << base if (ring + 1).prime? && (2*ring + 5).prime?

        # Check the other odd deltas for one tile to the right of position 0.
        pd3 << base + ring - 1 if (ring + 5).prime? && (2*ring - 7).prime?
      end

      # Advance the first tile of the current ring (base), and the number of
      # tiles it contains (cr). 
      base += ring
      ring += 6
    end

    pd3[-1]
  end

  def solution; 14_516_824_220 end
  def best_time; 0.4107 end
  def effort; 30 end

  def completed_on; '2016-01-21' end
  def ordinality; 3_254 end
  def population; 575_438 end

  def refs
    ["http://www.redblobgames.com/grids/hexagons/#coordinates"]
  end
end
