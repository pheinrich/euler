require 'projectEuler'

# 21.35s (1/8/15, #9567)
class Problem_0104
  def title; 'Pandigital Fibonacci ends' end
  def difficulty; 25 end

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
    k, curr, succ = 2749, 1, 0
    k.times { curr, succ = succ, curr + succ }

    while true
      break if (succ % 1000000000).pandigital? &&
               succ.to_s[0, 9].to_i.pandigital?

      k, curr, succ = k + 1, succ, curr + succ
    end

    k
  end

  def solution; 329_468 end
  def best_time; 21.35 end
  def effort; 0 end

  def completed_on; '2015-01-15' end
  def ordinality; 9_567 end
  def population; 452_608 end

  def refs
    ["https://oeis.org/A216488",
     "https://oeis.org/A216489"]
  end
end
