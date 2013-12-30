require 'projectEuler'

# 10.37s (12/29/13, #17059)
class Problem_0081
  def title; 'Path sum: two ways' end
  def solution; 427337 end

  # In the 5 by 5 matrix below, the minimal path sum from the top left to the
  # bottom right, by only moving to the right and down, is indicated and is
  # equal to 2427.
  #
  #     (131)  673   234   103    18
  #     (201) ( 96) (342)  965   150
  #      630   803  (746) (422)  111
  #      537   699   497  (121)  956
  #      805   732   524  ( 37) (331)
  #
  # Find the minimal path sum, in matrix.txt, a 31K text file containing an
  # 80 by 80 matrix, from the top left to the bottom right by only moving
  # right and down.

  def solve
    rows = File.readlines( 'resources/matrix.txt' )
    rows.map! {|row| row.scan( /\d+/ ).map( &:to_i )}

    g = ProjectEuler::Graph.new
    w, h = rows[0].length, rows.length

    # Weight the paths between nodes according to the text file.  Each path
    # is one-way, with the cost equal to the value at the destination node.
    (0...w).each do |i|
      (0...h).each do |j|
        # Connect each node with the one to its left.
        g.connect( j*w + i - 1, j*w + i, rows[j][i] )

        # Connect each node with the one below it.
        g.connect( (j*w - w) + i, j*w + i, rows[j][i] )
      end
    end

    # Make sure the destination node is part of the graph (nodes with out-
    # bound paths are included automatically, but in this case the target has
    # only in-bound connections).  Don't bother deleting the spurious -1 node
    # created when building the connections above; it's harmless in this case.
    g.add( w*h - 1 )

    # Add the weight of the first node, since it isn't included in the total.
    rows[0][0] + g.dijkstra( 0, w*h - 1 )
  end
end
