require 'projectEuler'

# 
class Problem_0103
  def title; 'Special subset sums: optimum' end

  # Let S(A) represent the sum of elements in set A of size n. We shall call
  # it a special sum set if for any two non-empty disjoint subsets, B and C,
  # the following properties are true:
  #
  #      i.  S(B) ≠ S(C); that is, sums of subsets cannot be equal.
  #      ii. If B contains more elements than C then S(B) > S(C).
  #
  # If S(A) is minimised for a given n, we shall call it an optimum special
  # sum set. The first five optimum special sum sets are given below.
  #
  #      n = 1: {1}
  #      n = 2: {1, 2}
  #      n = 3: {2, 3, 4}
  #      n = 4: {3, 5, 6, 7}
  #      n = 5: {6, 9, 11, 12, 13}
  #
  # It seems that for a given optimum set, A = {a1, a2, ... , an}, the next
  # optimum set is of the form B = {b, a1+b, a2+b, ... ,an+b}, where b is the
  # "middle" element on the previous row.
  #
  # By applying this "rule" we would expect the optimum set for n = 6 to be
  # A = {11, 17, 20, 22, 23, 24}, with S(A) = 117. However, this is not the
  # optimum set, as we have merely applied an algorithm to provide a near opt-
  # imum set. The optimum set for n = 6 is A = {11, 18, 19, 20, 22, 25}, with
  # S(A) = 115 and corresponding set string: 111819202225.
  #
  # Given that A is an optimum special sum set for n = 7, find its set string.
  #
  # NOTE: This problem is related to Problem 105 and Problem 106.

  def refs; [] end
  def solution; end
  def best_time; end

  def completed_on; '2016-01-01' end
  def ordinality; end
  def population; end

  def solve( n = 7 )
    # A few observations following directly from properties i and ii (assume
    # w.l.o.g. that A is ordered):
    #
    #   1. ai must be unique, so an >= a1 + n - 1.
    #   2. a1 + a2 > an, so a1 + a2 >= a1 + n - 1 ==> a2 >= n - 1.
    #   3. a2 >= n - 1 ==> a2 - a1 >= n - 1 - a1
    #   3. ai + aj != ak ∀ i, j, k, so ak - aj ∉ A for any j, k.
    #   4. 
  end
end
