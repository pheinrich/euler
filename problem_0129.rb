require 'projectEuler'

# 
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

  R = (1..15).map {|i| (10**i - 1) / 9}

  def aofn( n )
    R.find {|r| 0 == r % n}.to_s.size
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
    # A(n) <= n, so 1M < A(n) <= n.
    #
  end

  def solution; end
  def best_time; end
  def effort; end

  def completed_on; '2013-01-21' end
  def ordinality; end
  def population; end

  def refs
    ["https://oeis.org/A002275",
     "https://en.wikipedia.org/wiki/Repunit",
     "https://en.wikipedia.org/wiki/Repunit#Factorization_of_decimal_repunits"]
  end
end
