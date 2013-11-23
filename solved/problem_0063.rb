require 'projectEuler'

# Powerful digit counts
class Problem_0063
  # The 5-digit number, 16807=7^5, is also a fifth power. Similarly, the
  # 9-digit number, 134217728=8^9, is a ninth power.
  #
  # How many n-digit positive integers exist which are also an nth power?

  def self.count_matches(n)
    i = 1
    p = n
    while p.to_s.size == i
      p *= n
      i += 1
    end
    i - 1
  end

  def self.solve()
    # 10^n will always generate a value with n+1 digits (which is too long).
    # Therefore, count_digits(X^n) == n can only be true for X < 10.
    puts( (1..9).map {|n| count_matches(n)}.inject(:+) )
  end
end

ProjectEuler.time do
  # 49
  Problem_0063.solve()
end
