require 'projectEuler'

class Problem_0041
  def title; 'Pandigital prime' end
  def difficulty; 5 end

  # We shall say that an n-digit number is pandigital if it makes use of all
  # the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital
  # and is also prime.
  #
  # What is the largest n-digit pandigital prime that exists?

  def solve
    max = nil

    # Start with the longest possible and work down.    
    9.downto( 1 ) do |i|
      max = Array.new( i ) {|j| 1 + j}.permutation.to_a.map! {|j| j.join.to_i}.select {|j| j.prime? }.max
      break if max
    end
    
    max
  end

  def solution; 'NzY1MjQxMw==' end
  def best_time; 1.708 end
  def effort; 5 end

  def completed_on; '2013-02-17' end
  def ordinality; 27_095 end
  def population; 298_587 end

  def refs; [] end
end
