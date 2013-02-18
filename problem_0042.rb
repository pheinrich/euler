require 'projectEuler'

# Coded triangle numbers
class Problem_0042
  # The nth term of the sequence of triangle numbers is given by,
  # t[n] = n(n+1)/2; so the first ten triangle numbers are:
  #
  #     1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
  #
  # By converting each letter in a word to a number corresponding to its
  # alphabetical position and adding these values we form a word value. For
  # example, the word value for SKY is 19 + 11 + 25 = 55 = t[10]. If the word
  # value is a triangle number then we shall call the word a triangle word.
  #
  # Using words.txt, a 16K text file containing nearly two-thousand common
  # English words, how many are triangle words?

  def self.solve()
    # Strip quotes and split comma-separated values into a sorted array.
    words = IO.read( 'resources/words.txt' ).delete( '\"' ).split( ',' )

    # Add all character values together, then account for offset value of 'A'.
    words.map! {|i| i.bytes.inject( :+ ) - (i.length << 6)}

    # Create an array of triangle numbers using the max word score as starting
    # length.  This will far bigger than necessary, but still reasonably small
    # and cheap computationally.
    t = Array.new( words.max ) {|i| i*(i + 1) / 2}

    # Count the number of words whose length corresponds to a triangle number.
    puts words.count {|i| t.include?( i )}
  end
end

ProjectEuler.time do
  # 162
  Problem_0042.solve()
end
