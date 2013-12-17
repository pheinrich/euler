require 'projectEuler'

# Reciprocal cycles
class Problem_0026
  # A unit fraction contains 1 in the numerator. The decimal representation of
  # the unit fractions with denominators 2 to 10 are given:
  #
  #     1/2 =   0.5
  #     1/3 =   0.(3)
  #     1/4 =   0.25
  #     1/5 =   0.2
  #     1/6 =   0.1(6)
  #     1/7 =   0.(142857)
  #     1/8 =   0.125
  #     1/9 =   0.(1)
  #     1/10  =   0.1
  #
  # Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can
  # be seen that 1/7 has a 6-digit recurring cycle.
  #
  # Find the value of d < 1000 for which 1/d contains the longest recurring
  # cycle in its decimal fraction part.

  def self.solve( n )
    # Divide 1 by every number up to n, recording the length of repeating
    # digits that repeat.
    lens = (2...n).map do |i|
      d = []
      r = 1

      # Do long division, stopping only if the decimal terminates or we see
      # a remainder we've seen before (indicating the beginning of a cycle).
      while true
        r = 10 * (r % i)
        break if 0 == r || d.include?( r )

        # No cycle, but it didn't terminate.  Add the remainder and calculate
        # a new one.
        d << r
        r = r % i
      end

      d.length
    end

    # Return the index of the largest length value, offset to account for the
    # fact that we didn't divide by 0 or 1.
    puts 2 + lens.each_with_index.max[1]
  end
end

ProjectEuler.time do
  # 983 (1.928s)
  Problem_0026.solve( 1000 )
end
