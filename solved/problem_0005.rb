require 'projectEuler'

# Smallest multiple
class Problem_0005
  # 2520 is the smallest number that can be divided by each of the numbers
  # from 1 to 10 without any remainder.
  #
  # What is the smallest positive number that is evenly divisible by all of
  # the numbers from 1 to 20?
  
  def self.solve( n )
    arr = []

    # Collect the prime factors of all values up to n.
    (2..n).each do |x|
      tmp = Array.new( arr )
      x.prime_factors.each do |f|
        
        # If our prime factor collection has at least as many copies of the
        # current factor as are needed by the current value, we're good.
        # Otherwise, we need to add more to our collection.
        i = tmp.index( f )
        if i
          tmp.delete_at( i )
        else
          arr << f
        end
      end
    end

    # Multiply all the factors together.
    puts arr.inject( :* )
  end
end

ProjectEuler.time do
  # 232792560 (0.0000s)
  Problem_0005.solve( 20 )
end
