require 'projectEuler'

# 0.8128s (3/8/13, #25455)
class Problem_0038
  def title; 'Pandigital multiples' end
  def difficulty; 5 end

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

  def solve
    d = %w(1 2 3 4 5 6 7 8 9).permutation.map {|i| i.join}.select {|i| i >= '918273645'}.reverse
 
    d.each do |i|
      1.upto( 4 ) do |j|
        s = i[0, j]
        n = s.to_i

        2.upto( 5 ) do |k|
          s += (k * n).to_s
          return i.to_i if i == s # puts "%s (1..%d x %d)" % [i, k, n]

          break if !i.start_with?( s )
        end
      end
    end
  end

  def solution; 932_718_654 end
  def best_time; 0.7031 end
  def effort; 5 end
  
  def completed_on; '2013-03-08' end
  def ordinality; 25_455 end
  def population; 286_091 end

  def refs; [] end
end
