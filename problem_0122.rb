require 'projectEuler'

# 
class Problem_0122
  def title; 'Efficient exponentiation' end

  # The most naive way of computing n^15 requires fourteen multiplications:
  #
  #      n × n × ... × n = n^15
  #
  # But using a "binary" method you can compute it in six multiplications:
  #
  #      n    × n   = n^2
  #      n^2  × n^2 = n^4
  #      n^4  × n^4 = n^8
  #      n^8  × n^4 = n^12
  #      n^12 × n^2 = n^14
  #      n^14 × n   = n^15
  #
  # However it is yet possible to compute it in only five multiplications:
  #
  #      n    × n   = n^2
  #      n^2  × n   = n^3
  #      n^3  × n^3 = n^6
  #      n^6  × n^6 = n^12
  #      n^12 × n^3 = n^15
  #
  # We shall define m(k) to be the minimum number of multiplications to
  # compute n^k; for example m(15) = 5.
  #
  # For 1 ≤ k ≤ 200, find ∑ m(k).

  def refs
    ["http://en.wikipedia.org/wiki/Addition-chain_exponentiation",
     "https://oeis.org/A003313",
     "http://cr.yp.to/papers/pippenger.pdf",
     "http://wwwhomes.uni-bielefeld.de/achim/ac.ps.gz",
     "http://wwwhomes.uni-bielefeld.de/achim/addition_chain.html"]
  end

  def solution; end
  def best_time; end

  def completed_on; '2015-02-??' end
  def ordinality; end
  def percentile; end

  def lb( k )
    vofn = k.to_s( 2 ).count( '1' )
    Math.log2( k ).floor + Math.log2( vofn ).ceil
  end

  def chain( k, set, memo )
    return [1] if [1] == set && 0 == k
    r = set.map {|s| memo[s]}.max
    return nil if r > k
    m = set.max
    rset = set - [m]

    x = m
    (x - 1).downto( 1 ) do |xp|
      if memo[xp] < k
        x = xp
        break
      end
    end
    return nil if x < m / 2

    setp = rset + [x, m - x]
    ap = chain( k - 1, setp, memo )
    if ap
      memo[m - x] = k - 1
      return ap + [m]
    end

    nil
  end

  def solve( k = 100 )
    memo = Hash.new {0}
    chain( 1, [1, 2], memo )
    memo.inspect
  end
end
