require 'projectEuler'

# Magic 5-gon ring
class Problem_0068
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

  def self.solve( n )
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

              start = [a, b, c, d, e].min
              (1..10).each do |f|
                next if f == e || f == d || f == c || f == b || f == a
                (1..10).each do |g|
                  next if g == f || g == e || g == d || g == c || g == b || g == a
                  (1..10).each do |h|
                    next if h == g || h == f || h == e || h == d || h == c || h == b || h == a
                    (1..10).each do |i|
                      next if i == h || i == g || i == f || i == e || i == d || i == c || i == b || i == a
                      (1..10).each do |j|
                        next if j == i || j == h || j == g || j == f || j == e || j == d || j == c || j == b || j == a

                        t = a + f + g
                        next if t != b + g + h
                        next if t != c + h + i
                        next if t != d + i + j
                        next if t != e + j + f

                        s = [a, f, g, b, g, h, c, h, i, d, i, j, e, j, f].join if a == start
                        s = [b, g, h, c, h, i, d, i, j, e, j, f, a, f, g].join if b == start
                        s = [c, h, i, d, i, j, e, j, f, a, f, g, b, g, h].join if c == start
                        s = [d, i, j, e, j, f, a, f, g, b, g, h, c, h, i].join if d == start
                        s = [e, j, f, a, f, g, b, g, h, c, h, i, d, i, j].join if e == start
                        next if 16 != s.length

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

    puts max
  end
end

ProjectEuler.time do
  # 6531031914842725 (23.41s)
  Problem_0068.solve( 16 )
end
