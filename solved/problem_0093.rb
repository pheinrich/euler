require 'projectEuler'

# 37.63s (1/11/14, #5426)
class Problem_0093
  def title; 'Arithmetic expressions' end
  def difficulty; 35 end

  # By using each of the digits from the set, {1, 2, 3, 4}, exactly once,
  # and making use of the four arithmetic operations (+, −, *, /) and
  # brackets/parentheses, it is possible to form different positive integer
  # targets.
  #
  # For example,
  #
  #     8 = (4 * (1 + 3)) / 2
  #     14 = 4 * (3 + 1 / 2)
  #     19 = 4 * (2 + 3) − 1
  #     36 = 3 * 4 * (2 + 1)
  #
  # Note that concatenations of the digits, like 12 + 34, are not allowed.
  #
  # Using the set, {1, 2, 3, 4}, it is possible to obtain thirty-one different
  # target numbers of which 36 is the maximum, and each of the numbers 1 to 28
  # can be obtained before encountering the first non-expressible number.
  #
  # Find the set of four distinct digits, a < b < c < d, for which the longest
  # set of consecutive positive integers, 1 to n, can be obtained, giving your
  # answer as a string: abcd.

  GROUPS = %w[(%0.1f%c%0.1f)%c%0.1f%c%0.1f    %0.1f%c(%0.1f%c%0.1f)%c%0.1f
              %0.1f%c%0.1f%c(%0.1f%c%0.1f)    (%0.1f%c%0.1f)%c(%0.1f%c%0.1f)
              ((%0.1f%c%0.1f)%c%0.1f)%c%0.1f  (%0.1f%c(%0.1f%c%0.1f))%c%0.1f
              %0.1f%c((%0.1f%c%0.1f)%c%0.1f)  %0.1f%c(%0.1f%c(%0.1f%c%0.1f))
              (%0.1f%c%0.1f%c%0.1f)%c%0.1f    %0.1f%c(%0.1f%c%0.1f%c%0.1f)]
 
  def solve
    # Precompute 64 possible combinations of operators, plus the 210 sets of
    # [a, b, c, d] where a < b < c < d  
    ops_perms = (['+', '-', '*', '/'] * 3).permutation( 3 ).to_a.uniq
    abcd_perms = (0..9).to_a.permutation( 4 ).select {|p| p[0] < p[1] && p[1] < p[2] && p[2] < p[3]}

    max, result = 0, []

    # Try each potential set of digits. 
    for abcd in abcd_perms
      seq = []

      # Try each of the 24 permutations of [a, b, c, d].
      for order in abcd.permutation( 4 )
        for ops in ops_perms
          for group in GROUPS

            # Substitute the values of [a, b, c, d] into each of the grouping
            # expressions, interleaving the current set of operators. Evaluate
            # the result.
            expr = group % order.zip( ops ).flatten
            value = eval( expr )

            # If the expression doesn't evaluate to an integer, move to the
            # next grouping.  Otherwise, save the result.
            next if value.infinite? || value.nan? || value.to_i != value
            seq << value if 0 < value
          end
        end
      end

      # Sort the de-duped sequence and return the first element whose
      # successor is absent.
      seq = seq.uniq.sort.find {|i| !seq.include?( 1 + i )}

      # Remember this sequence if it's the longest we've seen so far.
      max, result = seq, abcd if max < seq
    end

    result.join.to_i
  end

  def solution; 1_258 end
  def best_time; 37.63 end
  def effort; 20 end
  
  def completed_on; '2014-01-11' end
  def ordinality; 5_426 end
  def population; 362_773 end

  def refs; [] end
end
