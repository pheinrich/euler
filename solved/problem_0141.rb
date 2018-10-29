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

  def solve( n = 1_000_000_000_000 )
    # From the problem statement, n = dq + r and d = kr, q = kd for some k.
    # (We could set q = kr and d = kq instead, but it doesn't really matter
    # which convention we adopt.) From this we infer r < d < q. We also know
    # k must be rational or d, q wouldn't be integer values, so k = a/b. Then
    # d = ar/b and q = ad/b = (a^2)r/(b^2). Since a and b are coprime (other-
    # wise k could be reduced until they were), b^2 must divide r, which means
    # r = cb^2 for some c.
    #
    # Combining these facts, we have r = (b^2)c, d = ar/b = a(b^2)c/b = abc,
    # and q = (a^2)(b^2)c/(b^2) = (a^2)c. Substituting into n = dq + r we ob-
    # tain n = (abc)(a^2)c + (b^2)c = (a^3)b(c^2) + (b^2)c. The dominant term
    # is a^3, which must be < n, so use it as an outer limit as we search for
    # b, c values that generate perfect squares.

    # Create a hash of perfect squares to simplify future checks.
    sq = {}
    (1..Math.sqrt( n )).each {|i| sq[i*i] = i}

    # Upper bound on values of a.
    lim = Math.cbrt( n )
    sum = []

    (2...lim).each do |a|
      a3 = a*a*a
      (1...a).each do |b|
        m = b*(a3 + b)
        break if m > n
        next unless b.coprime?( a )

        c = 1
        while m < n
          sum << m if sq.has_key?( m )
          c += 1
          m = b*c*(a3*c + b)
        end
      end
    end

    sum.reduce( :+ )
  end

  def solution; 'ODc4NDU0MzM3MTU5' end
  def best_time; 2.141 end
  def effort; 60 end

  def completed_on; '2018-10-29' end
  def ordinality; 3_121 end
  def population; 793_624 end

  def refs
    ['https://oeis.org/A127629',
     'https://oeis.org/A130733']
  end
end
