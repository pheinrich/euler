require 'projectEuler'

# Pandigital prime
class Problem_0041
  # We shall say that an n-digit number is pandigital if it makes use of all
  # the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital
  # and is also prime.
  #
  # What is the largest n-digit pandigital prime that exists?

  def self.solve()
    max = nil

    # Start with the longest possible and work down.    
    9.downto( 1 ) do |i|
      max = Array.new( i ) {|j| 1 + j}.permutation.to_a.map! {|j| j.join.to_i}.select {|j| j.prime? }.max
      break if max
    end
    
    puts max
  end
end

ProjectEuler.time do
  # 7652413 (3.917s)
  Problem_0041.solve()
end
