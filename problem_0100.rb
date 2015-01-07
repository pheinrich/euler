require 'projectEuler'

# 
class Problem_0100
  def title; 'Arranged probability' end
  def solution;  end

  # If a box contains twenty-one coloured discs, composed of fifteen blue
  # discs and six red discs, and two discs were taken at random, it can be
  # seen that the probability of taking two blue discs,
  #
  #      P(BB) = (15/21)×(14/20) = 1/2.
  #
  # The next such arrangement, for which there is exactly 50% chance of taking
  # two blue discs at random, is a box containing eighty-five blue discs and
  # thirty-five red discs.
  #
  # By finding the first arrangement to contain over 10^12 = 1,000,000,000,000
  # discs in total, determine the number of blue discs that the box would
  # contain.

  def solve2( n = 1_000_000_000_000 )
    frac = Math.sqrt( 2 ) / 2
    blue = n * frac + 1

    square = n * (n - 1)
    delta = n << 1

    20000000.times do
      b = blue.to_i
      break if 2 * b * (b - 1) == square

      blue += frac
      square += delta
      delta += 2
    end

    puts "n = #{1 + Math.sqrt( square ).to_i}"
    blue.to_i
  end

  def solve3( n = 4684662 )
    blue = nil

    z = n*(n - 1)
    radZ = 1 + 2*z   # 1 + 2z MUST be square or no solution exists for n
    rootRadZ = (Math.sqrt( radZ ) + 0.5).to_i   # root of closest square number >= radZ

    while blue.nil? do
      x = (1 + rootRadZ) / 2
      radX = 1 + 8*x*(x - 1)
      rootRadX = Math.sqrt( radX ).to_i

      blue = x if rootRadX * rootRadX == radX
      rootRadZ += 1
    end

    puts "N = #{(1 + Math.sqrt(1 + 8*blue*(blue - 1))).to_i / 2}"
    blue
  end

  def solve4( n = 159_140_521 )
    blue = nil

    z = n*(n - 1)
    radZ = 1 + 2*z   # radZ MUST be square or no solution exists for n

    rootRadZ = (Math.sqrt( radZ ) + 0.5).to_i   # root of closest square number >= radZ
    square = rootRadZ*rootRadZ   # closest square number >= radZ
    deltaRadZ = 4*n
    deltaSquare = 2*rootRadZ + 1

    while radZ != square do
#      puts "n = #{n}, radZ = #{radZ}"
#      puts "  rootRadZ = #{rootRadZ}, deltaRadZ = #{deltaRadZ}"
#      puts "  square = #{square}, deltaSquare = #{deltaSquare}"

      while radZ < square
        n += 1
        radZ += deltaRadZ
        deltaRadZ += 4
      end

      while square < radZ
        rootRadZ += 1
        square += deltaSquare
        deltaSquare += 2
      end
    end

    puts "N = #{n}"
    (rootRadZ + 1) / 2
  end
  
  def solve( n = 5 )
  end
end
