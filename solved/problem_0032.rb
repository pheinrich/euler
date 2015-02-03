require 'projectEuler'

# 2.703s (2/14/13, #~26994)
class Problem_0032
  def title; 'Pandigital products' end

  # We shall say that an n-digit number is pandigital if it makes use of all
  # the digits 1 to n exactly once; for example, the 5-digit number, 15234, is
  # 1 through 5 pandigital.
  #
  # The product 7254 is unusual, as the identity, 39 x 186 = 7254, containing
  # multiplicand, multiplier, and product is 1 through 9 pandigital.
  #
  # Find the sum of all products whose multiplicand/multiplier/product
  # identity can be written as a 1 through 9 pandigital.
  #
  # HINT: Some products can be obtained in more than one way so be sure to
  # only include it once in your sum.

  def refs; [] end
  def solution; 45_228 end
  def best_time; 2.703 end

  def completed_on; '2013-02-14' end
  def ordinality; 26_994 end
  def percentile; 91.38 end

  def solve
    perms = (1..9).to_a.permutation.map {|p| p.join}
    prods = []

    perms.each do |p|
      (1..2).each do |len|
        a, b, c = p[0, len].to_i, p[len..4].to_i, p[5, 4].to_i
        prods << c if a * b == c
      end
    end
    
    prods.uniq.reduce( :+ )
  end
end
