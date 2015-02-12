require 'projectEuler'

# 
class Problem_0122
  def title; 'Efficient exponentiation' end

  # The most naive way of computing n^15 requires fourteen multiplications:
  #
  #      n × n × ... × n = n^15
  #
  # But using a "binary" method you can compute it in six multiplications:
  #
  #      n    × n   = n^2
  #      n^2  × n^2 = n^4
  #      n^4  × n^4 = n^8
  #      n^8  × n^4 = n^12
  #      n^12 × n^2 = n^14
  #      n^14 × n   = n^15
  #
  # However it is yet possible to compute it in only five multiplications:
  #
  #      n    × n   = n^2
  #      n^2  × n   = n^3
  #      n^3  × n^3 = n^6
  #      n^6  × n^6 = n^12
  #      n^12 × n^3 = n^15
  #
  # We shall define m(k) to be the minimum number of multiplications to
  # compute n^k; for example m(15) = 5.
  #
  # For 1 ≤ k ≤ 200, find ∑ m(k).

  def refs
    ["http://en.wikipedia.org/wiki/Addition-chain_exponentiation",
     "https://oeis.org/A003313",
     "http://wwwhomes.uni-bielefeld.de/achim/ac.ps.gz",
     "http://cr.yp.to/papers/pippenger.pdf"]
  end

  def solution; end
  def best_time; end

  def completed_on; '2015-02-??' end
  def ordinality; end
  def percentile; end

  def chain( k, mins, seqs, tab = 0 )
    return seqs[k] if seqs[k]

    (1..k/2).each do |i|
      cs = chain( k - i, mins, seqs, tab + 1 )

      seq = [i, k - i]
      seqs[seq] = k
      len = seq.uniq.reduce( seq.length - 1 ) {|acc, e| acc + mins[e]}
      mins[k] = len if mins[k].nil? || len < mins[k]
#      puts "%s  seqs: #{seqs.inspect}" % ['  ' * tab]

      cs.each do |h, v|
        seq = [i] + h
        seqs[seq] = k
        len = seq.uniq.reduce( seq.length - 1 ) {|acc, e| acc + mins[e]}
        mins[k] = len if len < mins[k]
      end
    end

    seqs.select {|h, v| v == k}
  end

  def solve( k = 15 )
    # For 0 < k <= 6:
    #   1: 0
    #   2: 1+(1)=1
    #   3: 1+(2)=2, 1+(1+(1))=2
    #   4: 1+(3)=3, 1+(1+(2))=3, 1+(1+(1+(1)))=3,
    #      2+(2)=2
    #   5: 1+(4)=3, 1+(1+(3))=4, 1+(1+(1+(2)))=4, 1+(1+(1+(1+(1))))=4, 1+(2+(2))=3,
    #      2+(3)=4, 2+(1+(2))=4, 2+(1+(1+(1)))=4
    #   6: 1+(5)=4, 1+(1+(4))=4, 1+(1+(1+(3)))=5, 1+(1+(1+(1+(2))))=5, 1+(1+(1+(1+(1+(1)))))=5, 1+(1+(2+(2)))=4,
    #      2+(4)=4, 2+(1+(3))=5, 2+(1+(1+(2)))=4, 2+(1+(1+(1+(1))))=5, 2+(2+(2))=3
    #      3+(3)=3, 3+(1+(2))=5, 3+(1+(1+(1)))=5
    #
    # Looking at each partition of k {p[0], p[1], ..., p[m]} where k = ∑ p[i],
    # we naively start with l(k) = m - 1 + ∑ l(p[i]). We don't have to sum
    # p[j], though, if p[i] = p[j] for some i != j. That is, only unique p[i]
    # contribute to the total. (Each addition counts as 1, however, no matter
    # what.)
    #
    # So we recursively partition k, eliminate duplicate p[i], and compute
    # m - 1 + ∑ l(p[i]) where p[i] != p[j] ∀ i, j.
    mins = {1=>0}
    seqs = {[1]=>1}

    chain( k, mins, seqs )
#    mins.values.reduce( :+ )
    mins.inspect
  end
end
