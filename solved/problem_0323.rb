require 'projectEuler'

class Problem_0323
  def title; 'Bitwise-OR operations on random integers' end
  def difficulty; 20 end

  # Let y_0, y_1, y_2,... be a sequence of random unsigned 32 bit integers
  # (i.e. 0 ≤ y_i < 2^32, every value equally likely).
  #
  # For the sequence x_i the following recursion is given:
  #
  #   x_0 = 0 and
  #   x_i = x_{i-1}| y_{i-1}, for i > 0. ( | is the bitwise-OR operator)
  #
  # It can be seen that eventually there will be an index N such that x_i =
  # 2^32 - 1 (a bit-pattern of all ones) for all i ≥ N.
  #
  # Find the expected value of N. Give your answer rounded to 10 digits after
  # the decimal point.

  def solve( n = 32, d = 10 )
    # Given 32 independent bits, how many rounds will be required to flip all
    # of them on assuming the probability of doing so on any round is 1/2?
    #
    # The chance that any single bit is set after 0 operations is 1/2. After 1
    # combination with another random y_i, that probability drops to 1/4. Like-
    # wise, after m operations, a bit will be clear with probability 1 / 2^m
    # and set with probability 1 - 1/2^m.
    #
    # Since all individual bits are linearly independent, the probability that
    # all n bits are set after m operations is (1 - 1/2^m)^n. That means that
    # the chance that at least 1 bit is NOT set is 1 - (1 - 1/2^m)^n. That
    # probability corresponds to the expected number of additional rounds re-
    # quired to flip the remaining 0 bits; e.g. a value of 1 means there is
    # a 100% chance that at least one bit is clear, so 1 additional round is
    # absolutely required. A value of 0 means all bits are definitely set, so
    # no more rounds are necessary.
    expected, epsilon = 0, 10.0**-(d + 1)
    oneSet, notAllSet = 0.5, 1

    # Continue adding these incremental probabilities until they become so
    # small that including them no longer changes the result beyond the
    # precision required.
    while( notAllSet > epsilon )
      expected += notAllSet
      oneSet, notAllSet = oneSet / 2, 1 - (1 - oneSet)**n
    end

    "%0.#{d}f" % expected
  end

  def solution; 'Ni4zNTUxNzU4NDUx' end
  def best_time; 0.00005412 end
  def effort; 45 end

  def completed_on; '2018-09-28' end
  def ordinality; 3_057 end
  def population; 784_813 end

  def refs
    ['https://www.cut-the-knot.org/Probability/LengthToFirstSuccess.shtml']
  end
end
