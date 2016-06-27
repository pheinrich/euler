require 'projectEuler'

# 0.2029s (6/10/16, #5250)
class Problem_0105
  def title; 'Special subset sums: testing' end
  def difficulty; 45 end

  # Let S(A) represent the sum of elements in set A of size n. We shall call
  # it a special sum set if for any two non-empty disjoint subsets, B and C,
  # the following properties are true:
  #
  #      i.  S(B) ≠ S(C); that is, sums of subsets cannot be equal.
  #      ii. If B contains more elements than C then S(B) > S(C).
  #
  # For example, {81, 88, 75, 42, 87, 84, 86, 65} is not a special sum set
  # because 65 + 87 + 88 = 75 + 81 + 84, whereas {157, 150, 164, 119, 79, 159,
  # 161, 139, 158} satisfies both rules for all possible subset pair comb-
  # inations and S(A) = 1286.
  #
  # Using 0105_sets.txt, a 4K text file with one-hundred sets containing seven
  # to twelve elements (the two examples given above are the first two sets in
  # the file), identify all the special sum sets, A1, A2, ..., Ak, and find
  # the value of S(A1) + S(A2) + ... + S(Ak).
  #
  # NOTE: This problem is related to Problem 103 and Problem 106.

  # Brute force test that's about twice as fast as the polynomial check for
  # small batches like this. (Over thousands of comparisons, the polynomial
  # version exceeds 10x performance, however.)  
  def special?( arr )
    sums = {}
    max, min = 1 << arr.size, 0

    # We'll compute the sums for all 2^n possible subsets, which we'll
    # represent as binary polynomials. Since the cardinality of each subset
    # (important for checking condition 2, above) is just its Hamming weight,
    # we'll look at sums by subset size.
    1.upto( arr.size - 2 ).each do |hw|
      poly = (1 << hw) - 1
      limit = 0

      # Look at every subset with a specific Hamming weight.
      while poly < max
        # Add up the elements represented by the binary polynomial.
        sum = arr.each_with_index.map {|a, i| 1 == (poly >> i) & 1 ? a : 0}.reduce( :+ )

        # If the sum is less than any sum we saw for subsets of smaller size,
        # or it's a sum we've seen before, this set can't be special.
        return false if sum <= min || sums[sum]

        # Mark this sum as seen so we'll know if we encounter it again. Also,
        # keep track of the max total for subsets of this size.
        sums[sum] = true
        limit = sum if limit < sum

        # Move to the next subset with the same cardinality.
        poly = poly.bitseq
      end
 
      # Our new lower limit will be the largest value seen for smaller
      # subsets.
      min = limit
    end
    
    true
  end

  def solve
    sets = IO.read( 'resources/0105_sets.txt' ).split.map {|line| line.split( ',' ).map( &:to_i )}
    sets.select {|s| special?( s )}.flatten.reduce( :+ )
  end

  def solution; 73_702 end
  def best_time; 0.2029 end
  def effort; 15 end

  def completed_on; '2016-06-10' end
  def ordinality; 5_250 end
  def population; 569_431 end

  def refs; [] end
end
