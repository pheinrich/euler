require 'projectEuler'

# 0.0004969s (12/27/13, #23596)
class Problem_0079
  def title; 'Passcode derivation' end
  def solution; 73_162_890 end

  # A common security method used for online banking is to ask the user for
  # three random characters from a passcode. For example, if the passcode was
  # 531278, they may ask for the 2nd, 3rd, and 5th characters; the expected
  # reply would be: 317.
  #
  # The text file, keylog.txt, contains fifty successful login attempts.
  #
  # Given that the three characters are always asked for in order, analyse the
  # file so as to determine the shortest possible secret passcode of unknown
  # length.

  def solve
    # Read lines and split into start-end pairs.
    pairs = []
    IO.read( 'resources/keylog.txt' ).split.uniq.each do |line|
      pairs << line[0, 2] << line[1, 2] << line[0] + line[2]
    end

    # Delete duplicates and compute weight based on start character frequency.
    pairs.uniq!
    weight = (0..9).map {|i| pairs.count {|p| p[0].to_i == i}}

    # Order pairs according to most popular starting character, since we want
    # to maximize how many numbers appear after each one.
    pairs.sort_by! {|p| 10 * weight[p[0].to_i] + weight[p[1].to_i]}

    # Concatenate characters as long as they haven't been seen before.  This
    # is not a general-purpose solution, but the problem (as stated) is not
    # exceptionally challenging.
    pwd = []
    pairs.reverse.each do |p|
      pwd << p[0] unless pwd.include?( p[0] )
      pwd << p[1] unless pwd.include?( p[1] )
    end

    pwd.join.to_i
  end
end
