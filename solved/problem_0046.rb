require 'projectEuler'

# Goldbach's other conjecture
class Problem_0046
  # It was proposed by Christian Goldbach that every odd composite number can
  # be written as the sum of a prime and twice a square.
  #
  #      9 = 7 + 2x1^2
  #     15 = 7 + 2x2^2
  #     21 = 3 + 2x3^2
  #     25 = 7 + 2x3^2
  #     27 = 19 + 2x2^2
  #     33 = 31 + 2x1^2
  #
  # It turns out that the conjecture was false.
  #
  # What is the smallest odd composite that cannot be written as the sum of a
  # prime and twice a square?

  def self.solve()
    n = 33
    while true
      begin
        n += 2
      end while n.prime?

      s, ds = 2, 6
      while s < n && !(n - s).prime?
        s += ds
        ds += 4
      end

      break if s >= n
    end
    
    puts n
  end
end

ProjectEuler.time do
  # 5777 (0.04000s)
  Problem_0046.solve()
end
