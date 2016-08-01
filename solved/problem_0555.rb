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

  def solve( p = 1_000_000, m = 1_000_000 )
    # From Knuth, below, we can simplify the generalized recurrence relation
    # above to M_m,k,s(n) = n > m ? n - s : M_m,k,s(n + k - s), provided that
    # s < k. Knuth describes such function as 'total'.
    #
    # According to Knuth, when the generalized 91 is total, we can express it
    # in closed form:
    #
    #   M_m,k,s(n) = n > m ? n - s : m + k - cs - ((m - n) % (k - cs + s))
    #
    # (For McCarthy 91, c = 2.) To find the fixed points, set the expression
    # equal to n and simplify:
    #
    #   n = n > m ? n - s : m + k - cs - ((m - n) % (k - cs + s))
    #   for n > m:
    #     n = n - s
    #   for n <= m:
    #     n = m + k - s - ((m - n) % (k - cs + s)) 
    #     (m - n) % (k - cs + s) = m + k - s - n
    #
    # The first case isn't possible unless s == 0, which never happens. Since
    # b > c if a % b = c, the second case implies k - cs + s > m + k - cs - n.
    # That means the first (possible) fixed point is:
    #
    #   k - cs + s > m + k - cs - n
    #   s > m - n
    #   n + s > m
    #   n > m - s  ==>  n >= m - s + 1
    #
    # The second case also says that m - n is some multiple of k - cs + s,
    # plus the modulus m + k - s - n: 
    #
    #   (m - n) % (k - cs + s) = m + k - s - n
    #   m - n = X(k - cs + s) + m + k - s - n
    #   0 = X(k - cs + s) + k - s
    #   0 = Xk - Xcs + Xs + k - cs
    #   0 = k(X + 1) - cs(X + 1) + Xs
    #   Xs = (cs - k)(X + 1)
    #   Xs/(X + 1) = cs - k
    #   X/(X + 1) = c - k/s
    #
    # From this we learn that we can identify fixed points by looking at the
    # GCD of k and s; s/k = gcd/(gcd + 1). A straightforward approach would
    # then be to compute the GCD for each candidate [k, s], then test for
    # fixed-ness only if s/gcd == k/gcd + 1. It turns out this is really slow,
    # however.
    #
    # If we look at the GCDs as we compute them, though, we can use OEIS to
    # identify a significant sequence: A003989. It suggests looking at the
    # values as a table, and then a clear pattern appears (fixed points marked
    # with square brackets):
    #
    #   k/s 1  2  3  4  5  6  7  8  9 10
    #    1  1 [1] 1  1  1  1  1  1  1  1
    #    2  1  2 [1][2] 1  2  1  2  1  2
    #    3  1  1  3 [1] 1 [3] 1  1  3  1
    #    4  1  2  1  4 [1][2] 1 [4] 1  2
    #    5  1  1  1  1  5 [1] 1  1  1 [5]
    #    6  1  2  3  2  1  6 [1][2][3] 2
    #    7  1  1  1  1  1  1  7 [1] 1  1
    #    8  1  2  1  4  1  2  1  8 [1][2]
    #    9  1  1  3  1  1  3  1  1  9 [1]
    #   10  1  2  1  2  5  2  1  2  1 10  
    #
    # This suggests a couple of optimizations, such as starting with s = k/2
    # (instead of s = m - n + 1) and checking only up to k - 1. We also note
    # that the lower limit can be pushed up even higher for odd k (namely,
    # s = 3k/2), and k - 1 if k is prime. Unfortunately, these optimizations
    # aren't enough to make the computation tractable for p, m = 1M.
    #
    # Extending the table above out to k = 30, though, we notice that there
    # are distinct rays of fixed points, with a new ray added for every even
    # k, starting at (k, k - 2) and having slope gcd / (gcd + 1). We can use
    # this to step through successive GCD values without having to explicitly
    # compute any of them at all.
    sum = 0
    dk, ds = 2, 1

    # The first ray (not including the main diagonal) starts at (4, 2).
    (4..p).step( 2 ) do |low|
      s = low - 2
      gcd = 2

      # The first GCD of every new ray is 2 and increases by 1 from there.
      (low..p).step( dk ) do |k|
        # Compute the sum of x + (x + 1) + (x + 2) + ... + (x + gcd-1), where
        # x = m - s + 1 tells us the first valid fixed point for k, s and
        # gcd tells us how many fixed points there are:
        #
        #   x + (x + 1) + (x + 2) + ... + (x + gcd-1) =
        #   x + x + x + ... + 1 + 2 + 3 + ... + gcd-1 =
        #   x·gcd + gcd·(gcd - 1)/2
        x = m - s + 1
        sum += gcd*x + gcd*(gcd - 1)/2

        gcd += 1
        s += ds
      end

      dk += 1
      ds += 1      
    end

    # Now add in the fixed points corresponding to the main diagonal.
    (2..p).each {|k| sum += m - k + 2}

    sum
  end

  def solution; 'MjA4NTE3NzE3NDUxMjA4MzUy' end
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
