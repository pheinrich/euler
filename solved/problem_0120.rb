require 'projectEuler'

class Problem_0120
  def title; 'Square remainders' end
  def difficulty; 25 end

  # Let r be the remainder when (a−1)^n + (a+1)^n is divided by a^2.
  #
  # For example, if a = 7 and n = 3, then r = 42: 6^3 + 8^3 = 728 ≡ 42 mod 49.
  # And as n varies, so too will r, but for a = 7 it turns out that r[max] =
  # 42.
  #
  # For 3 ≤ a ≤ 1000, find ∑ r[max].

  def solve( n = 1_000 )
    # We're looking for [(a-1)^n + (a+1)^n] mod a^2, which is equivalent to
    # [(a-1)^n mod a^2 + (a+1)^n mod a^2] mod a^2, so replace each term using
    # the Binomial identity for (x + y)^n, using suitable values of x and y:
    #
    #             n                                  n
    #   (a-1)^n = ∑ nCk·a^k·(-1)^(n-k);    (a+1)^n = ∑ nCk·a^k
    #            k=0                                k=0
    #
    # The sum on the left expands differently for n even or odd, so look at
    # both cases. For odd n:
    #
    #      -nC0·a^0 + nC1·a^1 - nC2·a^2 + ... + nCn-1·a^(n-1) - nCn·a^n +
    #       nC0·a^0 + nC1·a^1 + nC2·a^2 + ... + nCn-1·a^(n-1) + nCn·a^n
    #   = 2[      0 + nC1·a^1 +       0 + ... + nCn-1·a^(n-1) +       0]
    #   = 2·n·a + 2·a^2[nC3·a + nC5·a^2 + ... + nCn-2·a^(n-2) + nCn·a^n]
    #
    # Except for the first term (2na), this expression is divisible by a^2.
    # Therefore, we know [(a-1)^n + (a+1)^n] ≡ 2na mod a^2 ∀ odd n, and be-
    # cause 2na is the residue of division by a^2, we know it must be < a^2.
    #
    # To find the maximum value of 2na, first simplify 2na < a^2 to 2n < a.
    # Note that since n is odd, 2n is even, so we are looking for the largest
    # even number less than a. There are two sub-cases to consider: when a is
    # odd, this value is a - 1; when a is even, it must be a - 2.
    #
    # For even n, expand and combine the Binomial terms again to obtain:
    #
    #       nC0·a^0 - nC1·a^1 + nC2·a^2 - ... - nCn-1·a^(n-1) + nCn·a^n +
    #       nC0·a^0 + nC1·a^1 + nC2·a^2 + ... + nCn-1·a^(n-1) + nCn·a^n
    #   = 2[nC0·a^0 +       0 + nC2·a^2 + ... +             0 + nCn·a^n]
    #   = 2 + 2·a^2[nC2 + nC4·a^2 + nC6·a^4 + ... + nCn·a^(n-2)]
    #
    # This expression yields [(a-1)^n + (a+1)^n] ≡ 2 mod a^2 ∀ even n. So we
    # have deduced some constraints on the upper bound for the residue r[max]:
    #
    #   r[max] = (a - 1)·a,  for n odd, a odd
    #   r[max] = (a - 2)·a,  for n odd, a even
    #   r[max] = 2,          for n even
    #
    # The problem as it's stated allows us to ignore values of n < 3, so it's
    # enough just to compute r[max] directly for each a, choosing the right
    # formula for each one and accumulating the results. 
    (3..n).reduce( 0 ) {|acc, a| acc + a*(a - 1 & ~1)} 
  end

  def solution; 'MzMzMDgyNTAw' end
  def best_time; 0.0001409 end
  def effort; 30 end

  def completed_on; '2015-01-16' end
  def ordinality; 8_257 end
  def population; 454_494 end

  def refs
    ['https://oeis.org/A159469',
     'https://oeis.org/A176974']
  end
end
