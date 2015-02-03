require 'projectEuler'

# 0.08340s (4/6/13, #~10434)
class Problem_0061
  def title; 'Cyclical figurate numbers' end

  # Triangle, square, pentagonal, hexagonal, heptagonal, and octagonal numbers
  # are all figurate (polygonal) numbers and are generated by the following
  # formulae:
  #
  #     Triangle    P3(n)=n(n+1)/2   1, 3,  6, 10, 15, ...
  #     Square      P4(n)=n^2        1, 4,  9, 16, 25, ...
  #     Pentagonal  P5(n)=n(3n-1)/2  1, 5, 12, 22, 35, ...
  #     Hexagonal   P6(n)=n(2n-1)    1, 6, 15, 28, 45, ...
  #     Heptagonal  P7(n)=n(5n-3)/2  1, 7, 18, 34, 55, ...
  #     Octagonal   P8(n)=n(3n-2)    1, 8, 21, 40, 65, ...
  #
  # The ordered set of three 4-digit numbers: 8128, 2882, 8281, has three
  # interesting properties.
  #
  #     1. The set is cyclic, in that the last two digits of each number is
  #        the first two digits of the next number (including the last number
  #        with the first).
  #     2. Each polygonal type: triangle P3(127)=8128, square P4(91)=8281, and
  #        pentagonal P5(44)=2882, is represented by a different number in the
  #        set.
  #     3. This is the only set of 4-digit numbers with this property.
  #
  # Find the sum of the only ordered set of six cyclic 4-digit numbers for
  # which each polygonal type: triangle, square, pentagonal, hexagonal,
  # heptagonal, and octagonal, is represented by a different number in the
  # set.

  def refs; [] end
  def solution; 28_684 end
  def best_time; 0.08340 end
  
  def completed_on; '2013-04-06' end
  def ordinality; 10_434 end
  def percentile; 96.94 end

  A = [1, 1,  3,  2,  5,  3]
  B = [1, 0, -1, -1, -3, -2]
  C = [2, 1,  2,  1,  2,  1]

  def self.figurate( order, range )
    range.map {|n| ((A[order]*n*n + B[order]*n) / C[order]).to_s}
  end

  # Collect all 4-digit values in each sequence.
  P = [45..140, 32..99, 26..81, 23..70, 21..63, 19..58].each_with_index.map {|r, i| figurate( i, r )}
  @match = nil

  def expand( root, excl, accum )
    if 6 != accum.length
      ([*0..5] - excl).each do |k|
        chain = P[k].select {|s| s.start_with?( root[2, 2] )}
        chain.each {|n| expand( n, excl + [k], accum + [n])}
      end
    elsif accum[0].start_with?( accum[-1][2, 2] )
      @match = accum.map( &:to_i ).reduce( :+ )
    end
  end

  def solve
    # Traverse the octagonal numbers, since they're the shortest sequence.
    P[5].each {|n| expand( n, [5], [n] )}
    @match
  end
end
