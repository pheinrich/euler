require 'projectEuler'

# Pandigital products
class Problem_0032
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

  def self.solve()
    perms = (1..9).to_a.permutation.map {|p| p.join}
    prods = []

    perms.each do |p|
      (1..2).each do |len|
        a, b, c = p[0, len].to_i, p[len..4].to_i, p[5, 4].to_i
        prods << c if a * b == c
      end
    end
    
    puts prods.uniq.reduce( :+ )
  end
end

ProjectEuler.time do
  # 45228
  Problem_0032.solve()
end
