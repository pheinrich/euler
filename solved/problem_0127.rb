require 'projectEuler'

# 142.6s (1/18/15, #3433)
class Problem_0127
  def title; 'abc-hits' end
  def difficulty; 50 end

  # The radical of n, rad(n), is the product of distinct prime factors of n.
  # For example, 504 = 2^3 × 3^2 × 7, so rad(504) = 2 × 3 × 7 = 42.
  #
  # We shall define the triplet of positive integers (a, b, c) to be an
  # abc-hit if:
  #
  #      GCD(a, b) = GCD(a, c) = GCD(b, c) = 1
  #      a < b
  #      a + b = c
  #      rad(abc) < c
  #
  # For example, (5, 27, 32) is an abc-hit, because:
  #
  #      GCD(5, 27) = GCD(5, 32) = GCD(27, 32) = 1
  #      5 < 27
  #      5 + 27 = 32
  #      rad(4320) = 30 < 32
  #
  # It turns out that abc-hits are quite rare and there are only thirty-one abc-hits for c < 1000, with ∑c = 12523.
  #
  # Find ∑c for c < 120000.

  def solve( max = 120_000 )
    # Since a, b, c are pairwise coprime, they don't share any prime factors.
    # That means that rad(abc) = rad(a)rad(b)rad(c). We know rad(abc) < c,
    # which is only possible if rad(c) < c, so we can eliminate square-free
    # numbers from consideration (a square-free number n has rad(n) = n).
    rads = max.radical_sieve
    nsf = (1...max).select {|i| i > rads[i]}

    sum = 0
    nsf.each do |c|
      # From above, note that rad(a)rad(b) < c / rad(c). Check possibilities
      # for a, b against this and make sure a and c are coprime. (This seems
      # to be sufficient.)
      check = c / c.rad
      sum += c * (1...c/2).count {|a| rads[a] * rads[c - a] < check && a.coprime?( c )}
    end

    sum
  end

  def solution; 18_407_904 end
  def best_time; 142.6 end
  def effort; 40 end
  
  def completed_on; '2015-01-18' end
  def ordinality; 3_433 end
  def population; 455_090 end
  
  def refs; ["http://en.wikipedia.org/wiki/Abc_conjecture"] end
end
