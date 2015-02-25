require 'projectEuler'

# 5.435s (1/9/14, #20668)
class Problem_0092
  def title; 'Square digit chains' end

  # A number chain is created by continuously adding the square of the digits
  # in a number to form a new number until it has been seen before.
  #
  # For example,
  #
  #     44 -> 32 -> 13 -> 10 -> 1 -> 1
  #     85 -> 89 -> 145 -> 42 -> 20 -> 4 -> 16 -> 37 -> 58 -> 89
  #
  # Therefore any chain that arrives at 1 or 89 will become stuck in an
  # endless loop. What is most amazing is that EVERY starting number will
  # eventually arrive at 1 or 89.
  #
  # How many starting numbers below ten million will arrive at 89?

  def refs; [] end
  def solution; 8_581_146 end
  def best_time; 5.435 end

  def completed_on; '2014-01-09' end
  def ordinality; 20_668 end
  def population; 362_277 end

  def solve( n = 10_000_000 )
    sum = Array.new( n, 0 )
    limit, scale = 1, Math.log( n, 10 ).round - 1

    # Precompute single digits.
    (0...10).each {|i| sum[i] = i*i}

    # Use previously computed values to speed calculation.
    scale.times do
      limit *= 10
      (limit...10*limit).each do |i|
        j = i
        while 0 < j
          j, r = j / limit, j % limit
          sum[i] += sum[r]
        end
      end
    end

    # Cycle each slot until it reaches a terminal value.
    1.upto( n - 1 ) do |i|
      until 1 == sum[i] || 89 == sum[i]
        sum[i] = sum[sum[i]]
      end
    end 

    # Count may be computed directly from total sum.
    (sum.inject( :+ ) - n + 1) / 88
  end
end
