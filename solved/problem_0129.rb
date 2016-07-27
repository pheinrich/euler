require 'projectEuler'

# 11.66s (7/17/16, #4293)
class Problem_0129
  def title; 'Repunit divisibility' end
  def difficulty; 45 end

  # A number consisting entirely of ones is called a repunit. We shall define
  # R(k) to be a repunit of length k; for example, R(6) = 111111.
  #
  # Given that n is a positive integer and GCD(n, 10) = 1, it can be shown
  # that there always exists a value, k, for which R(k) is divisible by n, and
  # let A(n) be the least such value of k; for example, A(7) = 6 and
  # A(41) = 5.
  #
  # The least value of n for which A(n) first exceeds ten is 17.
  #
  # Find the least value of n for which A(n) first exceeds one-million.

  def aofn( n )
# Guaranteed in this context...
#    return 0 unless n.coprime?( 10 )

    x, k = 1, 1
    until 0 == x
      x = (10*x + 1) % n
      k += 1
    end

    k
  end

  def solve( max = 1_000_000 )
    # To clarify, A(n) identifies the smallest repunit divisible by n. Looking
    # at the first few a_n:
    #
    #     n   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21
    #   A(n)  1  0  3  0  0  0  6  0  9  0  2  0  6  0  0  0 16  0 18  0  6
    #
    # It's clear the first A(n) > 10 is for n = 17. The problem statement is
    # to find the first n where A(n) > 1M. We are given that only values that
    # are coprime with 10 must be considered.
    #
    # A(n) <= n, so 1M < A(n) <= n. From the first few terms above, we can
    # use OEIS to discover A084681, which describes itself as the sequence of
    # least m such that 10^m = 1 (mod 9n). Therefore, we are looking for the
    # first number n for which 10^m mod 9n = 1 for some m.
    n = max
    n += 1 until n.coprime?( 10 )
    
    until max < aofn( n )
      n += 2
      n += 2 until n.coprime?( 10 )
    end
    
    n
  end

  def solution; 1_000_023 end
  def best_time; 0.1384 end
  def effort; 35 end

  def completed_on; '2016-07-17' end
  def ordinality; 4_293 end
  def population; 578_999 end

  def refs
    ["https://oeis.org/A002275",
     "https://oeis.org/A084681",
     "https://en.wikipedia.org/wiki/Repunit",
     "https://en.wikipedia.org/wiki/Repunit#Factorization_of_decimal_repunits"]
  end
end
