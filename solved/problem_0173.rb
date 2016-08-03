require 'projectEuler'

class Problem_0173
  def title; 'Using up to one million tiles how many different "hollow" square laminae can be formed?' end
  def difficulty; 30 end

  # We shall define a square lamina to be a square outline with a square
  # "hole" so that the shape possesses vertical and horizontal symmetry. For
  # example, using exactly thirty-two square tiles we can form two different
  # square laminae (see diagram).
  #
  # With one-hundred tiles, and not necessarily using all of the tiles at one
  # time, it is possible to form forty-one different square laminae.
  #
  # Using up to one million tiles how many different square laminae can be
  # formed?

  def solve( n = 1_000_000 )
    # Simple brute force. Call each single layer a "frame" and recognize that
    # we just need to find (touching) nested frames that sum to any value less
    # than 1M.
    #
    # Compute the size of every single-layer frame that may be formed with 1M
    # tiles or fewer. Count one lamina for each of these of these frames. Then
    # nest successively smaller frames, counting one additional lamina as each
    # is added, until their combined sum is greater than 1M (or the smallest
    # possible frame has been nested).
    count = 0
    biggest = 1 + (n >> 2)

    frame = Array.new( biggest )

    3.upto( biggest ) do |w|
      # Compute the number of tiles in a w × w single-layer frame.
      frame[w] = (w - 1) << 2
      sum = frame[w]

      # Nest smaller frames until they add up to more than the limit.
      until sum > n || 3 > w
        count += 1
        w -= 2
        sum += frame[w] unless 3 > w
      end
    end
    
    count
  end

  def solution; 'MTU3MjcyOQ==' end
  def best_time; 0.1357 end
  def effort; 5 end

  def completed_on; '2016-08-02' end
  def ordinality; 6_546 end
  def population; 618_930 end

  def refs; [] end
end
