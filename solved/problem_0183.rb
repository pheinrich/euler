require 'projectEuler'

class Problem_0183
  def title; 'Maximum product of parts' end
  def difficulty; 45 end

  # Let N be a positive integer and let N be split into k equal parts,
  # r = N/k, so that N = r + r + ... + r. Let P be the product of these parts,
  # P = r × r × ... × r = r^k.
  #
  # For example, if 11 is split into five equal parts, 11 = 2.2 + 2.2 + 2.2 +
  # 2.2 + 2.2, then P = 2.2^5 = 51.53632.
  #
  # Let M(N) = P_max for a given value of N.
  #
  # It turns out that the maximum for N = 11 is found by splitting eleven into
  # four equal parts which leads to P_max = (11/4)^4; that is, M(11) =
  # 14641/256 = 57.19140625, which is a terminating decimal.
  #
  # However, for N = 8 the maximum is achieved by splitting it into three
  # equal parts, so M(8) = 512/27, which is a non-terminating decimal.
  #
  # Let D(N) = N if M(N) is a non-terminating decimal and D(N) = -N if M(N) is
  # a terminating decimal.
  #
  # For example, ΣD(N) for 5 ≤ N ≤ 100 is 2438.
  #
  # Find ΣD(N) for 5 ≤ N ≤ 10000.

  def term?( p, q )
    d = {}
    
    while true
      p = 10 * (p % q)
      return true if 0 == p
      return false if d[p]

      # No cycle, but it didn't terminate.  Add the remainder and calculate
      # a new one.
      d[p] = true
      p = p % q
    end
  end

  def solve( a = 5, b = 10_000 )
    #
    # We want to maximize (n/x)^x, so take the derivative and set to 0 to
    # find the inflection point:
    #
    #    d
    #   -- (n/x)^x = (n/x)^x · (ln 1/x - 1 + ln n)
    #   dx
    #
    #   (n/x)^x · (ln 1/x - 1 + ln n) = 0
    #   ln n - ln x - 1 = 0
    #   ln x = ln n - 1
    #   x = e^(ln n - 1)
    #
    # Now we know for which x the fraction is the largest, but we still don't
    # know if it terminates. Assume that if (n/x)^x terminates (or doesn't),
    # n/x does the same.
    sum = 0

    a.upto( b ) do |n|
      x = Math.exp( Math.log( n ) - 1 ).round
      sum += term?( n, x ) ? -n : n
    end
    
    sum
  end

  def solution; 'NDg4NjE1NTI=' end
  def best_time; 1.342 end
  def effort; 15 end

  def completed_on; '2016-08-02' end
  def ordinality; 3_358 end
  def population; 618_944 end

  def refs; [] end
end
