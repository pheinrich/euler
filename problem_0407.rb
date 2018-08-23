require 'projectEuler'

class Problem_0407
  def title; 'Idempotents' end
  def difficulty; 20 end

  # If we calculate a^2 mod 6 for 0 ≤ a ≤ 5 we get: 0,1,4,3,4,1.
  #
  # The largest value of a such that a^2 ≡ a mod 6 is 4.
  # Let's call M(n) the largest value of a < n such that a^2 ≡ a (mod n).
  # So M(6) = 4.
  #
  # Find ∑M(n) for 1 ≤ n ≤ 10^7.

  def mofn( n )
    # Equivalent to (but only slightly faster than):
    #
    # def mofn( n )
    #  (n - 2).downto( 2 ) do |x|
    #    return x if x == x*x % n
    #  end
    #  1
    #end

    s = n*n - n
    d = 2
    x = s % n
    i = n

    while 0 < s
      s -= 2*n - d
      x += d
      x -= n until x < n

      return i - 1 if 0 == x

      d += 2
      i -= 1
    end
  end

  def solve( limit = 1_000 ) # 10_000_000 )
    # a^2 ≡ a (mod n) is the same as saying a^2 - a ≡ 0 (mod n), which means
    # n divides a(a - 1). Though M(n) = 1 for most n, calculating it becomes
    # expensive quickly. If we can identify in advance n for which M(n) != 1,
    # then the problem may be tractable.
    #
    # It turns out that only n that are not prime powers--that is, n that
    # don't have the form p^k, where p is some prime and k >= 1--satisfy this
    # requirement. Therefore, we can step through all prime powers < limit and
    # eliminate them from our M(n) calculation, knowing it to be 1 for each.
    array = *(2..limit)
    primes = Math.sqrt( limit ).to_i.prime_sieve

    # Visit every prime power < limit and set its M(n) to 1.
    primes.each do |p|
      val = p
      while val < limit
        array[val - 2] = 1
        val *= p
      end
    end

    # Perform the (expensive) calculation of M(n) only for the non-prime
    # powers that are left.
    array.each_with_index do |val, n|
      array[n] = mofn( n + 2 ) if 1 != val
    end

    # Sum all M(n), plus 1 since we didn't include it in our array (having
    # started with 2, the first prime).
    1 + array.reduce( :+ )
#    puts array.map.with_index {|v, i| "#{i+2}:#{v}"}.inspect
#    puts array.inspect
#    array.count {|n| 1 != n}
  end

  def solution; 1 end
  def best_time; 1 end
  def effort; 1 end

  def completed_on; '20??-??-??' end
  def ordinality; 1 end
  def population; 1 end

  def refs
    ['https://oeis.org/A060036',
     'https://oeis.org/A182665',
     'https://oeis.org/A024619']
  end
end
