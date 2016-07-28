require 'projectEuler'

class Problem_0074
  def title; 'Digital factorial chains' end
  def difficulty; 15 end

  # The number 145 is well known for the property that the sum of the
  # factorial of its digits is equal to 145:
  #
  #    1! + 4! + 5! = 1 + 24 + 120 = 145
  #
  # Perhaps less well known is 169, in that it produces the longest chain of
  # numbers that link back to 169; it turns out that there are only three such
  # loops that exist:
  #
  #    169 -> 363601 -> 1454 -> 169
  #    871 -> 45361 -> 871
  #    872 -> 45362 -> 872
  #
  # It is not difficult to prove that EVERY starting number will eventually
  # get stuck in a loop. For example,
  #
  #    69 -> 363600 -> 1454 -> 169 -> 363601 (-> 1454)
  #    78 -> 45360 -> 871 -> 45361 (-> 871)
  #    540 -> 145 (-> 145)
  #
  # Starting with 69 produces a chain of five non-repeating terms, but the
  # longest non-repeating chain with a starting number below one million is
  # sixty terms.
  #
  # How many chains, with a starting number below one million, contain exactly
  # sixty non-repeating terms?

  F = (0..9).map( &:fact )

  def solve( limit = 1_000_000, length = 60 )
    count = 0
    right = {}

    # Reduce each number.
    (1..limit).each do |i|
      d, sum = i, 0

      # This is roughly 2x as fast as the 1-line string-split-inject approach.
      while 0 < d
        q, r = d / 10, d % 10
        sum += F[r]  # lookup ~50% faster than calculating each time
        d = q
      end

      right[i] = sum
    end

    # Count sequence lengths.
    (1..limit).each do |i|
      cur, len = i, 1

      while cur != right[cur]
        len += 1
        case cur = right[cur]
        when 169
          len += 2
          break
        when 871, 872
          len += 1
          break
        end
      end

      # Tally lengths that match the target exactly.
      count += 1 if len == length
    end
    
    count
  end

  def solution; 'NDAy' end
  def best_time; 5.835 end
  def effort; 20 end
    
  def completed_on; '2013-12-20' end
  def ordinality; 12_923 end
  def population; 357_313 end
  
  def refs
    ['https://oeis.org/A061602',
     'https://oeis.org/A214285']
  end
end
