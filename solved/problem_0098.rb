require 'projectEuler'

# 1.228s (2/14/14, #5299)
class Problem_0098
  def title; 'Anagramic squares' end
  def solution; 18_769 end

  # By replacing each of the letters in the word CARE with 1, 2, 9, and 6
  # respectively, we form a square number: 1296 = 36^2. What is remarkable is
  # that, by using the same digital substitutions, the anagram, RACE, also
  # forms a square number: 9216 = 96^2. We shall call CARE (and RACE) a square
  # anagram word pair and specify further that leading zeroes are not per-
  # mitted, neither may a different letter have the same digital value as
  # another letter.
  #
  # Using words.txt, a 16K text file containing nearly two-thousand common
  # English words, find all the square anagram word pairs (a palindromic word
  # is NOT considered to be an anagram of itself).
  #
  # What is the largest square number formed by any member of such a pair?
  #
  # NOTE: All anagrams formed must be contained in the given text file.

  def solve
    # Load the word list and remove commas and quotes.
    words = IO.read( 'resources/words.txt' ).delete( '\"' ).split( ',' )

    # Select words whose letters are used by at least one other in the file,
    # then group anagrammatic words together.
    anagrams = words.map {|w| w.chars.sort.join}
    anagrams.select! {|a| 1 < anagrams.count( a )}
    words = anagrams.uniq.map! {|a| words.find_all {|w| w.chars.sort.join == a}}

    # Square numbers below a reasonable maximum and precompute the correspond-
    # ing masks.  For example, "438244" yields a mask similar to "012300".
    h = Hash.new {|hash, key| hash[key] = []}
    sn = (0...10000).map {|i| (i*i).to_s}
    sn.each {|i| h[i.make_mask] << i}

    max = 0

    # For each group of anagrammatic words, do digit substitutions looking for
    # square numbers.
    words.each do |group|
      base = group[0]
      mask = base.make_mask

      # Each word will match many squares, but we need to find words that
      # produce squares using the same digits.
      for m in h[mask]
        for w in group[1..-1]

          # Substitute the digits of each square matched by the base word for
          # the characters in the other words of the group.  If the result
          # isn't a square number, move on.
          val = w.chars.map {|c| m[mask[base.index( c )].ord - 48]}.join
          next unless sn.include?( val )

          # We found a square, so save the maximum seen so far.
          val = val.to_i
          max = val if val > max 
        end
      end
    end

    max
  end
end
