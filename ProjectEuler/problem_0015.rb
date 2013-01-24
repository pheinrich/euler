require 'projectEuler'

# Lattice paths
class Problem_0015
  # Starting in the top left corner of a 2 x 2 grid, there are 6 routes
  # (without backtracking) to the bottom right corner.
  #
  #     .....    ... .    ... .    . . .    . . .    . . .   
  #     . . |    . |..    . | .    |....    |.. .    | . .   
  #     . . v    . . V    . |.>    . . V    . |.>    |...>   
  #
  # How many routes are there through a 20 x 20 grid?

  def self.solve( n )
    puts "?"
  end
end

ProjectEuler.time do
  Problem_0015.solve( 20 )
end
