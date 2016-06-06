require 'projectEuler'

# 27.51s (11/22/13, #~14140)
class Problem_0062
  def title; 'Cubic permutations' end
  def difficulty; 15 end

  # The cube, 41063625 (345^3), can be permuted to produce two other cubes:
  # 56623104 (384^3) and 66430125 (405^3). In fact, 41063625 is the smallest
  # cube which has exactly three permutations of its digits which are also cube.
  #
  # Find the smallest cube for which exactly five permutations of its digits
  # are cube.

  def solve( n = 5 )
    # Sort cube digits.
    digits = (0...10_000).map {|i| (i*i*i).to_s.chars.sort}

    # For each cube, count cubes that share the same digits (twins).
    counts = digits.map {|d| digits.count( d )}

    # Find the first entry that has the required number of twins.
    counts.find_index( n )**3
  end

  def solution; 127_035_954_683 end
  def best_time; 14.94 end
  def effort; 15 end

  def completed_on; '2013-11-22' end
  def ordinality; 14_140 end
  def population; 350_365 end

  def refs; [] end
end
