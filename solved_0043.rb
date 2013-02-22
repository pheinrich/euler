require 'projectEuler'

# Sub-string divisibility
class Problem_0043
  # The number 1406357289 is a 0 to 9 pandigital number because it is made up
  # of each of the digits 0 to 9 in some order, but it also has a rather
  # interesting sub-string divisibility property.
  #
  # Let d[1] be the 1st digit, d[2] be the 2nd digit, and so on. In this way,
  # we note the following:
  #
  #     d[2]d[3]d[4]  = 406 is divisible by 2
  #     d[3]d[4]d[5]  = 063 is divisible by 3
  #     d[4]d[5]d[6]  = 635 is divisible by 5
  #     d[5]d[6]d[7]  = 357 is divisible by 7
  #     d[6]d[7]d[8]  = 572 is divisible by 11
  #     d[7]d[8]d[9]  = 728 is divisible by 13
  #     d[8]d[9]d[10] = 289 is divisible by 17
  #
  # Find the sum of all 0 to 9 pandigital numbers with this property.

  def self.chain( maps, candidate = "", index = 0, sum = 0 )
    if index < maps.length
      maps[index].each do |a|
        # If this is the first pass, the string will start with all three
        # digits from the current divisor list.  Grab the first two here; the
        # last will be added as we descend to the next level.
        candidate = a[0, 2] if 0 == index

        # As we look at each divisor, skip the ones that don't start with the
        # last two digits from the last level.
        next if !a.start_with?( candidate[ -2, 2 ] )

        # This divisor and the last overlap two digits, so descend to the next
        # level and try to keep the chain going.
        sum = chain( maps, candidate + a[-1], 1 + index, sum )
      end
    else
      # Add the current candidate to the total, as long as it doesn't repeat
      # any digits.
      sum += candidate.to_i unless candidate =~ /(.).*\1/
    end

    sum
  end

  def self.solve( divisors )
    # Create an array of divisor lists.  Each list will contain all 3-digit
    # values divisible by the corresponding entry from the divisors array, not
    # including those with duplicated digits.
    maps = divisors.map {|i| (12..987).reject {|j| 0 != j % i || "%03d" % j =~ /([0-9]).*\1/}.map {|k| "%03d" % k}}
    puts chain( maps )
  end
end

ProjectEuler.time do
  # 16695334890
  Problem_0043.solve( [1, 2, 3, 5, 7, 11, 13, 17] )
end
