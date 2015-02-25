require 'projectEuler'

# 0.00003100s (1/21/13, #~222745)
class Problem_0002
  def title; 'Even Fibonacci numbers' end

  # Each new term in the Fibonacci sequence is generated by adding the pre-
  # vious two terms. By starting with 1 and 2, the first 10 terms will be:
  #
  #    1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
  #
  # By considering the terms in the Fibonacci sequence whose values do not
  # exceed four million, find the sum of the even-valued terms.

  def refs; [] end
  def solution; 4_613_732 end
  def best_time; 0.000008822 end

  def completed_on; '2013-01-21' end
  def ordinality; 222_745 end
  def population; 274_675 end

  def solve( n = 4_000_000 )
    # The first m terms sum to F[m+2] - 1.  Call this sum S.  Note that every
    # third Fibonacci term is even, so the problem becomes one of adding
    # F[0] + F[3] + F[6] + ... + F[m], where F[m] < n.  Call this sum T.
    # Subtract:
    #
    #      F[0] + F[1] + F[2] + F[3] + F[4] + F[5] + F[6] + ... + F[m]   (S)
    #    - F[0]               + F[3]               + F[6] + ... + F[m]   (T)
    #    -------------------------------------------------------------
    #       0   + F[1] + F[2] +  0   + F[4] + F[5] +  0   + ... +  0
    #
    # The paired terms combine to form the even-valued terms, so S - T = T,
    # or T = S/2 = (F[m+2] - 1)/2.
    curr = 0
    succ = 1

    # Generate the first m + 1 Fibonacci terms.
    while succ < n
      curr, succ = succ, curr + succ
    end

    # Advance to term m + 2
    curr, succ = succ, curr + succ

    # Use the formula above to calculate the sum of even terms.
    (succ - 1)/2
  end
end
