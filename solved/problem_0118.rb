require 'projectEuler'

# 19.43s (1/31/15, #3826)
class Problem_0118
  def title; 'Pandigital prime sets' end
  def solution; 44_680 end

  # Using all of the digits 1 through 9 and concatenating them freely to form
  # decimal integers, different sets can be formed. Interestingly with the set
  # {2,5,47,89,631}, all of the elements belonging to it are prime.
  #
  # How many distinct sets containing each of the digits one through nine
  # exactly once contain only prime elements?

  def fill( current, primes, succ, sets )
    set = current.join
    len = set.length

    if 9 == len
      sets << current if set.to_i.pandigital?
    elsif 9 > len
      len = 10 - len

      # There's space left in this set, so try to add more primes.
      while succ < primes.length && primes[succ].to_s.length < len
        fill( current + [primes[succ]], primes, succ + 1, sets )
        succ += 1
      end
    end
  end

  def solve
    # Gather all the 1- and 2-digit primes (except 11, since it isn't made up
    # of distinct digits).
    primes = 100.prime_sieve.reduce( {} ) {|hash, p| hash[p] = p; hash}
    primes.delete( 11 )

    # Add all 3- to 8-digit primes that have no zeros and only one occurrence
    # of any other digits. Note that there are no pandigital primes since
    # 1+2+3+...+9 = 45, which is divisible by 3.
    digits = 1.step( 9, 2 ).map {|i| '123456789'.sub( i.to_s, '' ).chars}
    digits.each_with_index do |sub, i|
      suf = (1 + (i << 1)).to_s
      (2..7).each do |k|
        sub.each do |ch|
          # Permuting valid digits and checking each one for primality is
          # about 8 times faster than sieving up to the maximum (98765431)
          # and then eliminating 0s and repeated digits.
          (sub - [ch]).permutation( k ).each do |perm|
            p = (perm.join + suf).to_i
            primes[p] = p if p.prime?
          end
        end
      end
    end

    primes = primes.keys.sort
    sets = []

    # Combine primes recursively, looking for pandigital sets.
    0.upto( primes.find_index {|p| p > 9999} - 1 ).each do |i|
      fill( [primes[i]], primes, i + 1, sets )
    end

    sets.count
  end
end
