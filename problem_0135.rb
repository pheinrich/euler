require 'projectEuler'

class Problem_0135
  def title; 'Same differences' end
  def difficulty; 45 end

  # Given the positive integers, x, y, and z, are consecutive terms of an
  # arithmetic progression, the least value of the positive integer, n, for
  # which the equation, x^2 − y^2 − z^2 = n, has exactly two solutions is
  # n = 27:
  #
  #   34^2 − 27^2 − 20^2 = 12^2 − 9^2 − 6^2 = 27
  #
  # It turns out that n = 1155 is the least value which has exactly ten
  # solutions.
  #
  # How many values of n less than one million have exactly ten distinct
  # solutions?

  def count( n )
    f = n.factors
    sols = {}

    0.upto( (f.size - 1) >> 1 ) do |i|
      a = f[i] + f[~i]

      if 0 == a % 4
        a >>= 2

        x1 = Math.sqrt( 4*a*a - n ).to_i + 3*a
        sols[[x1, -a]] = true if 0 < x1 - 2*a

        x2 = -Math.sqrt( 4*a*a - n ).to_i + 3*a
        sols[[x2, -a]] = true if 0 < x2 - 2*a
      end
    end

    sols.count
  end

  def solve( limit = 1_000_000, sols = 10 )
    # x^2 - y^2 - z^2 = n
    # x^2 - (x + a)^2 - (x + 2a)^2 = n
    # x^2 - (x^2 + 2ax + a^2) - (x^2 + 4ax + 4a^2) = n
    # x^2 - x^2 - 2ax - a^2 - x^2 - 4ax - 4a^2 = n
    # -x^2 - 6ax - 5a^2 = n
    # x^2 + 6ax + 5a^2 = -n
    # (x + a)(x + 5a) = -n
    #
    # If we factorize n into pq pairs, we can quickly check which pairs
    # satisfy the above. E.g. when n = 1155,
    #
    #   (x + a)(x + 5a) = -n, so
    #   (-x - a)(x + 5a) = n
    #   (x + a)(-x - 5a) = n 
    #
    #   1155 = 1 x 1155  -->  x + a = 1, -x - 5a = 1155 --> -4a = 1156  -->  a = -289, x = 290
    #                        -x - a = 1, x + 5a = 1155  -->  4a = 1156  -->  a = 289, x = -290
    #        = 3 x 385   -->  x + a = 3, -x - 5a = 385  --> -4a = 388   -->  a = -97, x = 98
    #                        -x - a = 3, x + 5a = 385   -->  4a = 388   -->  a = 97, x = -98
    #        = 5 x 231   -->  x + a = 5, -x - 5a = 231  --> -4a = 236   -->  a = -59, x = 60
    #                        -x - a = 5, x + 5a = 231   -->  4a = 236   -->  a = 59, x = -60
    #        = 7 x 165   -->  x + a = 7, -x - 5a = 165  --> -4a = 172   -->  a = -43, x = 44
    #                        -x - a = 7, x + 5a = 165   -->  4a = 172   -->  a = 43, x = -44
    #        = 11 x 105  -->  x + a = 11, -x - 5a = 105 --> -4a = 116   -->  a = -29, x = 30
    #                        -x - a = 11, x + 5a = 105  -->  4a = 116   -->  a = 29, x = -30
    #        = 15 x 77   -->  x + a = 15, -x - 5a = 77  --> -4a = 92    -->  a = -23, x = 24
    #                        -x - a = 15, x + 5a = 77   -->  4a = 92    -->  a = 23, x = -24
    #        = 21 x 55   -->  x + a = 21, -x - 5a = 55  --> -4a = 76    -->  a = -19, x = 20
    #                        -x - a = 21, x + 5a = 55   -->  4a = 76    -->  a = 19, x = -20
    #        = 33 x 35   -->  x + a = 33, -x - 5a = 35  --> -4a = 68    -->  a = -17, x = 18
    #                        -x - a = 33, x + 5a = 35   -->  4a = 68    -->  a = 17, x = -18
    #
    (0...limit).count {|i| sols == count( i )}
  end

  def solution; 'NDk4OQ==' end
  def best_time; 72.17 end
  def effort; 25 end

  def completed_on; '20??-??-??' end
  def ordinality; 4_354 end
  def population; 620_809 end

  def refs; [] end
end
