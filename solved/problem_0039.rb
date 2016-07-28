require 'projectEuler'

class Problem_0039
  def title; 'Integer right triangles' end
  def difficulty; 5 end

  # If p is the perimeter of a right angle triangle with integral length
  # sides, {a,b,c}, there are exactly three solutions for p = 120.
  #
  #     {20,48,52}, {24,45,51}, {30,40,50}
  #
  # For which value of p <= 1000, is the number of solutions maximised?

  def solve( n = 1_000 )
    counts = n.pytriple_sieve
    counts.max # puts "#{counts.index( counts.max )}"
  end

  def solution; 'OA==' end
  def best_time; 0.0001709 end
  def effort; 10 end

  def completed_on; '2013-03-06' end
  def ordinality; 28_841 end
  def population; 285_594 end

  def refs; [] end
end
