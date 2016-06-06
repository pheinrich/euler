require 'projectEuler'

# 0.02057s (1/9/14, #10791)
class Problem_0089
  def title; 'Roman numerals' end
  def difficulty; 20 end

  # The rules for writing Roman numerals allow for many ways of writing each
  # number (see About Roman Numerals...). However, there is always a "best"
  # way of writing a particular number.
  #
  # For example, the following represent all of the legitimate ways of writing
  # the number sixteen:
  #
  #     IIIIIIIIIIIIIIII
  #     VIIIIIIIIIII
  #     VVIIIIII
  #     XIIIIII
  #     VVVI
  #     XVI
  #
  # The last example being considered the most efficient, as it uses the least
  # number of numerals.
  #
  # The 11K text file 0089_roman.txt contains one thousand numbers written in
  # valid, but not necessarily minimal, Roman numerals; that is, they are
  # arranged in descending units and obey the subtractive pair rule (see About
  # Roman Numerals... for the definitive rules for this problem).
  #
  # Find the number of characters saved by writing each of these in their
  # minimal form.
  #
  # Note: You can assume that all the Roman numerals in the file contain no
  # more than four consecutive identical units.

  def solve
    t = IO.read( 'resources/0089_roman.txt' ).split.map do |line|
      n = ProjectEuler::Roman.to_i( line )
      line.length - ProjectEuler::Roman.from_i( n ).length
    end

    t.inject( :+ )
  end

  def solution; 743 end
  def best_time; 0.02057 end
  def effort; 15 end

  def completed_on; '2014-01-09' end
  def ordinality; 10_791 end
  def population; 362_277 end

  def refs; [] end
end
