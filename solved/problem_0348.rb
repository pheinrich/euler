require 'projectEuler'

class Problem_0348
  def title; 'Sum of a square and a cube' end
  def difficulty; 25 end

  # Many numbers can be expressed as the sum of a square and a cube. Some of
  # them in more than one way.
  #
  # Consider the palindromic numbers that can be expressed as the sum of a
  # square and a cube, both greater than 1, in exactly 4 different ways. For
  # example, 5229225 is a palindromic number and it can be expressed in ex-
  # actly 4 different ways:
  #
  #   2285^2 + 20^3
  #   2223^2 + 66^3
  #   1810^2 + 125^3
  #   1197^2 + 156^3
  #
  # Find the sum of the five smallest such palindromic numbers.

  def sols( n, sq, cb )
    count = 0

    # Subtract cubes until they're too big to produce a positive difference.
    cb.each do |c|
      break if c > n - 1
      count += 1 if sq.has_key?( n - c )
    end
    
    count
  end

  def gen_pals( len )
    # Generate an array of all palindromic numbers having exactly len digits.
    # Use brute force string manipulation.
    front = (len - 1) / 2
    back = len - front - 1

    low = 10**front
    high = 10*low - 1
    pals = []

    (low..high).each do |i|
      s = i.to_s
      pals << (s + s[0, back].reverse).to_i
    end
    
    pals
  end

  def solve( n = 5 )
    # Nothing sneaky here... Pre-compute a bunch of squares/cubes, then step
    # through the palindromic numbers. (We generate them methodically to have
    # more and more digits, as needed.)
    found = []
    len = 0

    sq, cb = {}, []
    (1..50_000).each {|i| sq[i*i] = i; cb << i*i*i}

    while n > found.size
      len += 1
      pals = gen_pals( len )

      pals.each do |p|
        found << p if 4 == sols( p, sq, cb )
        break unless n > found.size
      end
    end

    found[0, n].reduce( :+ )
  end

  def solution; 'MTAwNDE5NTA2MQ==' end
  def best_time; 10.94 end
  def effort; 25 end

  def completed_on; '2016-08-17' end
  def ordinality; 1_781 end
  def population; 623_000 end

  def refs
    ['https://www.emis.de/journals/GM/vol12nr1/andrica/andrica.pdf',
     'https://oeis.org/A171385']
  end
end
