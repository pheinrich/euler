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

  def solve( limit = 1_000_000, sols = 10 )
    # Since the x, y, z are part of an arithmetic progression, we can rephrase
    # the problem equation in terms of the first value and some delta, d:
    #
    #   n = x^2 - y^2 - z^2
    #     = x^2 - (x + d)^2 - (x + 2d)^2
    #     = x^2 - (x^2 + 2dx + d^2) - (x^2 + 4dx + 4d^2)
    #     = x^2 - x^2 - 2dx - d^2 - x^2 - 4dx - 4d^2
    #     = -x^2 - 6dx - 5d^2
    #     = -(x + d)(x + 5d)
    #
    # For each pair of factors p, q where n = pq, we can create a system of
    # equations from the above and solve for d:
    #
    #   n = pq = -(x + d)(x + 5d), so
    #
    #       p = -x -  d               p =  x +  d
    #     + q =  x + 5d     and     + q = -x - 5d
    #     -------------             -------------
    #        p + q = 4d               p + q = -4d
    #
    # Therefore, the only valid deltas are those formed when 4 divides p + q.
    # When we find p, q for which this is true, we can substitute back into
    # each system to generate an x from each. We note that both -(x + d) and
    # x + 5d must be positive (or negative) for pq = n to be positive, so
    # either -(x + d) = -p and x + 5d = -q -OR- x + d = p and -(x + 5d) = q.
    # Since p and q may be swapped, this leads to two possible solutions for
    # every pair of factors, x1 = p - d and x2 = q - d.  
    seen = {}
    root = Math.sqrt( limit ).to_i

    # Do a sieve walk of all potential divisors and visit every multiple of
    # each one.
    (1..root).each do |p|
      p.step( limit, p ) do |mult|
        q = mult / p
        d = q + p

        # If 4 doesn't divide the current divisor plus its partner, the pair
        # can't lead to a solution. 
        next unless 0 == d % 4
        d /= -4

        # Compute the first starting x, but don't accept it unless all three
        # terms of the resulting arithmetic sequence are positive, as required
        # by the problem statement.
        x = p - d
        seen[[x, d]] = mult if 0 < x + 2*d

        # Swap p and q and compute the other potential x value.
        x = q - d
        seen[[x, d]] = mult if 0 < x + 2*d
      end
    end

    # Count how many solutions lead to the same value.
    counts = Hash.new {0}
    seen.values.each {|v| counts[v] += 1}

    # Count how many values have exactly the right number of solutions.
    counts.values.count {|c| sols == c}
  end

  def solution; 'NDk4OQ==' end
  def best_time; 4.606 end
  def effort; 25 end

  def completed_on; '2016-08-09' end
  def ordinality; 4_354 end
  def population; 620_809 end

  def refs; [] end
end
