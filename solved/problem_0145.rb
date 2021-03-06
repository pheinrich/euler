require 'projectEuler'

class Problem_0145
  def title; 'How many reversible numbers are there below one-billion?' end
  def difficulty; 20 end

  # Some positive integers n have the property that the sum [ n + reverse(n) ]
  # consists entirely of odd (decimal) digits. For instance, 36 + 63 = 99 and
  # 409 + 904 = 1313. We will call such numbers reversible; so 36, 63, 409,
  # and 904 are reversible. Leading zeroes are not allowed in either n or
  # reverse(n).
  #
  # There are 120 reversible numbers below one-thousand.
  #
  # How many reversible numbers are there below one-billion (10^9)?

  def solve( n = 1_000_000_000 )
    log10 = Math.log10( n )

    sum = (0...log10).map do |i|
      if 0 == (i % 4)
        0
      elsif 0 != (i % 2)
        20 * 30**((i - 1)/2)
      else
        100 * 500**((i - 2)/4)
      end
    end

    sum.reduce( :+ )
  end

  def solution; 'NjA4NzIw' end
  def best_time; 0.00004292 end
  def effort; 30 end

  def completed_on; '2015-01-20' end
  def ordinality; 9_591 end
  def population; 483_455 end

  def refs; ['https://oeis.org/A135739'] end
end

# Pattern discovery:
#  log10:      0  1  2  3  4  5  6  7  8
#  component:  -  3  5  3  -  3  5  3  -
#
#  2    6   10   14   (x)
#  0    4    8   12   (x-2)
#  0    1    2    3   (x-2)/4
#
#  1   500            500^(x-2)/4
#  100 50000          100*500^(x-2)/4
#
#                 1-10:  0                (log10 = 0)
#                1    :  0
#                2    :  0
#                3    :  0
#                4    :  0
#                5    :  0
#                6    :  0
#                7    :  0
#                8    :  0
#                9    :  0
#               10-100:  20       1 x 20  (log10 = 1)  20 / 1 = 20
#                1    :  4        4 x 1
#                2    :  4        4 x 1
#                3    :  3        3 x 1
#                4    :  3        3 x 1
#                5    :  2        2 x 1
#                6    :  2        2 x 1
#                7    :  1        1 x 1
#                8    :  1        1 x 1
#                9    :  0        0 x 1
#             100-1000:  100      5 x 20  (log10 = 2)
#                1    :  0        0 x 5
#                2    :  5        1 x 5
#                3    :  5        1 x 5
#                4    :  10       2 x 5
#                5    :  10       2 x 5
#                6    :  15       3 x 5
#                7    :  15       3 x 5
#                8    :  20       4 x 5
#                9    :  20       4 x 5
#           1000-10000:  600      30 x 20 (log10 = 3)  3 x 200
#                1    :  120      4 x 30 = 4 x (3 x 20)/2
#                2    :  120      4 x 30 = 4 x (3 x 20)/2
#                3    :  90       3 x 30 = 4 x (3 x 20)/2
#                4    :  90       3 x 30 = 4 x (3 x 20)/2
#                5    :  60       2 x 30 = 4 x (3 x 20)/2
#                6    :  60       2 x 30 = 4 x (3 x 20)/2
#                7    :  30       1 x 30 = 4 x (3 x 20)/2
#                8    :  30       1 x 30 = 4 x (3 x 20)/2
#                9    :  0        0 x 30 = 4 x (3 x 20)/2
#         10000-100000:  0        0 x 20
#                1    :  0
#                2    :  0
#                3    :  0
#                4    :  0
#                5    :  0
#                6    :  0
#                7    :  0
#                8    :  0
#                9    :  0
#       100000-1000000:  18000    900 x 20 (log10 = 5)  318000 / 5 = 3600
#                1    :  3600     4 x 900 = 4 x (3 x 600)/2
#                2    :  3600     4 x 900 = 4 x (3 x 600)/2
#                3    :  2700     3 x 900 = 4 x (3 x 600)/2
#                4    :  2700     3 x 900 = 4 x (3 x 600)/2
#                5    :  1800     2 x 900 = 4 x (3 x 600)/2
#                6    :  1800     2 x 900 = 4 x (3 x 600)/2
#                7    :  900      1 x 900 = 4 x (3 x 600)/2
#                8    :  900      1 x 900 = 4 x (3 x 600)/2
#                9    :  0        0 x 900 = 4 x (3 x 600)/2
#     1000000-10000000:  50000    2500 x 20 (log10 = 6)  20 x 5 x (
#                1    :  0        0 x 2500 = 0 x (5 x 500)
#                2    :  2500     1 x 2500 = 1 x (5 x 500)
#                3    :  2500     1 x 2500 = 1 x (5 x 500)
#                4    :  5000     2 x 2500 = 2 x (5 x 500)
#                5    :  5000     2 x 2500 = 2 x (5 x 500)
#                6    :  7500     3 x 2500 = 3 x (5 x 500)
#                7    :  7500     3 x 2500 = 3 x (5 x 500)
#                8    :  10000    4 x 2500 = 4 x (5 x 500)
#                9    :  10000    4 x 2500 = 4 x (5 x 500)
#   10000000-100000000:  540000   27000 x 20
#                1    :  108000   4 x 27000 = 4 x (3 x 18000)/2
#                2    :  108000   4 x 27000 = 4 x (3 x 18000)/2
#                3    :  81000    3 x 27000 = 4 x (3 x 18000)/2
#                4    :  81000    3 x 27000 = 4 x (3 x 18000)/2
#                5    :  54000    2 x 27000 = 4 x (3 x 18000)/2
#                6    :  54000    2 x 27000 = 4 x (3 x 18000)/2
#                7    :  27000    1 x 27000 = 4 x (3 x 18000)/2
#                8    :  27000    1 x 27000 = 4 x (3 x 18000)/2
#                9    :  0        0 x 27000 = 4 x (3 x 18000)/2
# 100000000-1000000000:  0        0 x 20
#                1    :  0
#                2    :  0
#                3    :  0
#                4    :  0
#                5    :  0
#                6    :  0
#                7    :  0
#                8    :  0
#                9    :  0
