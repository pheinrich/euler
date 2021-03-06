require 'projectEuler'

class Problem_0087
  def title; 'Prime power triples' end
  def difficulty; 20 end

  # The smallest number expressible as the sum of a prime square, prime cube,
  # and prime fourth power is 28. In fact, there are exactly four numbers
  # below fifty that can be expressed in such a way:
  #
  #     28 = 2^2 + 2^3 + 2^4
  #     33 = 3^2 + 2^3 + 2^4
  #     49 = 5^2 + 2^3 + 2^4
  #     47 = 2^2 + 3^3 + 2^4
  # 
  # How many numbers below fifty million can be expressed as the sum of a
  # prime square, prime cube, and prime fourth power?

  def solve( n = 50_000_000 )
    terms = (2..4).map {|root| (1 + n**(1.0 / root)).to_i.prime_sieve}
    (2..4).each {|i| terms[i - 2].map! {|j| j**i}}

    sums = {}
    for c in terms[2]
      for b in terms[1]
        for a in terms[0]
          sum = a + b + c
          sums[sum] = true if sum < n
        end
      end
    end

    sums.keys.count
  end
  
  def solution; 'MTA5NzM0Mw==' end
  def best_time; 0.7744 end
  def effort; 10 end
  
  def completed_on; '2014-01-05' end
  def ordinality; 10_109 end
  def population; 383_384 end
  
  def refs; [] end
end
