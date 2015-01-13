require 'projectEuler'

# 0.003449s (1/12/15, #6327)
class Problem_0107
  def title; 'Minimal network' end
  def solution; 259_679 end

  # The undirected network depicted by problem_0107_1.gif consists of seven
  # vertices and twelve edges with a total weight of 243.
  #
  # The same network can be represented by the matrix below.
  #
  #          A   B   C   D   E   F   G
  #      A   -  16  12  21   -   -   -
  #      B  16   -   -  17  20   -   -
  #      C  12   -   -  28   -  31   -
  #      D  21  17  28   -  18  19  23
  #      E   -  20   -  18   -   -  11
  #      F   -   -  31  19   -   -  27
  #      G   -   -   -  23  11  27   -
  #
  # However, it is possible to optimise the network by removing some edges and
  # still ensure that all points on the network remain connected. The network
  # which achieves the maximum saving is shown in problem_0107_2.gif. It has a
  # weight of 93, representing a saving of 243 − 93 = 150 from the original
  # network.
  #
  # Using 0107_network.txt, a 6K text file containing a network with forty
  # vertices, and given in matrix form, find the maximum saving which can be
  # achieved by removing redundant edges whilst ensuring that the network
  # remains connected.

  def solve
    rows = File.readlines( 'resources/0107_network.txt' )
    rows.map! {|row| row.scan( /[-\d]+/ ).map {|s| '-' == s ? nil : s.to_i}}

    # By definition, the 'optimised' network will be the minimum spanning tree
    # (MST) of the original graph.
    g = ProjectEuler::Graph.new( rows )

    # Total weight is doubled since our computation assumes the graph is dir-
    # ected (which it isn't, in this case).
    (g.total_weight - g.min_span.total_weight) >> 1
  end
end
