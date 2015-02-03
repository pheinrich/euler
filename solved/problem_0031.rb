require 'projectEuler'

# 0.6955s (2/14/13, #29529)
class Problem_0031
  def title; 'Coin sums' end

  # In England the currency is made up of pound, £, and pence, p, and there
  # are eight coins in general circulation:
  #
  #     1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
  #
  # It is possible to make £2 in the following way:
  #
  #     1x£1 + 1x50p + 2x20p + 1x5p + 1x2p + 3x1p
  #
  # How many different ways can £2 be made using any number of coins?

  def refs; [] end
  def solution; 73_682 end
  def best_time; 0.6955 end

  def completed_on; '2013-02-14' end
  def ordinality; 29_529 end
  def percentile; 89.94 end

  def fit( n, denoms, sum = 0, index = 0, total = 0 )
    if index < denoms.length
      0.step( n - sum, denoms[index] ) do |x|
        total = fit( n, denoms, x + sum, 1 + index, total )
      end
    elsif sum == n
      total += 1
    end

    total
  end

  def solve( n = 200, denoms = [200, 100, 50, 20, 10, 5, 2, 1] )
    fit( n, denoms )
  end
end
