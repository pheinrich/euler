require 'projectEuler'

# 0.03446s (1/9/14, #5162)
class Problem_0090
  def title; 'Cube digit pairs' end

  # Each of the six faces on a cube has a different digit (0 to 9) written on
  # it; the same is done to a second cube. By placing the two cubes
  # side-by-side in different positions we can form a variety of 2-digit
  # numbers.
  #
  # For example, the square number 64 could be formed (see diagram).
  #
  # In fact, by carefully choosing the digits on both cubes it is possible to
  # display all of the square numbers below one-hundred: 01, 04, 09, 16, 25,
  # 36, 49, 64, and 81.
  #
  # For example, one way this can be achieved is by placing {0, 5, 6, 7, 8, 9}
  # on one cube and {1, 2, 3, 4, 8, 9} on the other cube.
  #
  # However, for this problem we shall allow the 6 or 9 to be turned upside-
  # down so that an arrangement like {0, 5, 6, 7, 8, 9} and {1, 2, 3, 4, 6, 7}
  # allows for all nine square numbers to be displayed; otherwise it would be
  # impossible to obtain 09.
  #
  # In determining a distinct arrangement we are interested in the digits on
  # each cube, not the order.
  #
  #     {1, 2, 3, 4, 5, 6} is equivalent to {3, 6, 4, 1, 2, 5}
  #     {1, 2, 3, 4, 5, 6} is distinct from {1, 2, 3, 4, 5, 9}
  #
  # But because we are allowing 6 and 9 to be reversed, the two distinct sets
  # in the last example both represent the extended set {1, 2, 3, 4, 5, 6, 9}
  # for the purpose of forming 2-digit numbers.
  #
  # How many distinct arrangements of the two cubes allow for all of the
  # square numbers to be displayed?

  def refs; [] end
  def solution; 1_217 end
  def best_time; 0.03446 end

  def completed_on; '2014-01-09' end
  def ordinality; 5_162 end
  def population; 362_277 end

  def check_squares?( d1, d2 )
    ((d1.include?( 0 ) && d2.include?( 1 )) || (d2.include?( 0 ) && d1.include?( 1 ))) &&
    ((d1.include?( 0 ) && d2.include?( 4 )) || (d2.include?( 0 ) && d1.include?( 4 ))) &&
    ((d1.include?( 0 ) && (d2.include?( 9 ) || d2.include?( 6 ))) || (d2.include?( 0 ) && (d1.include?( 9 ) || d1.include?( 6 )))) &&
    ((d1.include?( 1 ) && (d2.include?( 6 ) || d2.include?( 9 ))) || (d2.include?( 1 ) && (d1.include?( 6 ) || d1.include?( 9 )))) &&
    ((d1.include?( 2 ) && d2.include?( 5 )) || (d2.include?( 2 ) && d1.include?( 5 ))) &&
    ((d1.include?( 3 ) && (d2.include?( 6 ) || d2.include?( 9 ))) || (d2.include?( 3 ) && (d1.include?( 6 ) || d1.include?( 9 )))) &&
    ((d1.include?( 4 ) && (d2.include?( 9 ) || d2.include?( 6 ))) || (d2.include?( 4 ) && (d1.include?( 9 ) || d1.include?( 6 )))) &&
    ((d1.include?( 8 ) && d2.include?( 1 )) || (d2.include?( 8 ) && d1.include?( 1 )))
  end

  def solve
    cubes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].combination( 6 ).to_a
    sum = 0

    (0...cubes.length-1).each do |i|
      (i+1...cubes.length).each do |j|
        sum += 1 if check_squares?( cubes[i], cubes[j] )
      end
    end

    sum
  end
end
