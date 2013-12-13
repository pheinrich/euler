require 'projectEuler'

# Diophantine equation
class Problem_0066
  # Consider quadratic Diophantine equations of the form:
  #
  #     x^2 – Dy^2 = 1
  #
  # For example, when D=13, the minimal solution in x is
  # 649^2 - 13 x 180^2 = 1.
  #
  # It can be assumed that there are no solutions in positive integers when D
  # is square.
  #
  # By finding minimal solutions in x for D = {2, 3, 5, 6, 7}, we obtain the
  # following:
  #
  #     3^2 - 2 x 2^2 = 1
  #     2^2 - 3 x 1^2 = 1
  #     9^2 - 5 x 4^2 = 1
  #     5^2 - 6 x 2^2 = 1
  #     8^2 - 7 x 3^2 = 1
  #
  # Hence, by considering minimal solutions in x for D <= 7, the largest x is
  # obtained when D=5.
  #
  # Find the value of D <= 1000 in minimal solutions of x for which the
  # largest value of x is obtained.

  def self.solve( n )
    # http://www.numbertheory.org/php/patz.php
    # http://www.numbertheory.org/pdfs/gauss1.pdf
    # http://www.jpr2718.org/pell.pdf
    # http://archives.math.utk.edu/articles/atuyl/confrac/applications.html
  end
end

ProjectEuler.time do
  # 
  Problem_0066.solve( 1000 )
end
