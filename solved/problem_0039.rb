require 'projectEuler'

# Integer right triangles
class Problem_0039
  # If p is the perimeter of a right angle triangle with integral length
  # sides, {a,b,c}, there are exactly three solutions for p = 120.
  #
  #     {20,48,52}, {24,45,51}, {30,40,50}
  #
  # For which value of p <= 1000, is the number of solutions maximised?

  def self.solve( n )
    counts = n.pytriple_sieve
    puts "#{counts.index( counts.max )}"
  end
end

ProjectEuler.time do
  # count(840) = 8 (0.001001s)
  Problem_0039.solve( 1000 )
end
