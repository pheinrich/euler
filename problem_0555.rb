require 'projectEuler'

class Problem_0555
  def title; 'McCarthy 91 function' end
  def difficulty; 30 end

  # The McCarthy 91 function is defined as follows:
  #             
  #   M_91(n) = { n - 10                if n > 100
  #             { M_91(M_91(n + 11))    if 0 <= n <= 100
  #
  # We can generalize this definition by abstracting away the constants into
  # new variables:
  #
  #   M_m,k,s(n) = { n − s                      if n > m
  #                { M_m,k,s(M_m,k,s(n + k))    if 0 <= n <= m
  #
  # This way, we have M_91 = M_100,11,10.
  #
  # Let F_m,k,s be the set of fixed points of M_m,k,s. That is,
  #
  #   F_m,k,s = { n ∈ N | M_m,k,s(n) = n}
  #
  # For example, the only fixed point of M_91 is n = 91. In other words,
  # F_100,11,10 = {91}.
  #
  # Now, define SF(m,k,s) as the sum of the elements in F_m,k,s and let
  #
  #   S(p,m) =    ∑ SF(m,k,s)
  #            1≤s<k≤p
  #
  # For example, S(10,10) = 225 and S(1000,1000) = 208724467.
  # Find S(10^6,10^6).

  def mf( n, m = 100, k = 11, s = 10, c = 2 )
    # Closed form of generalized McCarthy 91 (from Knuth).
    n > m ? n - s : m + k - c*s - ((m - n) % (k - c*s + s))
    
    # Finding fixed points:
    # for n > m:
    #   n = n - s (not possible unless s == 0)
    # for n <= m:
    #   n = m + k - cs - ((m - n) % (k - cs + s))
    #   ((m - n) % (k - cs + s)) = m + k - cs - n     ==>    k - cs + s > m + k - cs - n
    #   lower bound is m - s + 1                      <==    s > m - n
    #
    #   (m % (k - cs + s) - n % (k - cs + s)) % (k - cs + s) = m + k - cs - n
    #   m - n = X(k - cs + s) + m + k - cs - n        when   s > m - n
    #   0 = X(k - cs + s) + k - cs
    #   0 = Xk - Xcs + Xs + k - cs
    #   0 = k(X + 1) - cs(X + 1) + Xs
    #   Xs = (cs - k)(X + 1)
    #   Xs/(X + 1) = cs - k
    #   X/(X + 1) = c - k/s
  end

  def ff( m = 100, k = 11, s = 10 )
    (1..m).select {|n| n == mf( n, m, k, s )}
  end

  def sf( m = 100, k = 11, s = 10 )
    ret = ff( m, k, s ).reduce( :+ ) || 0
    ret
  end

  def ss( p, m )
    sum = 0
    dk, ds = 2, 1

    (4..p).step( 2 ) do |low|
      s = low - 2
      gcd = 2

      (low..p).step( dk ) do |k|
        x = m - s + 1
        sum += gcd*x + gcd*(gcd - 1)/2

        gcd += 1
        s += ds
      end

      dk += 1
      ds += 1      
    end

    (2..p).each do |k|
      sum += m - k + 2
    end

    sum
  end
  
  def solve( p = 1_000_000, m = 1_000_000 )
    # From Knuth, below, we can simplify the generalized recurrence relation
    # above to M_m,k,s(n) = n > m ? n - s : M_m,k,s(n + k - s), provided that
    # s < k. Knuth describes such function as 'total'.
    #
    # According to Knuth, when the generalized 91 is total, we can express it
    # in closed form:
    #
    #   M_m,k,s(n) = n > m ? n - s : m + k - s - ((m - n) % (k - s))
    ss( p, m )
  end

  def solution; 208_517_717_451_208_352 end
  def best_time; 2.051 end
  def effort; 30 end

  def completed_on; '2016-08-01' end
  def ordinality; 300 end
  def population; 618_352 end

  def refs
    ['https://en.wikipedia.org/wiki/McCarthy_91_function',
     'http://oeis.org/A103847',
     'http://arxiv.org/pdf/cs/9301113.pdf',
     'http://oeis.org/A003989']
  end
end
