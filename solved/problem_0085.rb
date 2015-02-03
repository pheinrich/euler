require 'projectEuler'

# 0.01387s (12/31/13, #12247)
class Problem_0085
  def title; 'Counting rectangles' end

  # By counting carefully it can be seen that a rectangular grid measuring 3
  # by 2 contains eighteen rectangles (see diagram).
  # 
  # Although there exists no rectangular grid that contains exactly two
  # million rectangles, find the area of the grid with the nearest solution.

  def refs; ["http://www.gottfriedville.net/mathprob/comb-subrect.html"] end
  def solution; 2_772 end
  def best_time; 0.01387 end

  def completed_on; '2013-12-31' end
  def ordinality; 12_247 end
  def percentile; 96.88 end

  def solve( n = 2_000_000 )
    counts = Hash.new( 0 )

    # Guesstimate upper limit on grid dimensions. 
    (1..100).each do |w|
      (1..100).each do |h|
        counts[[w, h]] = w * (w + 1) * h * (h + 1) >> 2
      end
    end

    counts.min_by {|k, v| (n - v).abs}[0].inject( :* )
  end
end
