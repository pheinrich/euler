require 'projectEuler'

class Problem_0142
  def title; 'Perfect Square Collection' end
  def difficulty; 45 end

  # Find the smallest x + y + z with integers x > y > z > 0 such that x + y,
  # x − y, x + z, x − z, y + z, y − z are all perfect squares.

  def solve
    # We know that x sits equidistant between two perfect squares, so step
    # through them one at a time, building a list of perfect squares as we go.
    # For each new entry, memoize its pair-wise average with every previous
    # entry having the same parity. This value is a potential x, and half the
    # difference between those entries is a potential y. (Only average entries
    # of similar parities since that guarantees that difference is even, and
    # thus y will be an integer.)
    #
    # Similarly, y must also sit equidistant between two perfect squares, and
    # since y < x (from the problem statement), we must have encountered it
    # already. The value memoized for it is a potential z. If both x + z and
    # x - z are square, then we've found our triplet.
    squares = [1, 4]
    deltas = {}

    i, sq, d = 3, 9, 7

    while true
      # Add the current square to our list.
      squares << sq

      # Step through all squares less than this one having the same parity
      # (every other entry).
      (i - 3).step( 0, -2 ) do |j|
        # The average is a potential x, which may be identified more than once
        # for multiple deltas (that is, the average of any two squares may not
        # be unique).
        x = (squares[i - 1] + squares[j]) >> 1
        deltas[x] = [] unless deltas.has_key?( x )

        # Record the current delta as a potential y for this x.
        y = x - squares[j]
        deltas[x] << y

        # If deltas have also been associated with this y, then each one is a
        # potential z for it.
        if deltas.has_key?( y )
          deltas[y].each do |z|
            # For each potential z, we just need to check x + z and x - z.
            return x + y + z if squares.include?( x + z ) && squares.include?( x - z )
          end
        end
      end

      # Advance to the next square using a simple recurrence.
      i, sq, d = i + 1, sq + d, d + 2
    end
  end

  def solution; 'MTAwNjE5Mw==' end
  def best_time; 0.3927 end
  def effort; 25 end

  def completed_on; '2018-09-27' end
  def ordinality; 4_778 end
  def population; 784_471 end

  def refs; [] end
end
