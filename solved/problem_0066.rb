require 'projectEuler'

# 0.08464 (12/13/13, #~9009)
class Problem_0066
  def title; 'Diophantine equation' end

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

  def refs; ["http://www.numbertheory.org/pdfs/talk_2004.pdf"] end
  def solution; 661 end
  def best_time; 0.08464 end
  
  def completed_on; '2013-12-13' end
  def ordinality; 9_009 end
  def percentile; 97.62 end

  def solve( n = 1_000 )
    # Minimal solution comes from one of the convergents of the continued
    # fraction for the square root of D.  Choose which one based on whether
    # the length of the periodic part is odd or even.
 
    x = []
    2.upto( n ).each do |i|
      cf = i.sqrt_cf
      l = cf.length - 1
      
      unless 0 == l
        l <<= 1 if 1 == l % 2
        x << [cf.convergent( l - 1 ).numerator, i]
      end
    end
    
    x.max[1]
  end
end
