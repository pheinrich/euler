require 'projectEuler'

# 0.00002980s (3/9/2105, #3358) 
class Problem_0162
  def title; 'Hexadecimal numbers' end

  # In the hexadecimal number system numbers are represented using 16 diff-
  # erent digits:
  #
  #      0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F
  #
  # The hexadecimal number AF when written in the decimal number system equals
  # 10x16+15=175.
  #
  # In the 3-digit hexadecimal numbers 10A, 1A0, A10, and A01 the digits 0,1
  # and A are all present. Like numbers written in base ten we write hexa-
  # decimal numbers without leading zeroes.
  #
  # How many hexadecimal numbers containing at most sixteen hexadecimal digits
  # exist with all of the digits 0,1, and A present at least once? Give your
  # answer as a hexadecimal number.
  #
  # (A,B,C,D,E and F in upper case, without any leading or trailing code that
  # marks the number as hexadecimal and without leading zeroes, e.g. 1A3F and
  # not: 1a3f and not 0x1a3f and not $1A3F and not #1A3F and not 0000001A3F)

  def refs; [] end
  def solution; '3D58725572C62302' end
  def best_time; 0.00002980 end

  def completed_on; '2015-03-09' end
  def ordinality; 3_358 end
  def population; 468_395 end

  def solve( n = 16 )
    # Finding all numbers with each of three digits repeated at least once
    # amounts to finding the complement of those missing one or more of the
    # specified digits. First define three sets of numbers: 
    #
    #   No0 – numbers that have no 0 digit
    #   No1 - numbers that have no 1 digit
    #   NoA - numbers that have no A digit
    #
    # Subtracting the union of these sets from the set of all numbers gives
    # the total we are looking for. The union is calculated from:
    #
    #   No0 ∪ No1 ∪ NoA = No0 + No1 + NoA -
    #                     (No0 ∩ No1) - (No1 ∩ NoA) - (NoA ∩ No0) +
    #                     (No1 ∩ NoA ∩ NoA)
    #
    # The size of each of these sets varies by the number of digits, so we
    # must calculate it separately for each length and sum the results. The
    # shortest possible length is 3; the maximum is 16 (for this problem).
    #
    # The cardinality of each set is easy to compute as the simple product
    # of the number of digit choices available at each position. Since we
    # have been directed to ignore leading zeros, there are 15 possible
    # starting digits, [1-9,a-f], then 16 choices for subsequent digits in
    # the base case (all digits allowed). We adjust these numbers as appro-
    # priate to compute the size of each restricted subset for some digit
    # count, len:
    #
    #   All = 15 * 16^(len - 1)
    #   No0 = 15^len
    #   No1 = 14 * 15^(len - 1)
    #   NoA = 14 * 15^(len - 1)
    #   No0 ∩ No1 = 14^len
    #   No0 ∩ NoA = 14^len
    #   No1 ∩ NoA = 13 * 14^(len - 1)
    #   No0 ∩ No1 ∩ NoA = 13^len
    #   
    # Substituting these values into the formula above yields:
    #
    #   union = 15^len + 14*15^(len - 1) + 14*15^(len - 1) -
    #           14^len - 14^len - 13*14^(len - 1) +
    #           13^len
    #
    # Define a change of variables to simplify and compute the total:
    #
    #   u = 16^(len - 1), v = 15^(len - 1), w = 14^(len - 1), x = 13^(len - 1) 
    #   union = 15*v + 14*v + 14*v - 14*w - 14*w - 13*w + 13*x
    #         = 43*v - 41*w + 13*x
    #   total = 15*u - union
    #         = 15*u - 43*v + 41*w - 13*x
    #
    # Now use a recurrence relation to vary u, v, w, x (instead of making them
    # functions of len) and we can factor their coefficients out of each iter-
    # ation. 
    u, v, w, x = 15*16, 43*15, 41*14, 13*13

    (3..n).reduce( 0 ) do |acc, i|
      u, v, w, x = u*16, v*15, w*14, x*13
      acc + u - v + w - x
    end.to_s( 16 ).upcase
  end
end
