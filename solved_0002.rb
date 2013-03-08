require 'projectEuler'

# Even Fibonacci numbers
class Problem_0002
  # Each new term in the Fibonacci sequence is generated by adding the pre-
  # vious two terms. By starting with 1 and 2, the first 10 terms will be:
  #
  #    1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
  #
  # By considering the terms in the Fibonacci sequence whose values do not
  # exceed four million, find the sum of the even-valued terms.

  def self.solve( n )
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
    puts (succ - 1)/2
  end
end

ProjectEuler.time do
  # 4613732
  Problem_0002.solve( 4000000 )
end