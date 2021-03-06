require 'projectEuler'

class Problem_0009
  def title; 'Special Pythagorean triplet' end
  def difficulty; 5 end

  # A Pythagorean triplet is a set of three natural numbers, a < b < c, for
  # which,
  #           a^2 + b^2 = c^2
  #
  # For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
  #
  # There exists exactly one Pythagorean triplet for which a + b + c = 1000.
  # Find the product a * b * c.
  
  def solve( n = 1_000 )
    # Euclid's formula for generating Pythagorean triples says that for
    # integers u and v, a = 2uv, b = u^2 - v^2, and c = u^2 + v^2.  Knowing
    # that a + b + c = n, we can simplify to obtain v = (n - 2u^2) / 2u.
    # Now we can increment over u to produce v and generate Pythagorean
    # triples until we find the correct one.
    (1..n).each do |u|
      v = (n - 2*u*u) / (2*u)

      # Only accept v if it's a natural number less than u (check by verifying
      # the sum is still correct, even after rounding).
      return (v * u**5 - u * v**5) << 1 if u > v && n == (2*u) * (u + v)
    end
  end

  def solution; 'MzE4NzUwMDA=' end
  def best_time; 0.00001383 end
  def effort; 20 end

  def completed_on; '2013-01-26' end
  def ordinality; 116_174 end
  def population; 292_794 end

  def refs
    ['https://en.wikipedia.org/wiki/Pythagorean_triple']
  end
end
