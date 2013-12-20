require 'projectEuler'

# Self powers
class Problem_0048
  # The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.
  #
  # Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.

  def self.solve( n, d )
    m = 10**d
    puts (1..n).inject {|s, x| s + x.modular_power( x, m )}.to_s[-d, d]
  end
end

ProjectEuler.time do
  # 9110846700 (1.198s)
  Problem_0048.solve( 1000, 10 )
end
