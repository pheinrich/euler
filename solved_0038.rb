require 'projectEuler'

# Pandigital multiples
class Problem_0038
  # Take the number 192 and multiply it by each of 1, 2, and 3:
  #
  #     192 x 1 = 192
  #     192 x 2 = 384
  #     192 x 3 = 576
  #
  # By concatenating each product we get the 1 to 9 pandigital, 192384576. We
  # will call 192384576 the concatenated product of 192 and (1,2,3)
  #
  # The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4,
  # and 5, giving the pandigital, 918273645, which is the concatenated product
  # of 9 and (1,2,3,4,5).
  #
  # What is the largest 1 to 9 pandigital 9-digit number that can be formed as
  # the concatenated product of an integer with (1,2, ... , n) where n > 1?

  def self.solve()
    d = %w(1 2 3 4 5 6 7 8 9).permutation.map {|i| i.join}.select {|i| i >= '918273645'}.reverse
 
    d.each do |i|
      1.upto( 4 ) do |j|
        s = i[0, j]
        n = s.to_i

        2.upto( 5 ) do |k|
          s += (k * n).to_s
          if s == i
            puts "%s (1..%d x %d)" % [i, k, n]
            return
          end

          break if !i.start_with?( s )
        end
      end
    end
  end
end

ProjectEuler.time do
  # 932718654 (1..2 x 9327)
  Problem_0038.solve()
end