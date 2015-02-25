require 'projectEuler'

# 0.002644s (1/11/14, #15315)
class Problem_0099
  def title; 'Largest exponential' end

  # Comparing two numbers written in index form like 2^11 and 3^7 is not
  # difficult, as any calculator would confirm that 2^11 = 2048 < 3^7 = 2187.
  #
  # However, confirming that 632382^518061 > 519432^525806 would be much more
  # difficult, as both numbers contain over three million digits.
  #
  # Using 0099_base_exp.txt, a 22K text file containing one thousand lines with
  # a base/exponent pair on each line, determine which line number has the
  # greatest numerical value.
  #
  # NOTE: The first two lines in the file represent the numbers in the example
  # given above.

  def refs; [] end
  def solution; 709 end
  def best_time; 0.002644 end

  def completed_on; '2014-01-11' end
  def ordinality; 15_315 end
  def population; 362_773 end

  def compare( tuples, i, j )
    a, x = tuples[i][0], tuples[i][1]
    b, y = tuples[j][0], tuples[j][1]

    a, x, b, y, i, j = b, y, a, x, j, i if x > y
    a / b.to_f > b**((y - x) / x.to_f) ? i : j
  end

  def solve
    tuples = IO.read( 'resources/0099_base_exp.txt' ).split().map {|line| line.split( ',' ).map( &:to_i )}
    max = 0

    (1...tuples.length).each {|i| max = compare( tuples, max, i )}
    1 + max
  end
end
