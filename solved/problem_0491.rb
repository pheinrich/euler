require 'projectEuler'

class Problem_0491
  def title; 'Double pandigital number divisible by 11' end
  def difficulty; 20 end

  # We call a positive integer double pandigital if it uses all the digits 0
  # to 9 exactly twice (with no leading zero). For example,
  # 40561817703823564929 is one such number.
  #
  # How many double pandigital numbers are divisible by 11?

  # Return unique permutations of the digits provided, taking into account
  # whether or not leading zeros are allowed.
  def count_perms( digits, zeroOk = false )
    dups = (0..9).map {|i| digits.count( i )}.select {|j| 0 < j}.reduce( :* )

    if zeroOk || 0 != digits[0]
      # Leading zeros ok or none present, so just count unique permutations.
      return digits.length.fact / dups
    elsif 0 == digits[1]
      # Two zeros present, but not allowed up front.
      return ((digits.length - 1).fact * (digits.length - 2)) / dups
    else
      # One zero present, but not allowed up front.
      return ((digits.length - 1).fact * (digits.length - 1)) / dups
    end
  end

  def solve
    digits = [0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9]
    sum, min = digits.sum, digits[0...digits.length/2].sum

    # A number can be trivially tested for 11 divisibility by computing two
    # digit sums from alternating digits and subtracting one from the other.
    # If 11 divides the result, it divides the original number.
    #
    # Since we know all digits will appear twice, we know the total digit sum
    # will always be 0+0+1+1+2+2+3+3+4+4+5+5+6+6+7+7+8+8+9+9 = 90. The minimum
    # possible with half the digits would then be 0+0+1+1+2+2+3+3+4+4 = 20.
    # Similarly, the maximum is 5+5+6+6+7+7+8+8+9+9 = 70 = 90 - 20. Therefore,
    # we must first find digit sum pairs in [20, 70] whose difference is
    # divisible by 11. Only alternating digit permutations that sum to these
    # pairs can combine to yield double pandigital numbers divisible by 11.
    pairs = (min..sum-min).select {|x| 0 == (2*x - sum) % 11}

    # Now find all ways to linearly combine 10 of the digits above to produce
    # these valid pairs. Using one bit for each digit position, we can advance
    # through all 20-bit numbers with exactly 10 bits set, total the digits
    # corresponding to those bits, and discard combinations that don't sum to
    # valid values.
    seq = (1 << digits.length / 2) - 1
    limit = (seq << digits.length / 2) + 1
    parts = {}

    while seq < limit
      left = digits.select.with_index {|d, i| 0 != seq & (1 << i)}
      right = digits.select.with_index {|d, i| 0 == seq & (1 << i)}

      pair = left.sum
      if pairs.include?( pair )
        # Order the left and right combinations so the smaller sum always
        # appears first. Combine the two and add the result to a hash in order
        # to eliminate duplicates.
        left, right = right, left if left.join > right.join
        parts[[left, right]] = pair
      end

      # Move to the next 10-bit number.
      seq = seq.bitseq
    end

    # For each possible collection of alternating terms, count valid permu-
    # tations. For example, for [1, 2, 2, 3, 4, 5, 6, 7, 7, 8] on the left,
    # any of the 907200 possible arrangements of those digits would work.
    # Multiplying left permutations by right permutations gives the total
    # number of engineered values possible using those collections.
    total = 0
    parts.keys.each do |p|
      # Interleave left, then right digits.
      total += count_perms( p[0] ) * count_perms( p[1], true )

      # Interleave right, then left digits. Do this only if the sets aren't
      # identical, since switching the interleave order in that case would
      # result in nothing but duplicate values.
      total += count_perms( p[1] ) * count_perms( p[0], true ) if p[0] != p[1]
    end

    total
  end

  def solution; 'MTk0NTA1OTg4ODI0MDAw' end
  def best_time; 1.586 end
  def effort; 20 end

  def completed_on; '2018-09-14' end
  def ordinality; 1_540 end
  def population; 780_919 end

  def refs
    ['https://www.math.hmc.edu/funfacts/ffiles/10013.5.shtml',
     'http://www.mathwarehouse.com/probability/permutations-repeated-items.php']
  end
end
