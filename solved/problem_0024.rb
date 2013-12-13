require 'projectEuler'

# Lexicographic permutations
class Problem_0024
  # A permutation is an ordered arrangement of objects. For example, 3124 is
  # one possible permutation of the digits 1, 2, 3 and 4. If all of the
  # permutations are listed numerically or alphabetically, we call it
  # lexicographic order. The lexicographic permutations of 0, 1 and 2 are:
  #
  # 012   021   102   120   201   210
  #
  # What is the millionth lexicographic permutation of the digits 0, 1, 2, 3,
  # 4, 5, 6, 7, 8 and 9?

  def self.solve( n )
    # Worst kind of brute force...
    puts %w(0 1 2 3 4 5 6 7 8 9).permutation( 10 ).to_a.map! {|a| a.join}.sort![n - 1]
  end
end

ProjectEuler.time do
  # 2783915460 (14.04s)
  Problem_0024.solve( 1000000 )
end
