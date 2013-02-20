require 'projectEuler'

# Sub-string divisibility
class Problem_0043
  # The number 1406357289 is a 0 to 9 pandigital number because it is made up
  # of each of the digits 0 to 9 in some order, but it also has a rather
  # interesting sub-string divisibility property.
  #
  # Let d[1] be the 1st digit, d[2] be the 2nd digit, and so on. In this way,
  # we note the following:
  #
  #     d[2]d[3]d[4]  = 406 is divisible by 2  d[1] = j
  #     d[3]d[4]d[5]  = 063 is divisible by 3  d[2] = k
  #     d[4]d[5]d[6]  = 635 is divisible by 5  d[3] = l
  #     d[5]d[6]d[7]  = 357 is divisible by 7  d[4] = m
  #     d[6]d[7]d[8]  = 572 is divisible by 11 d[5] = n
  #     d[7]d[8]d[9]  = 728 is divisible by 13 d[6] = o
  #     d[8]d[9]d[10] = 289 is divisible by 17 d[7] = p
  #
  # Find the sum of all 0 to 9 pandigital numbers with this property.

  def self.solve()
    # Initialize some lists of 3-digit numbers divisible by the first few
    # primes.  That is, 2|all values in p[0]; 3|all values in p[1], etc.
    p = [1, 2, 3, 5, 7, 11, 13, 17]
    d = p.map {|i| (12..987).reject {|j| 0 != j % i || "%03d" % j =~ /([0-9]).*\1/}.map {|k| "%03d" % k}}
    sum = 0

    # Pretty much the ugliest implementation yet.
    d[0].each do |i|
      d[1].each do |j|
        next if !j.start_with?( i[1, 2] )
        d[2].each do |k|
          next if !k.start_with?( j[1, 2] )
          d[3].each do |l|
            next if !l.start_with?( k[1, 2] )
            d[4].each do |m|
              next if !m.start_with?( l[1, 2] )
              d[5].each do |n|
                next if !n.start_with?( m[1, 2] )
                d[6].each do |o|
                  next if !o.start_with?( n[1, 2] )
                  d[7].each do |p|
                    next if !p.start_with?( o[1, 2] )
                    s = i[0] + j + m + p
                    sum += s.to_i unless s =~ /(.).*\1/
                  end
                end
              end
            end
          end
        end
      end
    end

    puts sum
  end
end

ProjectEuler.time do
  # 16695334890
  Problem_0043.solve()
end
