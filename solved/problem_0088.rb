require 'projectEuler'

class Problem_0088
  def title; 'Product-sum numbers' end
  def difficulty; 40 end

  # A natural number, N, that can be written as the sum and product of a given
  # set of at least two natural numbers, {a1, a2, ... , ak} is called a
  # product-sum number: N = a1 + a2 + ... + ak = a1 × a2 × ... × ak.
  #
  # For example, 6 = 1 + 2 + 3 = 1 × 2 × 3.
  #
  # For a given set of size, k, we shall call the smallest N with this
  # property a minimal product-sum number. The minimal product-sum numbers for
  # sets of size, k = 2, 3, 4, 5, and 6 are as follows.
  #
  #     k=2: 4 = 2 × 2 = 2 + 2
  #     k=3: 6 = 1 × 2 × 3 = 1 + 2 + 3
  #     k=4: 8 = 1 × 1 × 2 × 4 = 1 + 1 + 2 + 4
  #     k=5: 8 = 1 × 1 × 2 × 2 × 2 = 1 + 1 + 2 + 2 + 2
  #     k=6: 12 = 1 × 1 × 1 × 1 × 2 × 6 = 1 + 1 + 1 + 1 + 2 + 6
  #
  # Hence for 2≤k≤6, the sum of all the minimal product-sum numbers is
  # 4+6+8+12 = 30; note that 8 is only counted once in the sum.
  #
  # In fact, as the complete set of minimal product-sum numbers for 2≤k≤12 is
  # {4, 6, 8, 12, 15, 16}, the sum is 61.
  #
  # What is the sum of all the minimal product-sum numbers for 2≤k≤12000?

  def prodSum( sum, prod, last )
    # Compute final term satisfying N = ∑a_i = ∏a_i. If it's an integer, use
    # it to calculate N, otherwise return nil.
    return nil if 1 == prod
    return nil if sum + last < prod * last

    ak = 1.0 * sum / (prod - 1)
    return nil if ak.to_i != ak

    sum + ak.to_i
  end

  def solve( max = 12_000 )
    sum  = [1, 2]
    prod = [1, 2]
    last = [1, 2]
    mins = []
    
    # For each value of k, find valid extensions of the (k-1)-length paths we
    # have found so far, computing the kth integer element for each, if it
    # exists. Choose the smallest N from these options.  
    (2..max).each do |k|
      min = k << 1
      len = sum.length

      len.times do
        s, p, l = sum.shift, prod.shift, last.shift

          (l..(k+1)/p).each do |ext|
            sum  << s + ext
            prod << p * ext
            last << ext
          end
 
        ps = prodSum( s, p, l )
        min = ps if ps && ps < min
      end

      mins << min
    end

    mins.uniq.reduce( :+ )
  end

  def solution; 'NzU4NzQ1Nw==' end
  def best_time; 543.8 end
  def effort; 80 end
  
  def completed_on; '2014-01-05' end
  def ordinality; 5_178 end
  def population; 361_284 end
  
  def refs
    ['http://www-users.mat.umk.pl/~anow/ps-dvi/si-krl-a.pdf',
     'https://oeis.org/A104173']
  end
end
