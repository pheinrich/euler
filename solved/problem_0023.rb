require 'projectEuler'

# 3.038s
class Problem_0023
  def title; 'Non-abundant sums' end
  def solution; 4_179_871 end

  # A perfect number is a number for which the sum of its proper divisors is
  # exactly equal to the number. For example, the sum of the proper divisors of
  # 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect
  # number.
  #
  # A number n is called deficient if the sum of its proper divisors is less
  # than n and it is called abundant if this sum exceeds n.
  #
  # As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest
  # number that can be written as the sum of two abundant numbers is 24. By
  # mathematical analysis, it can be shown that all integers greater than 28123
  # can be written as the sum of two abundant numbers. However, this upper
  # limit cannot be reduced any further by analysis even though it is known
  # that the greatest number that cannot be expressed as the sum of two
  # abundant numbers is less than this limit.
  #
  # Find the sum of all the positive integers which cannot be written as the
  # sum of two abundant numbers.

  def solve( n = 28_123 )
    # Precompute the abundant numbers below the max.
    abn = (0..n).select {|i| i.abundant?}
    notsum = Array.new( n ) {|i| i}

    # Pairwise-add all abundant numbers.
    abn.each_with_index do |x, i|
      (i..abn.length).each do |j|
        sum = x + abn[j]
        
        # If it's a number outside the range, we don't have to do any numbers
        # above this one.
        break if sum > n

        # Clear the sum's contribution to the final total.
        notsum[sum] = 0
      end
    end

    # Add up all the numbers not identified as sums.
    notsum.reduce( :+ )
  end
end
