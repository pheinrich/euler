require 'projectEuler'

class Problem_0136
  def title; 'Singleton difference' end
  def difficulty; 50 end

  # The positive integers, x, y, and z, are consecutive terms of an arithmetic
  # progression. Given that n is a positive integer, the equation, x^2 − y^2 −
  # z^2 = n, has exactly one solution when n = 20:
  #
  #   13^2 − 10^2 − 7^2 = 20
  #
  # In fact there are twenty-five values of n below one hundred for which the
  # equation has a unique solution.
  #
  # How many values of n less than fifty million have exactly one solution?

  def solve( limit = 50_000_000 )#50_000_000 )
    seen = {}
    root = Math.sqrt( limit ).to_i

    # Do a sieve walk of all potential divisors and visit every multiple of
    # each one.
    (1..root).each do |p|
      puts p
      q = 0
      p.step( limit, p ) do |mult|
        q += 1
        d = q + p

        # If 4 doesn't divide the current divisor plus its partner, the pair
        # can't lead to a solution. 
        next unless 0 == d & 3
        d = -d >> 2

        # Compute the first starting x, but don't accept it unless all three
        # terms of the resulting arithmetic sequence are positive, as required
        # by the problem statement.
        x = p - d
        seen[(x << 32) | -d] = mult if 0 < x + 2*d

        # Swap p and q and compute the other potential x value.
        x = q - d
        seen[(x << 32) | -d] = mult if 0 < x + 2*d
      end
    end

    # Count how many solutions lead to the same value.
    counts = Hash.new {0}
    seen.values.each {|v| counts[v] += 1}

    # Count how many values have exactly the right number of solutions.
    counts.values.count {|c| 1 == c}
  end

  def solution; 'MjU0NDU1OQ==' end
  def best_time; 987.0 end
  def effort; 5 end

  def completed_on; '2016-08-09' end
  def ordinality; 3_830 end
  def population; 620_877 end

  def refs; [] end
end
