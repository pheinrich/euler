require 'projectEuler'

# 
class Problem_0088
  def title; 'Product-sum numbers' end
  def solution;  end

  # A natural number, N, that can be written as the sum and product of a given
  # set of at least two natural numbers, {a1, a2, ... , ak} is called a
  # product-sum number: N = a1 + a2 + ... + ak = a1 × a2 × ... × ak.
  #
  # For example, 6 = 1 + 2 + 3 = 1 × 2 × 3.
  #
  # For a given set of size, k, we shall call the smallest N with this
  # property a minimal product-sum number. The minimal product-sum numbers for
  # sets of size, k = 2, 3, 4, 5, and 6 are as follows.
  #
  #     k=2: 4 = 2 × 2 = 2 + 2
  #     k=3: 6 = 1 × 2 × 3 = 1 + 2 + 3
  #     k=4: 8 = 1 × 1 × 2 × 4 = 1 + 1 + 2 + 4
  #     k=5: 8 = 1 × 1 × 2 × 2 × 2 = 1 + 1 + 2 + 2 + 2
  #     k=6: 12 = 1 × 1 × 1 × 1 × 2 × 6 = 1 + 1 + 1 + 1 + 2 + 6
  #
  # Hence for 2≤k≤6, the sum of all the minimal product-sum numbers is
  # 4+6+8+12 = 30; note that 8 is only counted once in the sum.
  #
  # In fact, as the complete set of minimal product-sum numbers for 2≤k≤12 is
  # {4, 6, 8, 12, 15, 16}, the sum is 61.
  #
  # What is the sum of all the minimal product-sum numbers for 2≤k≤12000?

  def prodSum( path )
    # Compute final term satisfying N = ∑a_i = ∏a_i. If it's an integer, use
    # it to calculate N, otherwise return nil.
    return nil if 1 == path[1]
    return nil if path[0] + path[2] < path[1] * path[2]

    ak = 1.0 * path[0] / (path[1] - 1)
    return nil if ak.to_i != ak

    puts "  #{path.inspect}: N = #{path[0] + ak.to_i}"
    path[0] + ak.to_i
  end

  def extendPath( path, limit )
    paths = []
    sum, prod, last = path[0], path[1], path[2]

    (last..limit).each do |l|
      paths << [sum + l, prod * l, l] if prod * l <= limit
    end

    paths
  end

  def solve( max = 500 )
    # http://www-users.mat.umk.pl/~anow/ps-dvi/si-krl-a.pdf

    # Path format: [sum, prod, last]
    paths = [[1, 1, 1], [2, 2, 2]]
    mins = []

    # For each value of k, find valid extensions of the (k-1)-length paths we
    # have found so far, computing the kth integer element for each, if it
    # exists. Choose the smallest N from these options.  
    (2..max).each do |k|
      puts "k = #{k}"

      min = k * 3
      paths.each do |p|
        ps = prodSum( p )
        min = ps if ps && ps < min
      end
      mins << min

      extended = []
      paths.each {|p| extended += extendPath( p, k + 1 )}
      paths = extended
    end

    mins.uniq.reduce( :+ )
  end
end
