require 'projectEuler'

# 1.360s (2/16/14, #8339)
class Problem_0096
  def title; 'Su Doku' end

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
  # The 6K text file, 0096_sudoku.txt, contains fifty different Su Doku
  # puzzles ranging in difficulty, but all with unique solutions (the first
  # puzzle in the file is the example above).
  #
  # By solving all fifty puzzles find the sum of the 3-digit numbers found in
  # the top left corner of each solution grid; for example, 483 is the 3-digit
  # number found in the top left corner of the solution grid above.

  def refs; [] end
  def solution; 24_702 end
  def best_time; 1.360 end

  def completed_on; '2014-02-16' end
  def ordinality; 8_339 end
  def percentile; 97.92 end

  def solve
    # Parse data file into an array of puzzles, each of which is an array of
    # rows, each of which is an array of values.
    grids = IO.read( 'resources/0096_sudoku.txt' ).split( /Grid [0-9]+\n/ )[1..-1]
    grids.map! do |g|
      g.gsub( /\n/, '' ).split( '' ).map( &:to_i ).each_slice( 9 ).to_a
    end

    # Solve each puzzle.
    grids.map! {|g| ProjectEuler::SuDoku.solve( g )}

    # Sum 3-digit values formed by the first three numbers in the first row of
    # each solved puzzle.
    grids.inject( 0 ) {|acc, g| acc + g[0][0, 3].join.to_i}
  end
end
