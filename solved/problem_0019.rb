require 'date'
require 'projectEuler'

class Problem_0019
  def title; 'Counting Sundays' end
  def difficulty; 5 end

  # You are given the following information, but you may prefer to do some
  # research for yourself.
  #
  #   * 1 Jan 1900 was a Monday.
  #   * Thirty days has September,
  #     April, June and November.
  #     All the rest have thirty-one,
  #     Saving February alone,
  #     Which has twenty-eight, rain or shine.
  #     And on leap years, twenty-nine.
  #   * A leap year occurs on any year evenly divisible by 4, but not on a
  #     century unless it is divisible by 400.
  #
  # How many Sundays fell on the first of the month during the twentieth
  # century (1 Jan 1901 to 31 Dec 2000)?

  def solve( start = Date.new( 1901, 1, 1 ), stop = Date.new( 2000, 12, 31 ) )
    total = 0
    
    # Move to the first Sunday in the range, if not there already.
    start += (7 - start.wday) if !start.sunday?

    # Move forward a week at a time, counting the first-of-months we see.
    while start <= stop
      total += 1 if 1 == start.day
      start += 7
    end

    total
  end

  def solution; 'MTcx' end
  def best_time; 0.004648 end
  def effort; 5 end

  def completed_on; '2013-02-05' end
  def ordinality; 48_603 end
  def population; 295_427 end

  def refs; [] end
end
