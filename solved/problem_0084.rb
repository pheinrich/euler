require 'projectEuler'

# 0.4240s (12/30/13, #5887)
class Problem_0084
  def title; 'Monopoly odds' end
  def solution; 101_524 end

  # In the game, Monopoly, the standard board is set up in the following way:
  #
  #     GO  A1  CC1 A2  T1  R1  B1  CH1 B2  B3  JAIL
  #     H2                                      C1
  #     T2                                      U1
  #     H1                                      C2
  #     CH3                                     C3
  #     R4                                      R2
  #     G3                                      D1
  #     CC3                                     CC2
  #     G2                                      D2
  #     G1                                      D3
  #     G2J F3  U2  F2  F1  R3  E3  E2  CH2 E1  FP
  #
  # A player starts on the GO square and adds the scores on two 6-sided dice
  # to determine the number of squares they advance in a clockwise direction.
  # Without any further rules we would expect to visit each square with equal
  # probability: 2.5%. However, landing on G2J (Go To Jail), CC (community
  # chest), and CH (chance) changes this distribution.
  #
  # In addition to G2J, and one card from each of CC and CH, that orders the
  # player to go directly to jail, if a player rolls three consecutive
  # doubles, they do not advance the result of their 3rd roll. Instead they
  # proceed directly to jail.
  #
  # At the beginning of the game, the CC and CH cards are shuffled. When a
  # player lands on CC or CH they take a card from the top of the respective
  # pile and, after following the instructions, it is returned to the bottom
  # of the pile. There are sixteen cards in each pile, but for the purpose of
  # this problem we are only concerned with cards that order a movement; any
  # instruction not concerned with movement will be ignored and the player
  # will remain on the CC/CH square.
  #
  #     * Community Chest (2/16 cards):
  #       1.  Advance to GO
  #       2.  Go to JAIL
  #     * Chance (10/16 cards):
  #       1.  Advance to GO
  #       2.  Go to JAIL
  #       3.  Go to C1
  #       4.  Go to E3
  #       5.  Go to H2
  #       6.  Go to R1
  #       7.  Go to next R (railway company)
  #       8.  Go to next R
  #       9.  Go to next U (utility company)
  #       10. Go back 3 squares.
  #
  # The heart of this problem concerns the likelihood of visiting a particular
  # square. That is, the probability of finishing at that square after a roll.
  # For this reason it should be clear that, with the exception of G2J for
  # which the probability of finishing on it is zero, the CH squares will have
  # the lowest probabilities, as 5/8 request a movement to another square, and
  # it is the final square that the player finishes at on each roll that we
  # are interested in. We shall make no distinction between "Just Visiting"
  # and being sent to JAIL, and we shall also ignore the rule about requiring
  # a double to "get out of jail", assuming that they pay to get out on their
  # next turn.
  #
  # By starting at GO and numbering the squares sequentially from 00 to 39 we
  # can concatenate these two-digit numbers to produce strings that correspond
  # with sets of squares.
  #
  # Statistically it can be shown that the three most popular squares, in
  # order, are JAIL (6.24%) = Square 10, E3 (3.18%) = Square 24, and GO
  # (3.09%) = Square 00. So these three most popular squares can be listed
  # with the six-digit modal string: 102400.
  #
  # If, instead of using two 6-sided dice, two 4-sided dice are used, find the
  # six-digit modal string.

  def community_chest( space, card )
    # Go to the starting square or Jail, depending on card.
    space = 10 * card unless 1 < card
    space
  end

  def chance( space, card )
    case card
    when 0..5
      # Move directly to an alternative square, depending on card.
      space = [0, 10, 11, 24, 39, 5].at( card )
    when 6, 7
      # Move to the next Railroad square.
      space = [5, 15, 25, 35].find {|s| s > space} || 5
    when 8
      # Move to the next Utility square.
      space = [12, 28].find {|s| s > space} || 12 
    when 9
      # Move back three spaces.
      space = (space - 3) % 40
    end

    space
  end

  def solve( n = 4, iter = 250000 )
    # These represent the cards in the Community Chest and Chance decks.  They
    # are shuffled once only at the beginning of the game.
    cc = Array.new( 16 ) {|i| i}.shuffle
    ch = Array.new( 16 ) {|i| i}.shuffle

    count = Array.new( 40, 0 )
    space = doubles = 0

    # Run a Monte Carlo simulation to see asymptotic results.
    iter.times do |i|
      # Keep track of how many times each square is reached.
      count[space] += 1

      # Roll two dice.  Ignore the rule for doubles, because although it is
      # technically correct, it actually slows convergence.
      d1, d2 = 1 + rand( n ), 1 + rand( n )
#      if d1 == d2 && 3 == doubles += 1
#        space = 10
#        doubles = 0
#      else
        space = (space + d1 + d2) % 40
#        doubles = 0 unless d1 == d2
#      end

      # Adjust destination square based on dice roll.
      case space
      when 2, 17, 33
        # Draw from the Community Chest pile.
        cc.push( draw = cc.shift )
        space = community_chest( space, draw )       
      when 7, 22, 36
        # Draw from the Chance pile.
        ch.push( draw = ch.shift )
        space = chance( space, draw )
      when 30
        # Go directly to Jail.
        space = 10
      end
    end

    # Concatenate the two-digit indices of the three most popular spaces.
    count.each_with_index.sort.reverse[0, 3].inject( "" ) {|acc, c| acc + ("%02d" % c[1])}
  end
end
