require 'projectEuler'

class Problem_0622
  def title; 'Riffle Shuffles' end
  def difficulty; 15 end

  # A riffle shuffle is executed as follows: a deck of cards is split into two
  # equal halves, with the top half taken in the left hand and the bottom half
  # taken in the right hand. Next, the cards are interleaved exactly, with the
  # top card in the right half inserted just after the top card in the left
  # half, the 2nd card in the right half just after the 2nd card in the left
  # half, etc. (Note that this process preserves the location of the top and
  # bottom card of the deck)
  #
  # Let s(n) be the minimum number of consecutive riffle shuffles needed to
  # restore a deck of size n to its original configuration, where n is a
  # positive even number.
  #
  # Amazingly, a standard deck of 52 cards will first return to its original
  # configuration after only 8 perfect shuffles, so s(52)=8. It can be
  # verified that a deck of 86 cards will also return to its original
  # configuration after exactly 8 shuffles, and the sum of all values of n
  # that satisfy s(n)=8 is 412.
  #
  # Find the sum of all values of n that satisfy s(n)=60.

  def riffle( n, maxk )
    (1..maxk).each do |m|
      return m if 0 == (2**m - 1) % (n - 1)
    end
    nil
  end

  def solve( k = 60 )
    # Calculating the first terms of s(n) helps us identify patterns. Using
    # simple brute force array manipulation, we easily obtain:
    #
    #   number of cards, n:  2   4   6   8  10  12  14  16  18  20
    # riffles needed, s(n):  1   2   4   3   6  10  12   4   8  18
    #
    # From this we identify A002326 and determine that it matches s(n) above.
    # That is, a_0 = s(2), a_1 = s(4), ..., a_m = s(2m + 2). Since A002326 is
    # the multiplicative order of 2 mod 2n+1, it describes the smallest power
    # of 2, k, for which 2^k ≡ 1 (mod 2n+1). Then 2^k - 1 ≡ 0 (mod 2n+1), or
    # k is the smallest value where 2n + 1 divides 2^k - 1.
    f = (2**k - 1).factors.map {|i| i + 1}
    f.select {|n| k == riffle( n, k )}.reduce( :+ )
  end

  def solution; 'MzAxMDk4MzY2NjE4MjEyMzk3Mg==' end
  def best_time; 86.50 end
  def effort; 25 end

  def completed_on; '2018-08-21' end
  def ordinality; 691 end
  def population; 774919 end

  def refs
    ['https://oeis.org/A002326',
     'http://mathworld.wolfram.com/RiffleShuffle.html']
  end
end
