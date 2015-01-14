require 'projectEuler'

# 1483s (1/13/15, #6267)
class Problem_0114
  def title; 'Counting block combinations I' end
  def solution; 16_475_640_049 end

  # A row measuring seven units in length has red blocks with a minimum length
  # of three units placed on it, such that any two red blocks (which are
  # allowed to be different lengths) are separated by at least one black
  # square. There are exactly seventeen ways of doing this (see
  # problem_0113.png).
  #
  # How many ways can a row measuring fifty units in length be filled?
  #
  # NOTE: Although the example above does not lend itself to the possibility,
  # in general it is permitted to mix block sizes. For example, on a row
  # measuring eight units in length you could use red (3), black (1), and red
  # (4).

  def count( spaces, min, tabs )
#    puts "%sSpaces: #{spaces}" % ('  ' * tabs)
    total = 0

    unless min > spaces
      (min..spaces).each do |len|
#        puts "%s  Length: #{len}" % ('  ' * tabs)
        total += spaces - len + 1

        (spaces - len - 1).downto( min ) do |sub|
          total += count( sub, min, tabs + 1 )
#          puts "%s  Total: #{total}" % ('  ' * tabs)
        end
      end
    end
#    puts "%s-----" % ('  ' * tabs)

    total
  end

#  def solve( n = 50 )
  def solve( n = 50 )
    1 + count( n, 3, 0 )
  end
end
