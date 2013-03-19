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
    h = Hash.new
    ProjectEuler.eratosthenes( 1000000 ).select {|i| i > 56003}.each {|i| h[i.to_s] = i}
    min = 1 << (0.size << 3) - 1

    1.upto( 62 ) do |i|
      puts "pass #{i} (min: #{min})"
      wild = {}
      m = i.to_s( 2 ).rjust( 6 )

      h.keys.each do |p|
        w = p.mask( m, '*' )
        wild[w] ||= 0
        
        if n <= wild[w] += 1
          set = '0123456789'.chars.reduce( [] ) {|a, c| h.keys.include?( w.tr( '*', c ) ) ? a << c : a}

          if n <= set.length
            first = w.tr( '*', set[0] ).to_i
            min = first if min > first
          end
        end
      end
    end

    puts min
  end
end

ProjectEuler.time do
  # 
  Problem_0051.solve( 8 )
end
