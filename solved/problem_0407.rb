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

  def solve( limit = 10_000_000 )
    # It's clear that a^2 ≡ a (mod n) is equivalent to a^2 - a ≡ 0 (mod n), or
    # n | a(a - 1). Since n = (p_1^e_1)(p_2^e_2)...(p_r^e_r), let n = uv, with
    # u = ∏ p_i^e_i and v = ∏ p_j^e_j. That is, form u, v from the prime power
    # factors with no shared terms.
    #
    # Since n = uv, uv | a(a - 1). Either u|a and v|a - 1 or u|a -1 and v|a.
    # Assume u|a. Then a = uw for some w, and since a < n (from the problem
    # statement), uw < uv and ∴ w < v. This implies uw ≡ 1 (mod v) [why?], so
    # w = u^-1 (mod v). Since u, v are coprime, u^phi(v) ≡ 1 (mod v). Divide
    # both sides by u to obtain u^(phi(v) - 1) ≡ u^-1 (mod v).
    #
    # So for every k <= n, we need to check all possible k = uv factorizations
    # and find the one resulting in the largest possible a.
    pf = limit.primefactor_sieve
    t = limit.totient_sieve
    sum = 0

    (2..limit).each do |i|
      len = pf[i].length

      if 2 > len
        # If the prime factor list for i has only one entry, that means i is
        # either prime or some power of a prime. In that case, a will be 1.
        sum += 1
      else
        sum += (1...len).map do |l|
          # Group the prime factor powers of i into every possible config-
          # uration that results in two disjoint sets.
          pf[i].combination( l ).map do |c|
            # Determine the corresponding u and v.
            u = c.reduce( :* )
            v = i / u

            # Since u, v are coprime, we can use v's totient to compute the
            # inverse of u, then multiply to obtain a potential a. The max of
            # these values is the a we want.
            w = u.modular_power( t[v] - 1, v )
            u * w
          end.max
        end.max
      end
    end

    # Note that M(1) = 0, so it doesn't contribute to the sum.
    sum
  end

  def solution; 'Mzk3ODI4NDkxMzY0MjE=' end
  def best_time; 224.1 end
  def effort; 50 end

  def completed_on; '2018-10-02' end
  def ordinality; 1_801 end
  def population; 785_794 end

  def refs
    ['https://oeis.org/A060036',
     'https://oeis.org/A182665',
     'https://oeis.org/A024619',
     'https://math.stackexchange.com/a/264307']
  end
end
