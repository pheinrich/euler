require 'projectEuler'

# Prime digit replacements
class Problem_0051
  # By replacing the 1st digit of *3, it turns out that six of the nine
  # possible values: 13, 23, 43, 53, 73, and 83, are all prime.
  #
  # By replacing the 3rd and 4th digits of 56**3 with the same digit, this
  # 5-digit number is the first example having seven primes among the ten
  # generated numbers, yielding the family: 56003, 56113, 56333, 56443, 56663,
  # 56773, and 56993. Consequently 56003, being the first member of this
  # family, is the smallest prime with this property.
  #
  # Find the smallest prime which, by replacing part of the number (not
  # necessarily adjacent digits) with the same digit, is part of an eight
  # prime value family.

  def self.solve( n )
    max = 1000000
    bits = Math.log10( max )
    mask = 1 << bits
    
    h = Hash.new
    max.eratosthenes.each {|i| h[i.to_s] = i}
    min = 0
    arr = []

    while 0 < mask
      p = Hash.new
      h.keys.each do |k|
        s = String.new( k )
        sub = false

        0.upto( [bits, s.length].min - 1 ) do |b|
          s[b], sub = '-', true if 0 != (mask & (1 << b))
        end

        if sub
          p[s] = [] if !p.include?( s )
          p[s] << k
        end
      end

      p.each do |v, j|
        a = []
        (0..9).each {|i| t = v.tr( '-', i.to_s ); a << t if j.include?( t )}
        if min < a.length
          arr = a
          min = a.length
        end
      end
      mask -= 1
    end

    puts arr.inspect
  end
end

ProjectEuler.time do
  # ["121313", "222323", "323333", "424343", "525353", "626363", "828383", "929393"] (39.02s)
  Problem_0051.solve( 8 )
end
