require 'projectEuler'

# 8.196s (2/8/13, #~44270)
class Problem_0024
  def title; 'Lexicographic permutations' end

  # A permutation is an ordered arrangement of objects. For example, 3124 is
  # one possible permutation of the digits 1, 2, 3 and 4. If all of the
  # permutations are listed numerically or alphabetically, we call it
  # lexicographic order. The lexicographic permutations of 0, 1 and 2 are:
  #
  #     012   021   102   120   201   210
  #
  # What is the millionth lexicographic permutation of the digits 0, 1, 2, 3,
  # 4, 5, 6, 7, 8 and 9?

  def refs; [] end
  def solution; 2_783_915_460 end
  def best_time; 8.196 end

  def completed_on; '2013-02-08' end
  def ordinality; 44_270 end
  def percentile; 85.92 end

  def solve( n = 1_000_000 )
    # Worst kind of brute force...
    (%w(0 1 2 3 4 5 6 7 8 9).permutation( 10 ).to_a.map! {|a| a.join}.sort![n - 1]).to_i
  end
end
