require 'projectEuler'

# 0.1936s (1/11/15, #8087)
class Problem_0125
  def title; 'Palindromic sums' end

  # The palindromic number 595 is interesting because it can be written as the
  # sum of consecutive squares: 6^2 + 7^2 + 8^2 + 9^2 + 10^2 + 11^2 + 12^2.
  #
  # There are exactly eleven palindromes below one-thousand that can be
  # written as consecutive square sums, and the sum of these palindromes is
  # 4164. Note that 1 = 0^2 + 1^2 has not been included as this problem is
  # concerned with the squares of positive integers.
  #
  # Find the sum of all the numbers less than 10^8 that are both palindromic
  # and can be written as the sum of consecutive squares.

  def refs; [] end
  def solution; 2_906_969_179 end
  def best_time; 0.1936 end

  def completed_on; '2015-01-11' end
  def ordinality; 8_087 end
  def percentile; 98.12 end

  def solve( n = 100_000_000 )
    # Assuming the largest valid sum of squares is S = a^2 + (a - 1)^1 < n,
    # first find a and set aside space to cache that many running sums.
    len = (1 + Math.sqrt( 2*n )) / 2
    sos = Array.new( len )

    seen = []
    sos[0] = 1

    (1...len).each do |i|
      # Precompute the ∑ i^2 for all i <= a. 
      ds = i*i + 2*i + 1
      sos[i] = sos[i - 1] + ds

      seen << sos[i] if sos[i].palindrome?

      # Most of the sum of square values will exceed n, so subtract lower sums
      # to check shorter runs.
      (i - 2).downto( 0 ) do |j|
        diff = sos[i] - sos[j]
        break unless diff < n

        # Update our total if the shorter run a[j] + a[j + 1] + ... + a[i] is
        # a palindrome.
        seen << diff if diff.palindrome?
      end
    end

    seen.uniq.reduce( :+ )
  end
end
