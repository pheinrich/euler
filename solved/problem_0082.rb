require 'projectEuler'

class Problem_0082
  def title; 'Path sum: three ways' end
  def difficulty; 20 end

  # NOTE: This problem is a more challenging version of Problem 81.
  #
  # The minimal path sum in the 5 by 5 matrix below, by starting in any cell
  # in the left column and finishing in any cell in the right column, and only
  # moving up, down, and right, is indicated; the sum is equal to 994.
  #
  #      131   673  (234) (103) ( 18)
  #     (201) ( 96) (342)  965   150
  #      630   803   746   422   111
  #      537   699   497   121   956
  #      805   732   524    37   331
  #
  # Find the minimal path sum, in 0081_matrix.txt, a 31K text file containing
  # an 80 by 80 matrix, from the left column to the right column.

  def solve
    rows = File.readlines( 'resources/0081_matrix.txt' )
    rows.map! {|row| row.scan( /\d+/ ).map( &:to_i )}

    g = ProjectEuler::Graph.new
    w, h = rows[0].length, rows.length

    # Weight the paths between nodes according to the text file.  Horizontal
    # paths are one-way (to the right) while vertical paths are two-way (up or
    # down), with the cost equal to the value at the destination node. Process
    # the left column and top row separately, to prevent roll-over across
    # matrix boundaries.
    (1...w).each {|i| g.connect( i - 1, i, rows[0][i] )}
    (1...h).each {|j| g.connect( j*w - w, j*w, rows[j][0], rows[j - 1][0] )}

    # Now weight the bulk of the matrix.
    (1...w).each do |i|
      (1...h).each do |j|
        g.connect( j*w + i - 1, j*w + i, rows[j][i] )
        g.connect( (j*w - w) + i, j*w + i, rows[j][i], rows[j - 1][i] )
      end
    end

    # Add some special nodes/paths to optimize computation.  Rather than run
    # Dijkstra from every entry in the left column, selecting a winner from
    # right-column targets, add a node to the left of and connected to every
    # node in the left column.  Similarly, create a single target node that's
    # connected to and right of all nodes in the right column.
    (0...h).each {|j| g.connect( -1, j*w, rows[j][0] ).connect( j*w + w - 1, w*h, 0 )}

    # Ensure that new target node is part of the graph, then compute the least
    # cost path between the new "special" nodes.
    g.add( w*h )
    g.dijkstra( -1, w*h )
  end

  def solution; 'MjYwMzI0' end
  def best_time; 10.09 end
  def effort; 15 end
  
  def completed_on; '2013-12-30' end
  def ordinality; 10_299 end
  def population; 381_804 end

  def refs; [] end
end
