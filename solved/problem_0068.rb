require 'projectEuler'

# 2.017s (12/17/13)
class Problem_0068
  def title; 'Magic 5-gon ring' end
  def solution; 6_531_031_914_842_725 end

  # Consider the following "magic" 3-gon ring, filled with the numbers 1 to 6,
  # and each line adding to nine.
  #
  #          (4)
  #            \
  #           (3)
  #           / \
  #        (1)--(2)--(6)
  #        /
  #     (5)
  #
  # Working clockwise, and starting from the group of three with the
  # numerically lowest external node (4,3,2 in this example), each solution
  # can be described uniquely. For example, the above solution can be
  # described by the set: 4,3,2; 6,2,1; 5,1,3.
  #
  # It is possible to complete the ring with four different totals: 9, 10, 11,
  # and 12. There are eight solutions in total.
  #
  #     Total      Solution Set
  #     -----  -------------------
  #        9   4,2,3; 5,3,1; 6,1,2
  #        9   4,3,2; 6,2,1; 5,1,3
  #       10   2,3,5; 4,5,1; 6,1,3
  #       10   2,5,3; 6,3,1; 4,1,5
  #       11   1,4,6; 3,6,2; 5,2,4
  #       11   1,6,4; 5,4,2; 3,2,6
  #       12   1,5,6; 2,6,4; 3,4,5
  #       12   1,6,5; 3,5,4; 2,4,6
  #
  # By concatenating each group it is possible to form 9-digit strings; the
  # maximum string for a 3-gon ring is 432621513.
  #
  # Using the numbers 1 to 10, and depending on arrangements, it is possible
  # to form 16- and 17-digit strings. What is the maximum 16-digit string for
  # a "magic" 5-gon ring?
  #
  #            ( )
  #              \
  #              ( )      ( )
  #            /     \   /  
  #         ( )       ( )
  #        /  \      /
  #     ( )   ( )-( )--( )
  #            \
  #            ( )

  def solve( n = 16 )
    max = 0
    
    (1..10).each do |a|
      (1..10).each do |b|
        next if b == a
        (1..10).each do |c|
          next if c == b || c == a
          (1..10).each do |d|
            next if d == c || d == b || d == a
            (1..10).each do |e|
              next if e == d || e == c || e == b || e == a

              rotate = 3*[a, b, c, d, e].each_with_index.min[1]
              (1..10).each do |f|
                next if f == e || f == d || f == c || f == b || f == a
                (1..10).each do |g|
                  next if g == f || g == e || g == d || g == c || g == b || g == a
                  
                  t = a + f + g
                  (1..10).each do |h|
                    next if h == g || h == f || h == e || h == d || h == c || h == b || h == a
                    next unless t == b + g + h

                    (1..10).each do |i|
                      next if i == h || i == g || i == f || i == e || i == d || i == c || i == b || i == a
                      next unless t == c + h + i

                      (1..10).each do |j|
                        next if j == i || j == h || j == g || j == f || j == e || j == d || j == c || j == b || j == a
                        next unless t == d + i + j && t == e + j + f

                        s = [a, f, g, b, g, h, c, h, i, d, i, j, e, j, f]
                        rotate.times {s.push s.shift}

                        s = s.join
                        next if n != s.length

                        max = [max, s.to_i].max
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end

    max
  end
end
