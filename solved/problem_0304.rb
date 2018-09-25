require 'projectEuler'

class Problem_0304
  def title; 'Primonacci' end
  def difficulty; 35 end

  # For any positive integer n the function next_prime(n) returns the smallest
  # prime p such that p>n.
  #
  # The sequence a(n) is defined by:
  #   a(1)=next_prime(10^14) and a(n)=next_prime(a(n-1)) for n>1.
  #
  # The fibonacci sequence f(n) is defined by: f(0)=0, f(1)=1 and
  # f(n)=f(n-1)+f(n-2) for n>1.
  #
  # The sequence b(n) is defined as f(a(n)).
  #
  # Find ∑b(n) for 1 ≤ n ≤ 100,000. Give your answer mod 1234567891011.

  def solve( n = 100_000, m = 1_234_567_891_011 )
    primes, i = [], 100_000_000_000_029

    while 0 < n
      i += 2 until i.miller_rabin?
      primes << i
      i += 2
      n -= 1
    end

    primes.reduce( 0 ) {|acc, p| (acc + p.fibmod( m )) % m}
  end

  def solution; 'MjgzOTg4NDEwMTky' end
  def best_time; 61.15 end
  def effort; 35 end

  def completed_on; '2018-09-25' end
  def ordinality; 1_706 end
  def population; 783_902 end

  def refs
    ['https://en.wikipedia.org/wiki/Pisano_period']
  end
end
