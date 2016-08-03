require 'projectEuler'

# 
class Problem_0149
  def title; 'Searching for a maximum-sum subsequence' end
  def difficulty; 50 end

  # Looking at the table below, it is easy to verify that the maximum possible
  # sum of adjacent numbers in any direction (horizontal, vertical, diagonal
  # or anti-diagonal) is 16 (= 8 + 7 + 1).
  #
  #   −2    5    3    2
  #    9   −6    5    1
  #    3    2    7    3
  #   −1    8   −4    8
  #
  # Now, let us repeat the search, but on a much larger scale:
  #
  # First, generate four million pseudo-random numbers using a specific form
  # of what is known as a "Lagged Fibonacci Generator":
  #
  # For 1 ≤ k ≤ 55,
  #   s_k = [100003 − 200003k + 300007k^3] (modulo 1000000) − 500000.
  # For 56 ≤ k ≤ 4000000,
  #   s_k = [s_(k−24) + s_(k−55) + 1000000] (modulo 1000000) − 500000.
  #
  # Thus, s_10 = −393027 and s_100 = 86613.
  #
  # The terms of s are then arranged in a 2000×2000 table, using the first
  # 2000 numbers to fill the first row (sequentially), the next 2000 numbers
  # to fill the second row, and so on.
  # 
  # Finally, find the greatest sum of (any number of) adjacent entries in any
  # direction (horizontal, vertical, diagonal or anti-diagonal).

  def lagged_fib( size )
    s = Array.new( size )

    (1..55).each do |k|
      s[k-1] = (100_003 - 200_003*k + 300_007*k*k*k) % 1_000_000 - 500_000
    end

    (56..size).each do |k|
      # Indices for previous entries adjusted by -1 to be 0-based.
      s[k-1] = (s[k-25] + s[k-56] + 1_000_000) % 1_000_000 - 500_000
    end

    s
  end

  def solve( n = 2_000 )
    # Since there's no restriction on the number of adjacent terms that can
    # contribute to each sub-sum, we can use Kadane's algorithm to find the
    # maximum sum for each individual row, column, and diagonal. Taking the
    # max of these gives us the result we're after.
    #
    # We inline the algorithm for each case, which allows us to operate
    # directly on the generated array, rather than gather elements into
    # secondary arrays for processing.
    s = lagged_fib( n*n )
    max = 0
    
    # Find the max of every row.
    n.times do |row|
      k = row * n
      here, sofar = 0, 0

      n.times do
        here  = [0, here + s[k]].max
        sofar = [sofar, here].max
        k += 1
      end
      
      max = [sofar, max].max
    end
    
    # Find the max of every column.
    n.times do |col|
      k = col
      here, sofar = 0, 0
      
      n.times do
        here = [0, here + s[k]].max
        sofar = [sofar, here].max
        k += n
      end
      
      max = [sofar, max].max
    end
    
    # Find the max of every diagonal.
    n.times do |top|
      k = top
      here, sofar = 0, 0
      
      # Starting at the top of each column, move down and to the right until
      # we reach the right edge.
      (n - top).times do
        here = [0, here + s[k]].max
        sofar = [sofar, here].max
        k += n + 1
      end
      
      max = [sofar, max].max
    end

    # Starting at the beginning of each row, move down and to the right
    # until we reach the bottom edge.
    (1...n).each do |left|
      k = left * n
      here, sofar = 0, 0
      
      (n - left).times do
        here = [0, here + s[k]].max
        sofar = [sofar, here].max
        k += n + 1
      end
      
      max = [sofar, max].max
    end
    
    # Find the max of every anti-diagonal.
    n.times do |top|
      k = top
      here, sofar = 0, 0

      # Starting at the top of each column, move down and to the left until
      # we reach the left edge.
      (0..top).each do
        here = [0, here + s[k]].max
        sofar = [sofar, here].max
        k += n - 1
      end
      
      max = [sofar, max].max
    end
    
    (1...n).each do |right|
      k = (1 + right) * n - 1
      here, sofar = 0, 0

      # Starting at the end of each row, move down and to the left until we
      # reach the bottom edge.
      (n-right).times do
        here = [0, here + s[k]].max
        sofar = [sofar, here].max
        k += n - 1
      end
      
      max = [sofar, max].max
    end

    max
  end

  def solution; 'NTI4NTIxMjQ=' end
  def best_time; 10.06 end
  def effort; 10 end

  def completed_on; '2016-08-02' end
  def ordinality; 3_308 end
  def population; 618_818 end

  def refs
    ['https://en.wikipedia.org/wiki/Maximum_subarray_problem']
  end
end
