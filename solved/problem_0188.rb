require 'projectEuler'

class Problem_0188
  def title; 'The hyperexponentiation of a number' end
  def difficulty; 35 end

  # The hyperexponentiation or tetration of a number a by a positive integer
  # b, denoted by a↑↑b or ba, is recursively defined by:
  #
  #   a↑↑1 = a,
  #   a↑↑(k+1) = a(a↑↑k).
  #
  # Thus we have e.g. 3↑↑2 = 3^3 = 27, hence 3↑↑3 = 3^27 = 7625597484987 and
  # 3↑↑4 is roughly 10^3.6383346400240996*10^12.
  #
  # Find the last 8 digits of 1777↑↑1855.

  def solve( base = 1777, exp = 1855, digits = 8 )
    # Euler's Theorem says that for two numbers a, b that are coprime (their
    # GCD is 1), a^φ(b) ≡ 1 (mod b), where φ(b) is Euler's Totient Function,
    # the count of numbers < b that do not divide it.
    base.modular_tetrate( exp, 10**digits )
  end

  def solution; 'OTU5NjIwOTc=' end
  def best_time; 0.006095 end
  def effort; 10 end

  def completed_on; '2016-08-04' end
  def ordinality; 4_666 end
  def population; 619_505 end

  def refs
    ['https://en.wikipedia.org/wiki/Tetration']
  end
end
