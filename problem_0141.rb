require 'projectEuler'

class Problem_0141
  def title; 'Investigating progressive numbers, n, which are also square' end
  def difficulty; 60 end

  # A positive integer, n, is divided by d and the quotient and remainder are
  # q and r respectively. In addition d, q, and r are consecutive positive
  # integer terms in a geometric sequence, but not necessarily in that order.
  #
  # For example, 58 divided by 6 has quotient 9 and remainder 4. It can also
  # be seen that 4, 6, 9 are consecutive terms in a geometric sequence (common
  # ratio 3/2). We will call such numbers, n, progressive.
  #
  # Some progressive numbers, such as 9 and 10404 = 102^2, happen to also be
  # perfect squares. The sum of all progressive perfect squares below one
  # hundred thousand is 124657.
  #
  # Find the sum of all progressive perfect squares below one trillion (10^12).

  def progressive?( n )
  end

  def solve( n = 1_000_000_000_000 )
    limit = Math.sqrt( n )

    s = 2
    sq = 4
    delta = 5
    pps = []

    while s < limit
      pf = s.prime_factors

      sq += delta
      delta += 2
    end

    puts pps.inspect
    pps.reduce( :+ )
  end

  def solution; '' end
  def best_time; 1 end
  def effort; 1 end

  def completed_on; '20??-??-??' end
  def ordinality; 1 end
  def population; 1 end

  def refs
    ['https://oeis.org/A127629',
     'https://oeis.org/A130733']
  end
end
