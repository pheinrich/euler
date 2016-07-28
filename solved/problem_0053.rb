require 'projectEuler'

class Problem_0053
  def title; 'Combinatoric selections' end
  def difficulty; 5 end

  # There are exactly ten ways of selecting three from five, 12345:
  #
  #     123, 124, 125, 134, 135, 145, 234, 235, 245, and 345
  #
  # In combinatorics, we use the notation, C(5,3) = 10.
  #
  # In general,
  #
  #     C(n,r) = n!/(r!(n-r)!)
  #     where r <= n, n! = n x (n-1) x ...x 3 x 2 x 1, and 0! = 1.
  #
  # It is not until n = 23 that a value exceeds one-million:
  # C(23,10) = 1144066.
  #
  # How many, not necessarily distinct, values of C(n,r), for 1 <= n <= 100,
  # are greater than one-million?

  def solve( n = 100, limit = 1_000_000 )
    f = (0..n).map {|i| i.fact}
    count = 0

    1.upto( n ) {|i| 1.upto( n ) {|j| count += 1 if f[i]/(f[j] * f[i - j]) > limit }}
    count
  end

  def solution; 'NDA3NQ==' end
  def best_time; 0.01017 end
  def effort; 10 end

  def completed_on; '2013-03-15' end
  def ordinality; 25_682 end
  def population; 305_435 end
  
  def refs; [] end
end
