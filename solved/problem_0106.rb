require 'projectEuler'

class Problem_0106
  def title; 'Special subset sums: meta-testing' end
  def difficulty; 50 end

  # Let S(A) represent the sum of elements in set A of size n. We shall call
  # it a special sum set if for any two non-empty disjoint subsets, B and C,
  # the following properties are true:
  #
  #      i.  S(B) ≠ S(C); that is, sums of subsets cannot be equal.
  #      ii. If B contains more elements than C then S(B) > S(C).
  #
  # For this problem we shall assume that a given set contains n strictly in-
  # creasing elements and it already satisfies the second rule.
  #
  # Surprisingly, out of the 25 possible subset pairs that can be obtained
  # from a set for which n = 4, only 1 of these pairs need to be tested for
  # equality (first rule). Similarly, when n = 7, only 70 out of the 966
  # subset pairs need to be tested.
  #
  # For n = 12, how many of the 261625 subset pairs that can be obtained need
  # to be tested for equality?
  #
  # NOTE: This problem is related to Problem 103 and Problem 105.

  def solve( n = 12 )
    # Without loss of generality, assume that A is ordered, so we know that
    # a_1 < a_2 < ... < a_n. From this we can deduce, for example, that
    #
    #   a_1 + a_2 < a_3 + a_4
    #   a_2 + a3 + a_5 < a_3 + a_6 + a_7
    #   ...
    #   a_21 + a_394 < a_122 + a_395
    #   etc.
    #
    # In fact, as long as each term on the left is matched by a corresponding
    # (larger) term on the right, the inequality holds. However, if even one
    # term goes unmatched, we can't know for sure the relative magnitudes of
    # left and right.
    #
    # Treating each side as a binary polynomial, we can identify which items
    # are present by assigning one bit to each entry. Then a_2 + a_5 + a_9
    # would be represented by 2^9 + 2^5 + 2^2 = 1000100100b = 548, as an ex-
    # ample. By comparing the polynomials associated with sets of the same
    # size, we can easily check that every term in one set corresponds to a
    # larger term in the other. If not, we say the sets "straddle" each other
    # and we know that we must explicitly test the equality of the two sets.
    #
    # Subsets of A can have between 1 and n items, but we're concerned only
    # with subset comparisons in which the subsets have equal sizes. For each
    # subset size up to n / 2, then, we need to count straddling subsets.
    polys = []
    [*1..n].dissociated?( polys )
    polys.size
  end

  def solution; 'MjEzODQ=' end
  def best_time; 0.3050 end
  def effort; 40 end

  def completed_on; '2016-06-09' end
  def ordinality; 4_183 end
  def population; 603_955 end

  def refs; [] end
end
