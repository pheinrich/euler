require 'projectEuler'

# 
class Problem_0104
  def title; 'Pandigital Fibonacci ends' end
  def solution;  end

  # The Fibonacci sequence is defined by the recurrence relation:
  # 
  #     F[n] = F[n−1] + F[n−2], where F[1] = 1 and F[2] = 1.
  #
  # It turns out that F[541], which contains 113 digits, is the first
  # Fibonacci number for which the last nine digits are 1-9 pandigital (con-
  # tain all the digits 1 to 9, but not necessarily in order). And F[2749],
  # which contains 575 digits, is the first Fibonacci number for which the
  # first nine digits are 1-9 pandigital.
  #
  # Given that Fk is the first Fibonacci number for which the first nine
  # digits AND the last nine digits are 1-9 pandigital, find k.

  def solve
    k, curr, succ = 2, 0, 1
    while k < 2745 do
      k += 1
      curr, succ = succ, curr + succ
    end

    10.times do
      curr, succ = succ, curr + succ
      puts "#{k}: #{succ}"
      k += 1
    end

    succ.to_s
  end
end
