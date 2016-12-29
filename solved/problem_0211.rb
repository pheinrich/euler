require 'projectEuler'

class Problem_0211
  def title; 'Divisor Square Sum' end
  def difficulty; 50 end

  # For a positive integer n, let σ_2(n) be the sum of the squares of its
  # divisors. For example,
  #
  #      σ_2(10) = 1 + 4 + 25 + 100 = 130.
  #
  # Find the sum of all n, 0 < n < 64,000,000 such that σ_2(n) is a perfect
  # square.

  def solve( max = 64_000_000 )
    sums = Array.new( max ) {|i| 1 + i*i}
    sums[0], sums[1] = 0, 1
    
    lim = max >> 1
    i, i2, di2 = 2, 4, 5

    # Brute force sieve... Just step forward from every potential factor,
    # adding its square to its multiples' running totals.
    while i <= lim
      (i+i...max).step( i ) do |n|
        sums[n] += i2
      end

      # Advance the factor and its square.
      i += 1
      i2 += di2
      di2 += 2
    end

    # Add up the indicies whose sigma is a perfect square.
    sums.each_with_index.reduce( 0 ) {|acc, (j, i)| acc + (Math.sqrt( j ).to_i**2 == j ? i : 0)}
  end

  def solution; 'MTkyMjM2NDY4NQ==' end
  def best_time; 181.9 end
  def effort; 20 end

  def completed_on; '2016-12-29' end
  def ordinality; 3_016 end
  def population; 663_617 end

  def refs
    ['http://mathworld.wolfram.com/DivisorFunction.html',
     
     #  sigma_2(n): sum of squares of divisors of n.
     'http://oeis.org/A001157',
     
     # Sum of the squares of divisors is also a square number.
     'http://oeis.org/A046655']
  end
end
