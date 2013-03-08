require 'projectEuler'

# Champernowne's constant
class Problem_0040
  # An irrational decimal fraction is created by concatenating the positive
  # integers:
  #
  #     0.123456789101112131415161718192021...
  #
  # It can be seen that the 12th digit of the fractional part is 1.
  #
  # If d[n] represents the nth digit of the fractional part, find the value of
  # the following expression.
  #
  #     d[1] x d[10] x d[100] x d[1000] x d[10000] x d[100000] x d[1000000]

  def self.solve( offsets )
    # Count of tuples         Relevant offsets     Expression    
    # 9 x 1 = 9            => [0, 9]            => o
    # 90 x 2 = 180         => [10, 189]         => (int[(o - 10) / 2] + 10)[2*frac]
    # 900 x 3 = 2700       => [190, 2889]       => (int[(o - 190) / 3] + 100)[3*frac]
    # 9000 x 4 = 36000     => [2890, 38889]     => (int[(o - 2890) / 4] + 1000)[4*frac]
    # 90000 x 5 = 450000   => [38890, 488889]   => (int[(o - 38890) / 5] + 10000)[5*frac]
    # 900000 x 6 = 5400000 => [488890, 5888889] => (int[(o - 488890) / 6] + 100000)[6*frac]
    count = 1.upto( Math.log10( offsets.max ) ).map {|i| 10**(i - 1) * 9 * i} 
    traunch = count.each_with_index.map {|i, j| [1 + count[0..j].reduce( :+ ), 2 + j]}
      
    product = offsets.reduce( 1 ) do |p, d|
      if 10 <= d
        t = traunch.select {|i| i[0] <= d}[-1]
        v = 10**(t[1] - 1) + (d - t[0]) / (1.0 * t[1])
        d = v.to_i.to_s[t[1] * (v - v.to_i)]
      end
     
      p * d.to_i
    end

    puts product
  end
end

ProjectEuler.time do
  # 210
  Problem_0040.solve( [1, 10, 100, 1000, 10000, 100000, 1000000] )
end
