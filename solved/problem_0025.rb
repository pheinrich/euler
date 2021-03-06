require 'projectEuler'

class Problem_0025
  def title; '1000-digit Fibonacci number' end
  def difficulty; 5 end

  # The Fibonacci sequence is defined by the recurrence relation:
  #
  # F[n] = F[n - 1] + F[n - 2], where F[1] = 1 and F[2] = 1.
  #
  # Hence the first 12 terms will be:
  #
  #     F[1] = 1
  #     F[2] = 1
  #     F[3] = 2
  #     F[4] = 3
  #     F[5] = 5
  #     F[6] = 8
  #     F[7] = 13
  #     F[8] = 21
  #     F[9] = 34
  #     F[10] = 55
  #     F[11] = 89
  #     F[12] = 144
  #
  # The 12th term, F[12], is the first term to contain three digits.
  #
  # What is the first term in the Fibonacci sequence to contain 1000 digits?

  def solve( n = 1_000 )
    term = 1
    curr = 0
    succ = 1

    # Sum/count terms until one is 
    while succ < 10**(n - 1)
      term += 1
      curr, succ = succ, curr + succ
    end

    term
  end

  def solution; 'NDc4Mg==' end
  def best_time; 0.02287 end
  def effort; 0 end

  def completed_on; '2013-02-07' end
  def ordinality; 59_579 end
  def population; 295_954 end

  def refs
    ['https://oeis.org/A000045']
  end
end
