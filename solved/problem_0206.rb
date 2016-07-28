require 'projectEuler'

class Problem_0206
  def title; 'Concealed Square' end
  def difficulty; 5 end

  # Find the unique positive integer whose square has the form
  # 1_2_3_4_5_6_7_8_9_0, where each "_" is a single digit.

  def solve
    # Since any square number that ends in '0' must end in '00', we know the
    # last three digits of the square above must be '900'. That means we can
    # factor out 100 and simply multiply the root by 10, when we find it.
    #
    # The root must fall somewhere between the roots of the min and max values
    # possible for the square:
    min = Math.sqrt( 10203040506070809 ).to_i
    max = Math.sqrt( 19293949596979889 ).to_i

    # Since we know the last digit of the factored square is 9, the last
    # digit of the root must be 3 or 7. Adjust the starting point to ensure
    # the first candidate ends in 3.
    min += 3 - min % 10
    step = 4

    while min < max
      break min if (min*min).to_s =~ /1.2.3.4.5.6.7.8.9/

      # Advance to the next candidate root. Alternate adding 4 and 6 so we
      # always land on a number ending in 3 or 7. This reduces the number of
      # roots we have to check by 80%.
      min += step
      step = step ^ 2 
    end

    # Don't forget to account for the 100 we factored out.
    10 * min
  end

  def solution; 'MTM4OTAxOTE3MA==' end
  def best_time; 5.978 end
  def effort; 35 end

  def completed_on; '2015-01-18' end
  def ordinality; 12_886 end
  def population; 482_929 end

  def refs; [] end
end
