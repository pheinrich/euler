require 'projectEuler'

# 0.01374s
class Problem_0022
  def title; 'Names scores' end
  def solution; 871_198_282 end

  # Using names.txt, a 46K text file containing over five-thousand first names,
  # begin by sorting it into alphabetical order. Then working out the
  # alphabetical value for each name, multiply this value by its alphabetical
  # position in the list to obtain a name score.
  #
  # For example, when the list is sorted into alphabetical order, COLIN, which
  # is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So,
  # COLIN would obtain a score of 938 x 53 = 49714.
  #
  # What is the total of all the name scores in the file?

  def solve
    # Strip quotes and split comma-separated values into a sorted array.
    names = IO.read( 'resources/names.txt' ).delete( '\"' ).split( ',' ).sort

    # Add all character values together, then account for offset value of 'A'.
    names.map! {|n| n.bytes.inject( :+ ) - (n.length << 6)}

    # Weight each name score according to its list position and add together.
    names.each_with_index.inject( 0 ) {|sum, (n, i)| sum + n*(1 + i)}
  end
end
