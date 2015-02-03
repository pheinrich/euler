require 'projectEuler'

# 0.001681s (1/13/15, #6664)
class Problem_0113
  def title; 'Non-bouncy numbers' end

  # Working from left-to-right if no digit is exceeded by the digit to its
  # left it is called an increasing number; for example, 134468.
  #
  # Similarly if no digit is exceeded by the digit to its right it is called
  # a decreasing number; for example, 66420.
  #
  # We shall call a positive integer that is neither increasing nor decreasing
  # a "bouncy" number; for example, 155349.
  #
  # As n increases, the proportion of bouncy numbers below n increases such
  # that there are only 12951 numbers below one-million that are not bouncy
  # and only 277032 non-bouncy numbers below 10^10.
  #
  # How many numbers below a googol (10^100) are not bouncy?

  def refs; [] end
  def solution; 51_161_058_134_250 end
  def best_time; 0.001681 end

  def completed_on; '2015-01-13' end
  def ordinality; 6_664 end
  def percentile; 98.53 end

  def solve( log10 = 100 )
    total = 0

    # Sum increasing number counts for each digit position. This calculation
    # doesn't distinguish numbers that are flat (e.g. '111', '999', '44444').
    digcnt = Array.new( 9 ) {1}
    log10.times do
      total += digcnt.reduce( :+ )
      (0...9).each {|i| digcnt[i] = digcnt[i..-1].reduce( :+ )}
    end

    # Update total with counts for decreasing numbers. Flat numbers are count-
    # ed here, too, so we'll account for that later.
    digcnt = Array.new( 9 ) {1}
    log10.times do
      total += digcnt.reduce( :+ )
      (0...9).each {|i| digcnt[i] = 1 + digcnt[i..-1].reduce( :+ )}
    end

    # Adjust total to avoid double-counting the flats.
    total - 9*log10
  end
end
