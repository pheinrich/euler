require 'projectEuler'

class Problem_0148
  def title; 'Exploring Pascal\'s Triangle' end
  def difficulty; 50 end

  # We can easily verify that none of the entries in the first seven rows of
  # Pascal's triangle are divisible by 7:
  #
  #                    1
  #                 1     1
  #              1     2     1
  #           1     3     3     1
  #        1     4     6     4     1
  #     1     5    10    10     5     1
  #  1     6    15    20    15     6     1
  #
  # However, if we check the first one hundred rows, we will find that only
  # 2361 of the 5050 entries are not divisible by 7.
  #
  # Find the number of entries which are not divisible by 7 in the first one
  # billion (10^9) rows of Pascal's triangle.

  def solve( n = 1_0_000_000 )#n = 1_000_000_000 )
    # Computing the number of non-7-divisible entries for the first 100 rows,
    # we begin to see a simple pattern:
    #
    #   rows   0-6:  1,  2,  3,  4,  5,  6,  7
    #   rows  7-13:  2,  4,  6,  8, 10, 12, 14
    #   rows 14-20:  3,  6,  9, 12, 15, 18, 21
    #   rows 21-27:  4,  8, 12, 16, 20, 24, 28
    #   rows 28-34:  5, 10, 15, 20, 25, 30, 35
    #   rows 35-41:  6, 12, 18, 24, 30, 36, 42
    #   rows 42-48:  7, 14, 21, 28, 35, 42, 49
    #
    # If we accumulate these values in a queue, then counting for each block
    # of 7 rows starts with a value from the queue itself and increases by
    # that value. Note how counts for the first 7 blocks of 7 rows start with
    # and count by the first 7 queue values. Rows 49-55 start counting from 2,
    # rows 56-62 start from 4, rows 63-69 start from 6, etc.
    #
    #    2   4   6   8  10  12  14      4   8  12  16  20  24  28
    #    6  12  18  24  30  36  42      8  16  24  32  40  48  56
    #   10  20  30  40  50  60  70     12  24  36  48  60  72  84
    #   14  28  42  56  70  84  98      3   6   9  12  15  18  21
    #    6  12  18  24  30  36  42      9  18  27  36  45  54  63
    #   12  24  36  48  60  72  84     15  30  45  60  75  90 105
    #
    circbuf = Array.new( n / 7 )
    head = tail = 0

    queue = *(2..7)
    sum = 1 + queue.sum
    n -= 7

    while 0 < n
      step = queue.shift
      count = step
#      puts "step:#{step}, sum:#{sum}, queue:#{queue.inspect}"

      [n, 7].min.times do
        queue << count if n/7 > queue.length
 #       puts count
        sum += count
        count += step
        n -= 1
      end
    end

    sum
  end

  def solution; '' end
  def best_time; 1 end
  def effort; 50 end

  def completed_on; '20??-??-??' end
  def ordinality; 1 end
  def population; 1 end

  def refs; [] end
end
