require 'projectEuler'

# Permuted multiples
class Problem_0052
  # It can be seen that the number, 125874, and its double, 251748, contain
  # exactly the same digits, but in a different order.
  #
  # Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x
  # contain the same digits.

  def self.solve( n )
    1.upto( 999999 ) do |i|
      a = i.to_s.codepoints.sort
      2.upto( n ) do |x|
        break unless (x*i).to_s.codepoints.sort == a

        if x == n
          puts i
          return
        end
      end
    end
  end
end

ProjectEuler.time do
  # 142857 (1.845s)
  Problem_0052.solve( 6 )
end
