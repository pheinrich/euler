require 'projectEuler'

# 15.59s (1/10/15, #6991)
class Problem_0179
  def title; 'Consecutive positive divisors' end
  def difficulty; 25 end

  # Find the number of integers 1 < n < 10^7, for which n and n + 1 have the
  # same number of positive divisors. For example, 14 has the positive div-
  # isors 1, 2, 7, 14 while 15 has 1, 3, 5, 15.

  def solve( n = 10_000_000 )
    f = Array.new( n ) {0}

    # Visit all multiples of each potential factor, incrementing a counter
    # for each number less than n.
    (2...n/2).each do |i|
      j = 2*i
      while j < n
        f[j] += 1
        j += i
      end
    end

    # Determine how many numbers have same factor count as their successor. 
    (2...n).count {|i| f[i] == f[i+1]}
  end

  def solution; 986_262 end
  def best_time; 15.59 end
  def effort; 20 end
  
  def completed_on; '2015-01-10' end
  def ordinality; 6_991 end
  def population; 453_105 end
  
  def refs; [] end
end
