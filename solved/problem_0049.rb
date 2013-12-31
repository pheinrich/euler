require 'projectEuler'

# 0.04348s (3/11/13, #~20996)
class Problem_0049
  def title; 'Prime permutations' end
  def solution; 296_962_999_629 end

  # The arithmetic sequence, 1487, 4817, 8147, in which each of the terms
  # increases by 3330, is unusual in two ways: (i) each of the three terms are
  # prime, and, (ii) each of the 4-digit numbers are permutations of one
  # another.
  #
  # There are no arithmetic sequences made up of three 1-, 2-, or 3-digit
  # primes, exhibiting this property, but there is one other 4-digit
  # increasing sequence.
  #
  # What 12-digit number do you form by concatenating the three terms in this
  # sequence?
  P = 10_000.prime_sieve.reject {|i| 1_000 > i}.map {|i| [i, i.to_s.chars.sort.join]}
  
  def solve
    P.each do |p|
      m = P.select {|q| q[1] == p[1]}.map {|q| q[0]}
      next if 3 > m.length || "1478" == p[1]

      0.upto( m.length - 1 ).each do |j|
        arr = []
        0.upto( m.length - 1 ).each do |k|
          d = (m[k] - m[j]).abs
          return ("%d%d%d" % [m[k] - 2*d, m[k] - d, m[k]]).to_i if arr.include?( d )

          arr << d
        end
      end
    end
  end
end
