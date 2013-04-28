require 'projectEuler'

# Prime pair sets
class Problem_0060
  # The primes 3, 7, 109, and 673, are quite remarkable. By taking any two
  # primes and concatenating them in any order the result will always be
  # prime. For example, taking 7 and 109, both 7109 and 1097 are prime. The
  # sum of these four primes, 792, represents the lowest sum for a set of four
  # primes with this property.
  #
  # Find the lowest sum for a set of five primes for which any two primes
  # concatenate to produce another prime.

  POWER = 3
  P = ProjectEuler.eratosthenes( 10**(POWER << 1) ).map {|p| p.to_s}; nil
  MAX = P.count {|p| POWER >= p.length } - 1

  def self.solve( n )
    h = {}
    q = P[0...MAX].map {|p| P.select {|i| i.end_with?( p )}}; nil

    q.map do |a|
      l = 1 + a[0].length
      h[a[0]] = a[1..-1].map {|i| i[0..-l]}; nil
    end; nil

    q = h.map {|k, v| v.select {|i| h[i] && h[i].include?( k )}}; nil
    (0...MAX-1).each do |i|
      next if q.size < 1
  
      (i+1...MAX).each do |j|
        next if (q[i] & q[j]).size < n - 1
        puts "#{P[i]} & #{P[j]} = #{(q[i] & q[j]).size}"
      end
    end
  end
end

ProjectEuler.time do
  # 
  Problem_0060.solve( 5 )
end
