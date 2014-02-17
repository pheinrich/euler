require 'projectEuler'

# 1.360s (2/16/14, #8339)
class Problem_0096
  def title; 'Su Doku' end
  def solution; 24_702  end

  # Su Doku (Japanese meaning number place) is the name given to a popular
  # puzzle concept. Its origin is unclear, but credit must be attributed to
  # Leonhard Euler who invented a similar, and much more difficult, puzzle
  # idea called Latin Squares. The objective of Su Doku puzzles, however, is
  # to replace the blanks (or zeros) in a 9 by 9 grid in such that each row,
  # column, and 3 by 3 box contains each of the digits 1 to 9. See diagram
  # for an example of a typical starting puzzle grid and its solution grid.
  #
  # A well constructed Su Doku puzzle has a unique solution and can be solved
  # by logic, although it may be necessary to employ "guess and test" methods
  # in order to eliminate options (there is much contested opinion over this).
  # The complexity of the search determines the difficulty of the puzzle; the
  # example above is considered easy because it can be solved by straight
  # forward direct deduction.
  #
  # The 6K text file, sudoku.txt, contains fifty different Su Doku puzzles
  # ranging in difficulty, but all with unique solutions (the first puzzle in
  # the file is the example above).
  #
  # By solving all fifty puzzles find the sum of the 3-digit numbers found in
  # the top left corner of each solution grid; for example, 483 is the 3-digit
  # number found in the top left corner of the solution grid above.

  DIGITS = (1..9).to_a

  def constraints( grid )
    r, c, s = [], [], []

    # Determine which values are missing from each row, column, and subsquare.
    (0...9).each do |i| 
      r[i] = DIGITS - grid[i]
      c[i] = DIGITS - grid.map {|row| row[i]}
      s[i] = DIGITS - grid.map {|row| row[i%3 * 3, 3]}[i/3 * 3, 3].flatten
    end

    return r, c, s
  end

  def doSuDoku( unsolved )
    grid = unsolved.map( &:dup )

    # Substitute values as long as there are empty squares.
    while 0 < grid.flatten.count( 0 )
      r, c, s = constraints( grid )
      min, x, y = DIGITS, 0, 0
  
      # Look at each blank square in the grid and determine which values would
      # be valid there. 
      (0...9).each do |i|
        (0...9).each do |j|
          next unless 0 == grid[j][i]
  
          # Only values that are missing from the corresponding row, column,
          # and subsquare are valid.  This may be more than one number, or
          # none.  If none, the puzzle isn't solvable.
          vals = r[j] & c[i] & s[j/3 * 3 + i/3]
          return nil if 0 == vals.count

          # If exactly one number is valid here, hooray.  Go ahead and insert
          # it, then recompute the constraints.
          if 1 == vals.count
            grid[j][i] = vals[0]
            r, c, s = constraints( grid )
          end

          # Chances are (for difficult puzzles), there will be no single
          # choices.  Keep track of the first space with the fewest options
          # for later guessing.
          min, x, y = vals, i, j if vals.count < min.count
        end
      end

      # If there were no "easy wins" above, we must pick a square and insert
      # each of its candidate values in turn, looking for one that leads to a
      # solution.  
      if 1 < min.count
        guess = nil

        # Substitute each candidate value for the chosen square and solve.
        for v in min
          grid[y][x] = v

          # If the grid isn't solvable, recursively try the next value.  One
          # of them is guaranteed to work.
          guess = doSuDoku( grid )
          break if guess
        end

        # Return the solution, or nil if this path was a dead end.  In that
        # case, we'll end up backtracking in order to try a different branch.
        return guess
      end
    end

    grid
  end

  def solve
    # Parse data file into an array of puzzles, each of which is an array of
    # rows, each of which is an array of values.
    grids = IO.read( 'resources/sudoku.txt' ).split( /Grid [0-9]+\n/ )[1..-1]
    grids.map! do |g|
      g.gsub( /\n/, '' ).split( '' ).map( &:to_i ).each_slice( 9 ).to_a
    end

    # Solve each puzzle.
    grids.map! {|g| doSuDoku( g )}

    # Sum 3-digit values formed by the first three numbers in the first row of
    # each solved puzzle.
    grids.inject( 0 ) {|acc, g| acc + g[0][0, 3].join.to_i}
  end
end
