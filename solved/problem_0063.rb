require 'projectEuler'

# 0.0001099s (10/31/13)
class Problem_0063
  def title; 'Powerful digit counts' end
  def solution; 49 end

  # The 5-digit number, 16807=7^5, is also a fifth power. Similarly, the
  # 9-digit number, 134217728=8^9, is a ninth power.
  #
  # How many n-digit positive integers exist which are also an nth power?

  def count_matches( n )
    i = 1
    p = n
    while p.to_s.size == i
      p *= n
      i += 1
    end
    i - 1
  end

  def solve
    # 10^n will always generate a value with n+1 digits (which is too long).
    # Therefore, count_digits(X^n) == n can only be true for X < 10.
    (1..9).map {|n| count_matches(n)}.inject(:+)
  end
end
