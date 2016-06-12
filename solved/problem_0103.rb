require 'projectEuler'

# 0.8445s (6/10/16, #5217)
class Problem_0103
  def title; 'Special subset sums: optimum' end
  def difficulty; 45 end

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
  # It seems that for a given optimum set, A = {a_1, a_2, ... , a_n}, the next
  # optimum set is of the form B = {b, a_1+b, a_2+b, ... ,a_n+b}, where b is
  # the "middle" element on the previous row.
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

  # Starting from an initial array not necessarily minimized (may not be an
  # optimal special sum set), increment terms until a minimum sum is found.
  def optimize( arr )
    minSum, minSet = Fixnum::MAX, nil
    n = arr.size
    polys = []

    # Starting with the specified array, increment terms until (most) all
    # greater than those in the minSet we've seen so far (if any). Then we'll
    # know sums will start increasing and we can stop.
    until minSet && n < n.times.count {|i| minSet[i] < arr[i]} + 2
      if arr.domcard? && arr.dissociated?( polys )
        sum = arr.reduce( :+ )
        minSum, minSet = sum, arr.dup if sum < minSum
      end

      # Increment the a_i to advance to the next candidate set. We know that
      # a_x < a_0 + a_1, so if a_x ever gets too big, increment the next lower
      # term instead (subject to the same condition) and propagate new values
      # through to the end of the array. 
      (n - 1).downto( 0 ) do |d|
        arr[d..-1] = *(arr[d] + 1..arr[d] + n - d)
        break if arr[d] < arr[1] + arr[0]
        d -= 1
      end
    end
    
    minSet
  end

  def solve( n = 7 )
    # A few observations following directly from properties i and ii (assume
    # w.l.o.g. that A is ordered):
    #
    #   1. a_i must be unique, so a_n > a_1 + n - 2.
    #   2. a_1 + a_2 > a_n, so a_1 + a_2 > a_1 + n - 2 ==> a_2 > n - 2.
    #   3. a_2 > n - 2 ==> a_2 - a_1 > n - 2 - a_1
    #   4. a_i + a_j != a_k ∀ i, j, k, so a_k - a_j ∉ A for any j, k.
    #   5. a_1 + a_2 > a_n, a_1 + a_2 + a_3 > a_(n-1) + a_n
    #
    # This makes it easy to check for condition ii: the sum of the smallest
    # two elements (a_0 + a_1) must be greater than the single largest (a_n);
    # the sum of the smallest three must be greater than the sum of the
    # largest two; etc.
    #
    # Proving condition i is slightly more difficult, but we can observe that
    # with terms ordered, we can almost always determine relative magnitude of
    # subset sums. It's only when the sets "straddle" each other that we must
    # test them explicitly (see problem 106 for more info).
    seeds = [[1],
             [1, 2],
             [2, 3, 4],
             [3, 5, 6, 7],
             [6, 9, 11, 12, 13],
             [11, 18, 19, 20, 22, 25]]

    # Build a reasonable starting array after observing that a_0 appears to be
    # the sum of the previous three a_0s. Terms a_1...a_n will be constructed
    # as described in the problem description.
    (seeds.size...n).each do |i|
      first = seeds[-3, 3].reduce( 0 ) {|acc, s| acc + s[0]}
      seeds[i] = optimize( [first] + seeds[i - 1].map {|a| a + first} )
    end

    # Combine the a_i to obtain a set string.
    seeds[ n - 1 ].reduce( '' ) {|acc, a| acc + a.to_s}
  end

  def solution; 20_313_839_404_245 end
  def best_time; 0.08445 end
  def effort; 50 end

  def completed_on; '2016-06-10' end
  def ordinality; 5_217 end
  def population; 569_448 end

  def refs
    ["http://people.maths.ox.ac.uk/greenbj/papers/bourgain-sumset.pdf",
     "http://math.haifa.ac.il/~seva/Papers/DisBases.pdf",
     "http://mathoverflow.net/a/56175"]
  end
end
