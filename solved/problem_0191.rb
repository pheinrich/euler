require 'projectEuler'

class Problem_0191
  def title; 'Prize Strings' end
  def difficulty; 35 end

  # A particular school offers cash rewards to children with good attendance
  # and punctuality. If they are absent for three consecutive days or late on
  # more than one occasion then they forfeit their prize.
  #
  # During an n-day period a trinary string is formed for each child consist-
  # ing of L's (late), O's (on time), and A's (absent).
  #
  # Although there are eighty-one trinary strings for a 4-day period that can
  # be formed, exactly forty-three strings would lead to a prize:
  #
  #      OOOO OOOA OOOL OOAO OOAA OOAL OOLO OOLA OAOO OAOA
  #      OAOL OAAO OAAL OALO OALA OLOO OLOA OLAO OLAA AOOO
  #      AOOA AOOL AOAO AOAA AOAL AOLO AOLA AAOO AAOA AAOL
  #      AALO AALA ALOO ALOA ALAO ALAA LOOO LOOA LOAO LOAA
  #      LAOO LAOA LAAO
  #
  # How many "prize" strings exist over a 30-day period?

  def solve( n = 30 )
    # Solving this with combinatorics quickly turned into a major headache.
    # Instead, tackle it inductively by considering how the total changes as
    # as each new day's trinary string is added one by one. By keeping track
    # of certain characteristics for a string of length m, we can then make
    # simple statements about how those characteristics changes when we in-
    # crease the string's length to m + 1.
    #
    # Given some (valid, "prize") string S to which we will prepend either L,
    # O, or A, we know the result will also be valid provided:
    #
    #   o We prepend O
    #   o We prepend L AND S doesn't contain L already
    #   o We prepend A AND S doesn't already start with AA
    #
    # This gives us an idea of what characteristics might be helpful to record
    # for each n:
    #
    #   U = count of prize S containing L
    #   V = count of prize S starting with A
    #   W = count of prize S starting with AA
    #   X = count of U ∩ V (contains L and starts with A)
    #   Y = count of U ∩ W (contains L and starts with AA)
    #   Z = count of prize S
    #
    # Now we can formulate functions to take U, V, W, ... to U', V', W', etc.
    # as n increases. That is, given U_n, V_n, W_n, etc., how do we compute
    # U_(n+1), V_(n+1), W_(n+1), ...?
    #
    # Given U valid strings containing L, we know they'll remain valid after
    # we prepend O, so U' will be at least O. We also know that we can do the
    # same for A, as long as we skip S that start with AA, so we need to in-
    # crease U' by an additional U - Y. Similarly, we know we can create Z - U
    # new L strings by prepending it to existing prizes strings. So, U' will
    # be given by U' = U + (U - Y) + (Z - U) = U - Y + Z.
    #
    # To compute V', note that we will have added A to all strings except the
    # ones starting with AA, but the ones that had started with A shouldn't be
    # counted (since they will now start with AA). V' = Z - V - W.
    #
    # W' is simply the count of valid strings previously starting with A,
    # since those are the only ones that could conceivably now begin with AA.
    # W' = V. Similarly, Y' = X.
    #
    # X' must necessarily be less than U (since not all L strings will start
    # with A), and in fact, we must subtract members that had been counted,
    # since they will have had A prepended and now start with AA. Similarly,
    # we shouldn't count the Y strings toward X' either, since they will not
    # start with A now. X' = U - X - Y.
    #
    # With the first five quantities defined in terms of the previous values,
    # we can now derive a formula for the total number of valid prize strings.
    # For every valid string of length m, there will be corresponding strings
    # of length m + 1 such that:
    #
    #   o it is identical except for a new leading L, except for strings that
    #     already contain L (Z - U new items),
    #   o it is identical except for a new leading O (Z new items), or
    #   o it is identical except for a new leading A, except for strings that
    #     already started with AA (Z - W new items)
    #
    # Therefore, Z' = Z - U + Z + Z - W = 3Z - U - W.
    u, v, w, x, y, z = 1, 1, 0, 0, 0, 3
    
    (n - 1).times do
      u, v, w, x, y, z = u - y + z, z - v - w, v, u - x - y, x, 3*z - u - w
    end

    z
  end

  def solution; 'MTkxODA4MDE2MA==' end
  def best_time; 0.00002193 end
  def effort; 70 end

  def completed_on; '2016-08-06' end
  def ordinality; 5_134 end
  def population; 620_073 end

  def refs; [] end
end
