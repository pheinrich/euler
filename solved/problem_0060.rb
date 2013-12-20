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

  POWER = 8
  P = (10**POWER).prime_sieve

  def self.check( hash, array, n, result )
    return true if 0 == n
    
    array.each do |key|
      if hash.include?( key ) && check( hash, array & hash[key], n - 1, result )
        result[n - 1] = key
        return true
      end
    end
    
    false
  end

  def self.solve( n )
    h = {}
    P[0..-2].each_with_index do |p, i|
      h[p] = []
      pl = 1 + Math.log10( p ).to_i

      P[i+1..-1].each do |q|
        ql = 1 + Math.log10( q ).to_i
        break if POWER < pl + ql

        x = p*(10**ql) + q
        y = q*(10**pl) + p
        next unless x.prime? && y.prime?

        h[p] << q
      end
    end
    
    result = []
    check( h, h.keys(), n, result )
    puts result.reduce( :+ )
  end
end

ProjectEuler.time do
  # 26033 (291.3s)
  Problem_0060.solve( 5 )
end
