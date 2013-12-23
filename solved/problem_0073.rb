require 'projectEuler'

# Counting fractions in a range
class Problem_0073
  # Consider the fraction, n/d, where n and d are positive integers. If n<d
  # and HCF(n,d)=1, it is called a reduced proper fraction.
  #
  # If we list the set of reduced proper fractions for d ≤ 8 in ascending
  # order of size, we get:
  #
  #    1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2,
  #       4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8
  #
  # It can be seen that there are 3 fractions between 1/3 and 1/2.
  #
  # How many fractions lie between 1/3 and 1/2 in the sorted set of reduced
  # proper fractions for d ≤ 12,000?

  def self.solve( n )
    a, b, c, d = 0, 1, 1, n
    
    while c != 1 || d != 3
      k = (n + b) / d
      a, b, c, d = c, d, k*c - a, k*d - b
    end

    count = -1
    
    while c != 1 || d != 2
      k = (n + b) / d
      a, b, c, d = c, d, k*c - a, k*d - b
      count += 1
    end

    puts count
  end
end

ProjectEuler.time do
  # 7295372 (6.970s)
  Problem_0073.solve( 12000 )
end