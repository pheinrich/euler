require 'projectEuler'

# 
class Problem_0122
  def title; 'Efficient exponentiation' end

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

  def refs
    ["http://en.wikipedia.org/wiki/Addition-chain_exponentiation",
     "https://oeis.org/A003313",
     "http://cr.yp.to/papers/pippenger.pdf",
     "http://wwwhomes.uni-bielefeld.de/achim/ac.ps.gz",
     "http://wwwhomes.uni-bielefeld.de/achim/addition_chain.html"]
  end

  class Tree
    attr_accessor :parent, :children, :value
    
    def initialize( value, parent = nil )
      @value = value
      @parent = parent
      @children = []
    end

    def add( value )
      @children << Tree.new( value, self )
    end

    def pp( tab = 0 )
      puts "%sValue = #{@value} (Parent: #{@parent ? @parent.value : 'nil'})" % ['  ' * tab]
      @children.each {|c| c.pp( tab + 1)}
    end

    def build_power( root, depth )
      s, p = [], @parent
      while p
        s << (@value + p.value)
        p = p.parent
      end
      s << (@value << 1)

      s.each {|v| add( v ) unless root.dfs( v )}
      @children.each {|c| c.build_power( root, depth - 1)} if 1 < depth 
    end

    def dfs( value )
      return true if @value == value

      for c in @children
        return true if c.dfs( value )
      end

      false
    end

    def bfs( value )
      stack = []
      c = self

      while c
        return true if c.value == value
        stack += c.children
        c = stack.shift
      end

      false
    end
  end

  def solution; end
  def best_time; end

  def completed_on; '2015-02-??' end
  def ordinality; end
  def percentile; end

  def build_tree( root, max )
    
  end

  def solve( k = 200 )
    root = Tree.new( 1 )
    root.build_power( root, 7 )
    root.pp
  end
end
