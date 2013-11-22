require 'projectEuler'

# Cubic permutations 
class Problem_0062
  # The cube, 41063625 (345^3), can be permuted to produce two other cubes:
  # 56623104 (384^3) and 66430125 (405^3). In fact, 41063625 is the smallest
  # cube which has exactly three permutations of its digits which are also cube.
  #
  # Find the smallest cube for which exactly five permutations of its digits
  # are cube.

  def self.solve( n )
    # Sort cube digits.
    digits = (0...10000).map {|i| (i*i*i).to_s.chars.sort}

    # For each cube, count cubes that share the same digits (twins).
    counts = digits.map {|d| digits.count( d )}

    # Find the first entry that has the required number of twins.
    puts counts.find_index( n )**3
  end
end

ProjectEuler.time do
  # 127035954683
  Problem_0062.solve( 5 )
end
