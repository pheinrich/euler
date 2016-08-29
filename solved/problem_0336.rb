require 'projectEuler'

class Problem_0336
  def title; 'Maximix Arrangements' end
  def difficulty; 20 end

  # A train is used to transport four carriages in the order: ABCD. However,
  # sometimes when the train arrives to collect the carriages they are not in
  # the correct order.
  #
  # To rearrange the carriages they are all shunted on to a large rotating
  # turntable. After the carriages are uncoupled at a specific point the train
  # moves off the turntable pulling the carriages still attached with it. The
  # remaining carriages are rotated 180 degrees. All of the carriages are then
  # rejoined and this process is repeated as often as necessary in order to
  # obtain the least number of uses of the turntable.
  #
  # Some arrangements, such as ADCB, can be solved easily: the carriages are
  # separated between A and D, and after DCB are rotated the correct order has
  # been achieved.
  #
  # However, Simple Simon, the train driver, is not known for his efficiency,
  # so he always solves the problem by initially getting carriage A in the
  # correct place, then carriage B, and so on.
  #
  # Using four carriages, the worst possible arrangements for Simon, which we
  # shall call maximix arrangements, are DACB and DBAC; each requiring him
  # five rotations (although, using the most efficient approach, they could be
  # solved using just three rotations). The process he uses for DACB is shown
  # below (see diagram).
  #
  # It can be verified that there are 24 maximix arrangements for six
  # carriages, of which the tenth lexicographic maximix arrangement is DFAECB.
  #
  # Find the 2011th lexicographic maximix arrangement for eleven carriages.

  def advance( vars, upper, lower )
    # Take a series of digits and advance them through preset values. This is
    # essentially just incrementing a number with very specific constraints
    # for each digit. In our case, the starting value for each digit differs
    # according to its position, while the upper limit is the same for all.
    #
    # This method returns true on overflow, false otherwise.
    vars.each_index do |i|
      vars[i] += 1
      if vars[i] > upper
        return true if i == vars.length - 1
        vars[i] = lower[i]
      else
        break
      end
    end

    false
  end

  def seqrev( src, seq )
    # Apply the sequential reversals to the source string given. Each entry
    # in the sequence indicates where the section to be reversed starts. From
    # that point to the end of the string, the substring is reversed in place.
    dst = src.dup
    seq.each {|i| dst = dst[0, i] + dst[i..-1].reverse}
    dst
  end

  def solve( cars = 11, n = 2011 )
    # Through brute-force computation of the necessary reversal sequences for
    # all permutations of (a smaller number of) cars, we can detect a pattern.
    # For example, for cars = 7, the reversal sequence looks like
    #
    #  a, 0, b, 1, c, 2, d, 3, 5, 4, 5
    #
    # where a, b, c, d are certain values between 1-5. That is, applying the
    # the reversal sequence above to a specific maximix arrangement will put
    # the cars in order. We can take advantage of the fact that applying the
    # sequence (in reverse) to an in-order arrangement will generate the
    # corresponding maximix line-up.
    #
    # Generating valid reversal sequences starts with the creation of an array
    # outline based on the number of cars. There will always be four terms at
    # the end (the beginning of the reversed sequence) that we can compute
    # directly from this number, then successive even terms will count down
    # from there.
    #
    # Next, we need to choose a, b, c, d that lead to valid maximix arrange-
    # ments. It turns out that we simply increment each variable through
    # very specific values: for cars = 7, a will take values in [cars - 6,
    # cars - 2]; b will traverse [cars - 5, cars - 2]; c will traverse
    # [cars - 4, cars - 2]; etc. As the number of cars increases and more
    # variables are needed, the range of each is adjusted so the last one
    # always runs over [1, cars - 2]. 

    labels = Array.new( cars ) {|i| (65 + i).chr}
    seq = [cars - 2, cars - 3, cars - 2, cars - 4, -1]
    maximix = []

    # Expand the placeholder sequence with the values we can compute directly
    # (and count down from there).
    (cars - 5).downto( 0 ) do |i|
      seq << i
      seq << -1
    end

    # Compute the number of variables we'll need to describe all valid maximix
    # permutations and determine the lower bound (starting value) for each. 
    vars = cars - 3
    lower = (0...vars).map {|i| vars - i}
    permute = lower.dup
    done = false

    # Advance through all valid tuples that lead to maximix configurations. 
    until done
      # Substitute the variable values into the reversal sequence.
      permute.each_with_index {|p, i| seq[1 - 2*(vars - i)] = p}

      # Apply the reversal sequence to an ordered array of car labels.
      maximix << seqrev( labels, seq ).join

      # Advance to the next valid tuple.
      done = advance( permute, cars - 2, lower )
    end

    # Sort the resulting maximix permutations and choose the one requested.
    maximix.sort[n - 1]
  end

  def solution; 'Q0FHQklIRUZKREs=' end
  def best_time; 8.971 end
  def effort; 20 end

  def completed_on; '2016-08-29' end
  def ordinality; 1_340 end
  def population; 626_591 end

  def refs; [] end
end
