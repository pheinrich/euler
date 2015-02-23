require 'projectEuler'

# 0.07074s (1/23/15, #8914)
class Problem_0205
  def title; 'Dice Game' end

  # Peter has nine four-sided (pyramidal) dice, each with faces numbered 1, 2,
  # 3, 4. Colin has six six-sided (cubic) dice, each with faces numbered 1, 2,
  # 3, 4, 5, 6.
  #
  # Peter and Colin roll their dice and compare totals: the highest total
  # wins. The result is a draw if the totals are equal.
  #
  # What is the probability that Pyramidal Pete beats Cubic Colin? Give your
  # answer rounded to seven decimal places in the form 0.abcdefg

  def refs; [] end
  def solution; 0.5731441 end
  def best_time; 0.07074 end

  def completed_on; '2015-01-23' end
  def ordinality; 8_914 end
  def percentile; 98.04 end

  def roll( dice, sides, array, total )
    # Recursively roll dice and tally the frequency of each possible result.
    if 0 < dice
      (1..sides).each {|s| roll( dice - 1, sides, array, s + total )}
    else
      array[total - 1] += 1.0
    end
  end

  def solve( pDice = 9, pSides = 4, cDice = 6, cSides = 6 )
    pRolls = Array.new( pDice * pSides ) {0}
    cRolls = Array.new( cDice * cSides ) {0}
    prob = {}

    # Count the frequency of every possible roll using Pete's dice, then
    # divide by the total possible rolls to compute the probability of each
    # one. 
    roll( pDice, pSides, pRolls, 0 )
    pRolls.map! {|r| r / pSides**pDice}

    # Do the same for Colin's dice.
    roll( cDice, cSides, cRolls, 0 )
    cRolls.map! {|r| r / cSides**cDice}

    # Now compute the bivariate distribution for each possible combination of
    # values rolled by Peter and Colin. This is just the product of their
    # individual probabilities.
    (0...pRolls.length).each do |i|
      (0...cRolls.length).each do |j|
        prob[[i, j]] = pRolls[i] * cRolls[j]
      end
    end

    # Drop combinations where Peter doesn't win, then sum the probabilities
    # for the remaining rolls. 
    prob.select! {|k, v| k[0] > k[1]}
    "%0.7f" % prob.values.reduce( :+ ) 
  end
end