require 'projectEuler'

# 0.02194s, (2/1/15, #5667)
class Problem_0121
  def title; 'Disc game prize fund' end
  def difficulty; 35 end

  # A bag contains one red disc and one blue disc. In a game of chance a
  # player takes a disc at random and its colour is noted. After each turn the
  # disc is returned to the bag, an extra red disc is added, and another disc
  # is taken at random.
  #
  # The player pays £1 to play and wins if they have taken more blue discs
  # than red discs at the end of the game.
  #
  # If the game is played for four turns, the probability of a player winning
  # is exactly 11/120, and so the maximum prize fund the banker should
  # allocate for winning in this game would be £10 before they would expect to
  # incur a loss. Note that any payout will be a whole number of pounds and
  # also includes the original £1 paid to play the game, so in the example
  # given the player actually wins £9.
  #
  # Find the maximum prize fund that should be allocated to a single game in
  # which fifteen turns are played.

  def solve( n = 15 )
    prob, lim, n = 0, (1 << n) - 1, n - 1

    # Total probability of winning is sum of the probabilities of drawing
    # sequences with more blues than reds:
    #
    #   Blue  Blue  Blue  Blue  (3 blues, 1 red)
    #   Blue  Blue  Blue  Red   (3 blues, 1 red)
    #   Blue  Blue  Red   Blue  (etc.)
    #   Blue  Red   Blue  Blue
    #   Red   Blue  Blue  Blue
    #
    # The chance of drawing a blue on the ith round is 1 out of i + 1; the
    # chance of drawing a red is i out of i + 1. Compute the probability of
    # each configuration above by multiplying the ith round chances depending
    # on the tile drawn.
    #
    # Seeing the sequence as a binary number of n bits, we just need to add
    # all the numerators generated from the multiplications above, for the
    # numbers having fewer set bits (red discs) than clear ones (blue discs).
    (1..n/2).each do |i|
      m = (1 << i) - 1

      # m starts as the smallest value having i set bits. We'll advance it
      # to all similar (valid) values.
      while m < lim
        red, bit, prod = 1, 1 << n, 1

        # Check each bit and update our running product if necessary.
        while 0 < bit
          prod *= red if 0 < m & bit
          red, bit = 1 + red, bit >> 1
        end

        # Add the probability of this sequence to the total, and move to the
        # next valid sequence having the same number of red discs (set bits).
        prob += prod
        m = m.bitseq 
      end
    end

    # Players must contribute enough to cover the house's expense for the
    # occasional payout, which happens only X out of Y times, where X is the
    # probability sum we just computed (plus 1 to account for the sequence
    # where every disc drawn is blue) and Y is denominator of the multipli-
    # cations above, (n + 1)!. (Adjust n since we reduced it, above.) 
    (n + 2).fact / (prob + 1)
  end

  def solution; 2_269 end
  def best_time; 0.02194 end
  def effort; 30 end

  def completed_on; '2015-01-15' end
  def ordinality; 5_667 end
  def population; 458_564 end

  def refs; [] end
end
