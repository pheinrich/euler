require 'projectEuler'

# 10.20s (12/29/13, #8699)
class Problem_0083
  def title; 'Path sum: four ways' end
  def solution; 425_185 end

  # NOTE: This problem is a significantly more challenging version of Problem
  # 81.
  #
  # In the 5 by 5 matrix below, the minimal path sum from the top left to the
  # bottom right, by moving left, right, up, and down, is indicated and is
  # equal to 2297.
  #
  #     (131)  673  (234) (103) ( 18)
  #     (201) ( 96) (342)  965  (150)
  #      630   803   746  (422) (111)
  #      537   699   497  (121)  956
  #      805   732   524  ( 37) (331)
  #
  # Find the minimal path sum, in 0081_matrix.txt, a 31K text file containing
  # an 80 by 80 matrix, from the top left to the bottom right by moving left,
  # right, up, and down.

  def solve
    rows = File.readlines( 'resources/0081_matrix.txt' )
    rows.map! {|row| row.scan( /\d+/ ).map( &:to_i )}

    g = ProjectEuler::Graph.new
    w, h = rows[0].length, rows.length

    # Weight the paths between nodes according to the text file.  Each path
    # is two-way, with the cost equal to the value at the destination node.
    # Process the left column and top row separately, to prevent roll-over
    # across matrix boundaries.
    (1...w).each {|i| g.connect( i - 1, i, rows[0][i], rows[0][i - 1] )}
    (1...h).each {|j| g.connect( j*w - w, j*w, rows[j][0], rows[j - 1][0] )}

    # Now we can weight the bulk of the matrix.  Splitting construction of
    # these connections results in no spurious -1 node (a side effect of
    # running from 0 instead of 1).
    (1...w).each do |i|
      (1...h).each do |j|
        g.connect( j*w + i - 1, j*w + i, rows[j][i], rows[j][i - 1] )
        g.connect( (j*w - w) + i, j*w + i, rows[j][i], rows[j - 1][i] )
      end
    end

    # Add the weight of the first node, since it isn't included in the total.
    rows[0][0] + g.dijkstra( 0, w*h - 1 )
  end
end
