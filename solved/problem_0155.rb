require 'projectEuler'

class Problem_0155
  def title; 'Counting Capacitor Circuits' end
  def difficulty; 60 end

  # An electric circuit uses exclusively identical capacitors of the same
  # value C. The capacitors can be connected in series or in parallel to form
  # sub-units, which can then be connected in series or in parallel with other
  # capacitors or other sub-units to form larger sub-units, and so on up to a
  # final circuit.
  #
  # Using this simple procedure and up to n identical capacitors, we can make
  # circuits having a range of different total capacitances. For example,
  # using up to n=3 capacitors of 60 μF each, we can obtain the following 7
  # distinct total capacitance values (see diagram).
  #
  # If we denote by D(n) the number of distinct total capacitance values we
  # can obtain when using up to n equal-valued capacitors and the simple pro-
  # cedure described above, we have: D(1)=1, D(2)=3, D(3)=7 ...
  #
  # Find D(18).
  #
  # Reminder : When connecting capacitors C_1, C_2 etc in parallel, the total
  # capacitance is C_T = C_1 + C_2 +..., whereas when connecting them in
  # series, the overall capacitance is given by:
  #
  #    1     1     1
  #   --- = --- + --- + ...
  #   C_T   C_1   C_2

  def solve( caps = 18 )
    # Basic approach is to treat each term as a rational, then construct all
    # possible values by adding one term at a time (serially and in parallel)
    # to every value seen so far, up to and including n terms. At the end, we
    # can drop duplicates and count the total.
    #
    # Combining a/b and c/d in series yields (ad + bc)/bd. Combining them in
    # parallel gives ac/(ad + bc). Generating every possible combination is
    # slow, but there's symmetry we may be able to exploit: if a/b is seen,
    # then b/a will also be seen. We must be careful not to over-count 1,
    # though, since it equals its own reciprocal.
    #
    # For each count of terms from 1 to n, we'll count keep track of all the
    # possible values that may be formed. This means adding one additional
    # term in series and in parallel with every entry seen for n-1 terms.
    seen = Array.new( caps ) {Hash.new}
    seen[0][0x00010001] = true if 0 < caps

    # For each number of terms, build on the last set of values.
    (1...caps).each do |i|
      curr = seen[i]

      # Enumerate all the values formed by combining smaller blocks whose
      # total terms sum exactly to the current number.
      j, k = 0, i - 1
      while j <= k
        first, last = seen[j], seen[k]

        first.keys.each do |u|
          n, d = u >> 16, 0xffff & u

          last.keys.each do |v|
            p, q = v >> 16, 0xffff & v

            # Pair-wise combine the values associated with each block.
            r = n*q + p*d
            s = d*q

            # Reduce the resulting rational to its simplest form, ignoring 1
            # since we already accounted for it and we can save some work by
            # skipping it.
            if r != s
              g = r.gcd( s )
              r, s = r / g, s / g if 1 < g
              
              curr[s << 16 | r] = true
              curr[r << 16 | s] = true
            end
          end
        end

        # Advance both ends toward the middle to maintain the current sum.
        j += 1
        k -= 1
      end

      # Proactively drop duplicates if any were generated.
      (0...i).each {|j| curr.reject! {|k, v| seen[j].has_key?( k )}}
    end
    
    seen.reduce( 0 ) {|acc, h| acc + h.size}
  end

  def solution; 'Mzg1NzQ0Nw==' end
  def best_time; 50.98 end
  def effort; 25 end

  def completed_on; '2016-07-12' end
  def ordinality; 2_354 end
  def population; 577_682 end

  def refs
    ['https://oeis.org/A048211',
     'https://oeis.org/A153588',
     'https://oeis.org/A226909',
     'http://arxiv.org/pdf/1004.3346v1.pdf']
  end
end
