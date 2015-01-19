require 'projectEuler'

# 142.6s (1/18/15, #3433)
class Problem_0127
  def title; 'abc-hits' end
  def solution; 18_407_904 end

  # The radical of n, rad(n), is the product of distinct prime factors of n.
  # For example, 504 = 2^3 × 3^2 × 7, so rad(504) = 2 × 3 × 7 = 42.
  #
  # We shall define the triplet of positive integers (a, b, c) to be an
  # abc-hit if:
  #
  #      GCD(a, b) = GCD(a, c) = GCD(b, c) = 1
  #      a < b
  #      a + b = c
  #      rad(abc) < c
  #
  # For example, (5, 27, 32) is an abc-hit, because:
  #
  #      GCD(5, 27) = GCD(5, 32) = GCD(27, 32) = 1
  #      5 < 27
  #      5 + 27 = 32
  #      rad(4320) = 30 < 32
  #
  # It turns out that abc-hits are quite rare and there are only thirty-one abc-hits for c < 1000, with ∑c = 12523.
  #
  # Find ∑c for c < 120000.

  def solve( max = 120000)#20_000 )
    # http://www.mathpages.com/home/kmath194.htm
    rads = max.radical_sieve
    nsf = (1...max).select {|i| i > rads[i]}   # non-square-free candidates for c
#    puts "#{nsf.count}"
    count = 0
    sum = 0
    nsf.each do |c|
      puts "...#{c}" if 0 == c % 5000
      check = c / c.rad
      (1...c/2).each do |a|
        if rads[a]*rads[c-a] < check
          if a.coprime?(c)
            count += 1
            sum += c
#            puts "#{a} + #{c-a} = #{c}"
          end
        end
      end
    end

    puts "count = #{count}"
    sum
  end
end
