require 'projectEuler'

class Problem_0022
  def title; 'Names scores' end
  def difficulty; 5 end

  # Using 0022_names.txt, a 46K text file containing over five-thousand first
  # names, begin by sorting it into alphabetical order. Then working out the
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
    names = IO.read( 'resources/0022_names.txt' ).delete( '\"' ).split( ',' ).sort

    # Add all character values together, then account for offset value of 'A'.
    names.map! {|n| n.bytes.inject( :+ ) - (n.length << 6)}

    # Weight each name score according to its list position and add together.
    names.each_with_index.inject( 0 ) {|sum, (n, i)| sum + n*(1 + i)}
  end

  def solution; 'ODcxMTk4Mjgy' end
  def best_time; 0.008969 end
  def effort; 0 end

  def completed_on; '2013-02-05' end
  def ordinality; 48_926 end
  def population; 295_427 end

  def refs; [] end
end
