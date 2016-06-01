require 'projectEuler'

# 0.00001502s (5/31/16, #3874)
class Problem_0301
  def title; 'Nim' end

  # Nim is a game played with heaps of stones, where two players take it in
  # turn to remove any number of stones from any heap until no stones remain.
  #
  # We'll consider the three-heap normal-play version of Nim, which works as
  # follows:
  #   - At the start of the game there are three heaps of stones.
  #   - On his turn the player removes any positive number of stones from any
  #     single heap.
  #   - The first player unable to move (because no stones remain) loses.
  #
  # If (n1,n2,n3) indicates a Nim position consisting of heaps of size n1, n2
  # and n3 then there is a simple function X(n1,n2,n3) — that you may look up
  # or attempt to deduce for yourself — that returns:
  #
  #   - zero if, with perfect strategy, the player about to move will event-
  #     ually lose; or
  #   - non-zero if, with perfect strategy, the player about to move will
  #     eventually win.
  #
  # For example X(1,2,3) = 0 because, no matter what the current player does,
  # his opponent can respond with a move that leaves two heaps of equal size,
  # at which point every move by the current player can be mirrored by his op-
  # ponent until no stones remain; so the current player loses. To illustrate:
  #
  #   - current player moves to (1,2,1)
  #   - opponent moves to (1,0,1)
  #   - current player moves to (0,0,1)
  #   - opponent moves to (0,0,0), and so wins.
  #
  # For how many positive integers n ≤ 230 does X(n,2n,3n) = 0 ?

  def refs; ["https://en.wikipedia.org/wiki/Nim"] end
  def solution; 2_178_309 end
  def best_time; 0.00001502 end

  def completed_on; '2016-05-31' end
  def ordinality; 3_874 end
  def population; 566_837 end

  def solve( exp = 30 )
    # According to Wikipedia, in normal Nim play, "the winning strategy is to
    # finish every move with a nim-sum of 0" (where nim-sum is the XOR of all
    # heap sizes). The pattern is easily identified for n = 2^exp:
    #
    #   exp     0    1    2    3    4    5    6    7    8    9   10
    #   count   1    2    3    5    8   13   21   34   55   89  144
    #
    # (count computed as the number of i ≤ n where i^(2*i)^(3*i) == 0.)
    (exp + 2).fib
  end
end
