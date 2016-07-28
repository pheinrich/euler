require 'projectEuler'

class Problem_0111
  def title; 'Primes with runs' end
  def difficulty; 45 end

  # Considering 4-digit primes containing repeated digits it is clear that
  # they cannot all be the same: 1111 is divisible by 11, 2222 is divisible by
  # 22, and so on. But there are nine 4-digit primes containing three ones:
  #
  #      1117, 1151, 1171, 1181, 1511, 1811, 2111, 4111, 8111
  #
  # We shall say that M(n, d) represents the maximum number of repeated digits
  # for an n-digit prime where d is the repeated digit, N(n, d) represents the
  # number of such primes, and S(n, d) represents the sum of these primes.
  #
  # So M(4, 1) = 3 is the maximum number of repeated digits for a 4-digit
  # prime where one is the repeated digit, there are N(4, 1) = 9 such primes,
  # and the sum of these primes is S(4, 1) = 22275. It turns out that for
  # d = 0, it is only possible to have M(4, 0) = 2 repeated digits, but there
  # are N(4, 0) = 13 such cases.
  #
  # In the same way we obtain the following results for 4-digit primes.
  #
  #      Digit, d   M(4, d)   N(4, d)   S(4, d)
  #          0         2        13       67061
  #          1         3         9       22275
  #          2         3         1        2221
  #          3         3        12       46214
  #          4         3         2        8888
  #          5         3         1        5557
  #          6         3         1        6661
  #          7         3         9       57863
  #          8         3         1        8887
  #          9         3         7       48073
  #
  # For d = 0 to 9, the sum of all S(4, d) is 273700.
  #
  # Find the sum of all S(10, d).

  def s_of_nd( len, digit )
    primes = {}
    found = false

    # Try repeating the digit as many times as possible, dialing back only if
    # no primes are found.
    len.downto( 2 ).each do |rpt|
      # This computes the number of integers matching any mask with rpt digits
      # fixed (in any positions), including invalid leading-zero cases.
      count = 10**(len - rpt)

      # Fake a bit mask (as a string) that will keep track of where the digit
      # is repeated. We'll advance this mask sequentially to other values
      # having the same number of set bits (keeping the digit substitution
      # count constant).
      low = "%0.#{len}b" % ((1 << rpt) - 1)
      high = low.reverse.to_i( 2 )

      while low.to_i( 2 ) <= high
        # Extract the character positions NOT holding the repeated digit, then
        # replicate that digit everywhere else to prepare for substitution.
        sub = low.each_char.with_index.inject( [] ) {|arr, (ch, i)| arr << i if '0' == ch; arr}
        check = low.tr( '1', digit.to_s )

        # Cycle through every variation, distributing the digits of the
        # current count across the digit positions not occupied by the repeat-
        # ed character.
        count.times do |i|
          ("%0#{sub.length}d" % i).each_char.with_index {|ch, j| check[sub[j]] = ch} if 0 < sub.length
          next if '0' == check[0]
          prime = check.to_i

          if prime.prime?
            primes[prime] = true
            found = true
          end
        end

        # Advance to the next mask having the same number of set bits.
        low = "%0.#{len}b" % low.to_i( 2 ).bitseq
      end

      # Don't bother with shorter repetition lengths if it's unnecessary.
      break if found
    end

    # Add up all the primes we found. Using a hash for intermediate storage
    # prevents us from inadvertently finding the same prime more than once.
    primes.keys.reduce( 0 ) {|acc, k| acc + k}
  end

  def solve( n = 10 )
    (0..9).reduce( 0 ) {|acc, d| acc + s_of_nd( n, d )}
  end

  def solution; 'NjEyNDA3NTY3NzE1' end
  def best_time; 0.2758 end
  def effort; 25 end
    
  def completed_on; '2015-01-29' end
  def ordinality; 4_161 end
  def population; 457_820 end
  
  def refs; [] end
end
