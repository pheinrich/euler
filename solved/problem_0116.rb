require 'projectEuler'

# 0.0005181s (1/14/15, #6967)
class Problem_0116
  def title; 'Red, green or blue tiles' end
  def solution; 20_492_570_929 end

  # A row of five black square tiles is to have a number of its tiles replaced
  # with coloured oblong tiles chosen from red (length two), green (length
  # three), or blue (length four).
  #
  # If red tiles are chosen there are exactly seven ways this can be done. If
  # green tiles are chosen there are three ways. And if blue tiles are chosen
  # there are two ways. (See problem_0116.png.)
  #
  # Assuming that colours cannot be mixed there are 7 + 3 + 2 = 12 ways of re-
  # placing the black tiles in a row measuring five units in length.
  #
  # How many different ways can the black tiles in a row measuring fifty units
  # in length be replaced if colours cannot be mixed and at least one coloured
  # tile must be used?
  #
  # NOTE: This is related to Problem 117.

  def fill( len, row, memo )
    return memo[row] if memo[row]

    total = 0
    if len <= row
      total += row - len + 1
      (row - len).downto( len ) do |sub|
        total += fill( len, sub, memo )
      end
    end

    memo[row] = total
  end

  def solve( n = 50, len = [2, 3, 4] )
    len.map {|l| fill( l, n, {} )}.reduce( :+ )
  end
end
