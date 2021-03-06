require 'projectEuler'

class Problem_0075
  def title; 'Singular integer right triangles' end
  def difficulty; 25 end

  # It turns out that 12 cm is the smallest length of wire that can be bent to
  # form an integer sided right angle triangle in exactly one way, but there
  # are many more examples.
  #
  #    12 cm: (3,4,5)
  #    24 cm: (6,8,10)
  #    30 cm: (5,12,13)
  #    36 cm: (9,12,15)
  #    40 cm: (8,15,17)
  #    48 cm: (12,16,20)
  #
  # In contrast, some lengths of wire, like 20 cm, cannot be bent to form an
  # integer sided right angle triangle, and other lengths allow more than one
  # solution to be found; for example, using 120 cm it is possible to form
  # exactly three different integer sided right angle triangles.
  #
  #    120 cm: (30,40,50), (20,48,52), (24,45,51)
  #
  # Given that L is the length of the wire, for how many values of
  # L ≤ 1,500,000 can exactly one integer sided right angle triangle be
  # formed?

  def solve( n = 1_500_000 )
    n.pytriple_sieve.count( 1 )
  end

  def solution; 'MTYxNjY3' end
  def best_time; 0.4533 end
  def effort; 15 end

  def completed_on; '2013-12-21' end
  def ordinality; 8_409 end
  def population; 379_435 end

  def refs
    ['https://en.wikipedia.org/wiki/Pythagorean_triple',
     'https://oeis.org/A098714']
  end
end
