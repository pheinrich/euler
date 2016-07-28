require 'projectEuler'

class Problem_0172
  def title; 'Investigating numbers with few repeated digits' end
  def difficulty; 55 end

  # How many 18-digit numbers n (without leading zeros) are there such that no
  # digit occurs more than three times in n?

  def solve( len = 18, max = 3 )
    # A very convenient approach to this problem involves exponential gener-
    # ating functions. If we allow every digit to appear 0, 1, 2, or 3 times
    # only (in any location), then the polynomial representing each digit will
    # be:
    #           x^2   x^3
    #   1 + x + --- + ---
    #            2!    3!
    #
    # Multiplying this out for all 10 digits gives us the number of solutions
    # for a number of length i. We simply read off the resulting coefficient
    # for x^i.
    #
    # However, there are certain numbers that we don't consider valid: we want
    # to eliminate leading zeros. We can count numbers of that form in a sim-
    # ilar way, noting that the first digit will be zero and that at most two
    # of the remaining digits will be zero, as well:
    #
    #            x^2   x^3           x^2
    #   (1 + x + --- + ---)^9 (1 + x ---)
    #             2!    3!            2!
    #
    # In this case, we want the coefficient for x^(i - 1), since we're effect-
    # ively reducing the length of the number by one, setting the first digit
    # to zero.
    all = Array.new( max + 1 ) {|i| Rational( 1, i.fact )}
    zeros = all[0..-2]

    # Precompute the shared term.
    common = all.dup
    8.times {common = common.multpoly( all )}

    # Substract the leading zero cases from the all-inclusive ones.
    total = common.multpoly( all )[len] * len.fact
    total -= common.multpoly( zeros )[len - 1] * (len - 1).fact

    # We've been dealing with Rationals for simplicity, so take the numerator.
    total.to_i
  end

  def solution; 'MjI3NDg1MjY3MDAwOTkyMDAw' end
  def best_time; 0.0007138 end
  def effort; 45 end

  def completed_on; '2016-07-06' end
  def ordinality; 2_583 end
  def population; 576_237 end

  def refs
    ['http://en.wikipedia.org/wiki/Algebra_of_sets',
     'http://math.stackexchange.com/questions/122384/venn-diagram-3-set#122417',
     'http://blog.janmr.com/2008/12/twelve-ways-of-counting.html',
     'http://math.stackexchange.com/a/1803794',
     'https://en.wikipedia.org/wiki/Enumerative_combinatorics#Generating_functions']
  end
end
