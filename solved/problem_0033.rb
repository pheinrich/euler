require 'projectEuler'

class Problem_0033
  def title; 'Digit canceling fractions' end
  def difficulty; 5 end

  # The fraction 49/98 is a curious fraction, as an inexperienced
  # mathematician in attempting to simplify it may incorrectly believe that
  # 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.
  #
  # We shall consider fractions like, 30/50 = 3/5, to be trivial examples.
  #
  # There are exactly four non-trivial examples of this type of fraction, less
  # than one in value, and containing two digits in the numerator and
  # denominator.
  #
  # If the product of these four fractions is given in its lowest common
  # terms, find the value of the denominator.

  def solve
    prod = 1

    # Don't include 10 since there's no non-trivial solution that includes it.
    11.upto( 98 ) do |n|
      na = n.to_s.chars.to_a

      # Only check values greater than the numerator, since we know n/d < 1.
      (n+1).upto( 99 ) do |d|
        nd = Rational( n, d )
        da = d.to_s.chars.to_a

        # Do nothing if numerator and denominator share no digits, or if the
        # only shared digit is 0.
        shared = (na & da)
        unless shared.empty? || (na | da).include?( "0" )
          # Remove the shared digit from both values.  If the digit is doubled
          # (e.g. 11, 22, 33, etc.) adjust the result after removal ("") to
          # cancel only one instance of the digit. 
          u, v = (na - da)[0].to_i, (da - na)[0].to_i
          u = shared[0].to_i if 0 == u
          v = shared[0].to_i if 0 == v

          # Include the resulting fraction in the result if appropriate.
          r = Rational( u, v )
          prod *= r if nd == r
        end
      end
    end

    prod.denominator
  end

  def solution; 'MTAw' end
  def best_time; 0.01164 end
  def effort; 10 end
    
  def completed_on; '2013-02-15' end
  def ordinality; 27_603 end
  def population; 280_879 end
  
  def refs; [] end
end
