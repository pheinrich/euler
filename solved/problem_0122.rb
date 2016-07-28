require 'projectEuler'

class Problem_0122
  def title; 'Efficient exponentiation' end
  def difficulty; 40 end

  # The most naive way of computing n^15 requires fourteen multiplications:
  #
  #      n × n × ... × n = n^15
  #
  # But using a "binary" method you can compute it in six multiplications:
  #
  #      n    × n   = n^2
  #      n^2  × n^2 = n^4
  #      n^4  × n^4 = n^8
  #      n^8  × n^4 = n^12
  #      n^12 × n^2 = n^14
  #      n^14 × n   = n^15
  #
  # However it is yet possible to compute it in only five multiplications:
  #
  #      n    × n   = n^2
  #      n^2  × n   = n^3
  #      n^3  × n^3 = n^6
  #      n^6  × n^6 = n^12
  #      n^12 × n^3 = n^15
  #
  # We shall define m(k) to be the minimum number of multiplications to
  # compute n^k; for example m(15) = 5.
  #
  # For 1 ≤ k ≤ 200, find ∑ m(k).

  def build( node, depth, max, memo )
    # Exit if we've built the tree deep enough.
    return if max < depth

    # Collect all possible combinations of this node with itself and each of
    # its ancestors.
    s, p = [node.value << 1], node.parent
    while p
      s << (node.value + p.value)
      p = p.parent
    end

    # Preserve each combination that may lead to a valid chain later. 
    s.each do |v|
      # If the current depth is the same or better than one we've recorded
      # already for this value, memoize the depth and add the value as a
      # child node to be processed in turn.
      if memo[v] >= depth
        memo[v] = depth
        node.add( v )
      end
    end
  end

  def solve( k = 200 )
    # Create a hash and memoize intermediate values and estimate the chain
    # length necessary to represent the upper bound, k.
    memo = Hash.new {k}
    depth = (2 * Math.log( k )).ceil

    # Build a tree of all possible addition chains. It is essentially an un-
    # optimized version of Knuth's power tree. 
    root = ProjectEuler::Tree.new( 1 )
    root.dfi( lambda {|n, d| build( n, d, depth, memo )} )

    # Drop observed minimum depths for values beyond the upper bound, k,
    # then sum those remaining.
    memo.reject {|h, v| h > k}.reduce( 0 ) {|acc, (h, v)| acc + 1 + v}
  end

  def solution; 'MTU4Mg==' end
  def best_time; 0.6977 end
  def effort; 40 end
  
  def completed_on; '2015-02-16' end
  def ordinality; 4_447 end
  def population; 462_287 end
  
  def refs
    ['http://en.wikipedia.org/wiki/Addition-chain_exponentiation',
     'https://oeis.org/A003313',
     'http://cr.yp.to/papers/pippenger.pdf',
     'http://wwwhomes.uni-bielefeld.de/achim/ac.ps.gz',
     'http://wwwhomes.uni-bielefeld.de/achim/addition_chain.html']
  end
end
