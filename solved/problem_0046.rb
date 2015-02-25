require 'projectEuler'

# 0.01969s (3/9/13, #~21965)
class Problem_0046
  def title; 'Goldbach\'s other conjecture' end

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

  def refs; [] end
  def solution; 5_777 end
  def best_time; 0.01174 end

  def completed_on; '2013-03-09' end
  def ordinality; 21_965 end
  def population; 286_339 end

  def solve
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
    
    n
  end
end
