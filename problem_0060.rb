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
  P = ProjectEuler.eratosthenes( 10**(POWER << 1) ).map {|p| p.to_s}
  MAX = P.count {|p| POWER >= p.length } - 1

  def self.search( hash, target, array, keys )
    array.each do |p|
      intersection = array & hash[p]
      if intersection.length > 0
        break if keys.length == target
        keys << p
        search( hash, target, intersection, keys)
      end
    end

    return keys.length == target    
  end

  def self.solve( n )
    # For each prime < 1000, find all primes < 1000000 that end with it.  For
    # example, q[1] = ["3", "13", "23", "43", "53", "73", "83", "103", ...].
    q = P[0...MAX].map {|p| P.select {|i| i.end_with?( p )}}
    h = {}

    # Strip the suffix prime from each array value.  For example, the array
    # above generates h["3"] => ["1", "2", "4", "5", "7", "8", "10", ...].
    q.map do |a|
      l = 1 + a[0].length
      h[a[0]] = a[1..-1].map {|i| i[0..-l]}
    end

    # Strip the composites from each list of prefixes, and make sure the
    # primes that remain are mutually concatenatable. Continuing the example
    # above:  h["3"] = ["7", "11", "17", "31", "37", "59", "67", ...].
    q = h.map {|k, v| v.select {|i| h[i] && h[i].include?( k )}}
    h.clear
    (0...MAX).each {|i| h[P[i]] = q[i]}

    # Traverse the set looking for groups of n mutually concatenatable primes.
    h.each {|k, v| keys = [k]; puts keys.inspect if search( h, n, v, keys ) }
  end
end

ProjectEuler.time do
  # 
  Problem_0060.solve( 5 )
end
