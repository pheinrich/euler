require 'projectEuler'

class Problem_0174
  def title; 'Counting the number of "hollow" square laminae that can form one, two, three, ... distinct arrangements' end
  def difficulty; 40 end

  # We shall define a square lamina to be a square outline with a square
  # "hole" so that the shape possesses vertical and horizontal symmetry.
  #
  # Given eight tiles it is possible to form a lamina in only one way: 3x3
  # square with a 1x1 hole in the middle. However, using thirty-two tiles it
  # is possible to form two distinct laminae (see diagram).
  #
  # If t represents the number of tiles used, we shall say that t = 8 is type
  # L(1) and t = 32 is type L(2).
  #
  # Let N(n) be the number of t ≤ 1000000 such that t is type L(n); for
  # example, N(15) = 832.
  #
  # What is ∑ N(n) for 1 ≤ n ≤ 10?

  def solve( n = 1_000_000, bound = 10 )
    count = Hash.new {|hash, key| hash[key] = 0}
    biggest = 1 + (n >> 2)

    frame = Array.new( biggest )

    3.upto( biggest ) do |w|
      # Compute the number of tiles in a w × w single-layer frame.
      frame[w] = (w - 1) << 2
      sum = frame[w]

      # Nest smaller frames until they add up to more than the limit. Keep
      # track of how many ways each sum may be formed.
      until sum > n || 3 > w
        count[sum] += 1
        w -= 2
        sum += frame[w] unless 3 > w
      end
    end

    # Tally how many sums were formed in only one way, two ways, three ways,
    # etc. Add these totals.
    (1..bound).map {|i| count.values.count {|j| i == j}}.reduce( :+ )
  end

  def solution; 'MjA5NTY2' end
  def best_time; 0.7738 end
  def effort; 5 end

  def completed_on; '2016-08-02' end
  def ordinality; 4_247 end
  def population; 618_944 end

  def refs; [] end
end
