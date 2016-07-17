require 'projectEuler'

# 37.08s (7/17/16, #4029)
class Problem_0130
  def title; 'Composites with prime repunit property' end
  def difficulty; 45 end

  # A number consisting entirely of ones is called a repunit. We shall define
  # R(k) to be a repunit of length k; for example, R(6) = 111111.
  #
  # Given that n is a positive integer and GCD(n, 10) = 1, it can be shown
  # that there always exists a value, k, for which R(k) is divisible by n, and
  # let A(n) be the least such value of k; for example, A(7) = 6 and
  # A(41) = 5.
  #
  # You are given that for all primes, p > 5, that p − 1 is divisible by A(p).
  # For example, when p = 41, A(41) = 5, and 40 is divisible by 5.
  #
  # However, there are rare composite values for which this is also true; the
  # first five examples being 91, 259, 451, 481, and 703.
  #
  # Find the sum of the first twenty-five composite values of n for which
  # GCD(n, 10) = 1 and n − 1 is divisible by A(n).

  def aofn( n )
    return 0 if 0 == n % 2 || 0 == n % 5

    m, n = 1, 9*n
    m += 1 while 1 != 10.modular_power( m, n )
    m
  end

  def solve( count = 25 )
    max = count * 1000
    p = [*2..max] - max.prime_sieve
    sols = []

    p.each do |n|
      a = aofn( n )
      sols << n if 0 < a && 0 == (n - 1) % a
      break if sols.count == count
    end      
    
    puts sols.inspect
    sols.reduce( :+ )
  end

  def solution; 149_253 end
  def best_time; 37.08 end
  def effort; 5 end

  def completed_on; '2016-07-17' end
  def ordinality; 4_029 end
  def population; 579_023 end

  def refs
    ["http://oeis.org/A000864"]
  end
end
