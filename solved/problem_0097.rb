require 'projectEuler'

# 0.7888s (1/10/14, #25048)
class Problem_0097
  def title; 'Large non-Mersenne prime' end
  def solution; 8739992577 end

  # The first known prime found to exceed one million digits was discovered in
  # 1999, and is a Mersenne prime of the form 2^6972593 − 1; it contains
  # exactly 2,098,960 digits. Subsequently other Mersenne primes, of the form
  # 2^p − 1, have been found which contain more digits.
  #
  # However, in 2004 there was found a massive non-Mersenne prime which con-
  # tains 2,357,207 digits: 28433 × 2^7830457 + 1.
  #
  # Find the last ten digits of this prime number.

  def solve( n = 10 )
    mod = 10**n
    (1 + 28433 * 2.modular_power( 7830457, mod )) % mod
  end
end