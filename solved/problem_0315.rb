require 'projectEuler'

class Problem_0315
  def title; 'Digital root clocks' end
  def difficulty; 20 end

  # Sam and Max are asked to transform two digital clocks into two "digital
  # root" clocks. A digital root clock is a digital clock that calculates
  # digital roots step by step.
  #
  # When a clock is fed a number, it will show it and then it will start the
  # calculation, showing all the intermediate values until it gets to the
  # result. For example, if the clock is fed the number 137, it will show:
  # "137" → "11" → "2" and then it will go black, waiting for the next number.
  #
  # Every digital number consists of some light segments: three horizontal
  # (top, middle, bottom) and four vertical (top-left, top-right, bottom-left,
  # bottom-right). Number "1" is made of vertical top-right and bottom-right,
  # number "4" is made by middle horizontal and vertical top-left, top-right
  # and bottom-right. Number "8" lights them all.
  #
  # The clocks consume energy only when segments are turned on/off. To turn on
  # a "2" will cost 5 transitions, while a "7" will cost only 4 transitions.
  #
  # Sam and Max built two different clocks.
  # 
  # Sam's clock is fed e.g. number 137: the clock shows "137", then the panel
  # is turned off, then the next number ("11") is turned on, then the panel is
  # turned off again and finally the last number ("2") is turned on and, after
  # some time, off. For the example, with number 137, Sam's clock requires:
  #
  #   "137" : (2 + 5 + 4) × 2 = 22 transitions ("137" on/off).
  #   "11"  : (2 + 2) × 2 = 8 transitions ("11" on/off).
  #   "2"   : (5) × 2 = 10 transitions ("2" on/off).
  #   For a grand total of 40 transitions.
  #
  # Max's clock works differently. Instead of turning off the whole panel, it
  # is smart enough to turn off only those segments that won't be needed for
  # the next number. For number 137, Max's clock requires:
  #
  #   "137" : 2 + 5 + 4 = 11 transitions ("137" on)
  #           7 transitions (to turn off the segments that are not needed for
  #           number "11").
  #   "11"  : 0 transitions (number "11" is already turned on correctly)
  #           3 transitions (to turn off the first "1" and the bottom part of
  #           the second "1"; the top part is common with number "2").
  #   "2"   : 4 transitions (to turn on the remaining segments in order to get
  #           a "2")
  #           5 transitions (to turn off number "2").
  #   For a grand total of 30 transitions.
  #
  # Of course, Max's clock consumes less power than Sam's one. The two clocks
  # are fed all the prime numbers between A = 10^7 and B = 2×10^7. Find the
  # difference between the total number of transitions needed by Sam's clock
  # and that needed by Max's one.

  NUMERALS = [63, 6, 91, 79, 102, 109, 125, 39, 127, 111]
  SEGROOTS = {}

  def get_root( n, len )
    # Retrieve the segment mask for each decimal digit while we compute the
    # intermediate digital root.
    unless SEGROOTS.has_key?( n )
      segs, root, x = [], 0, n

      begin
        segs << NUMERALS[x % 10]
        root += x % 10
        x /= 10
        len -= 1
      end while 0 < x

      # Add 0s to pad out to len digits.
      while 0 < len
        segs << 0
        len -= 1
      end

      # Memoize the digital root, segment masks, and total hamming weight.
      SEGROOTS[n] = [root, segs, segs.reduce( 0 ) {|acc, i| acc + i.hamming}]
    end
    
    SEGROOTS[n]
  end

  def solve( min = 10_000_000, max = 20_000_000 )
    # Find all the primes between min and max.
    primes = max.prime_sieve
    primes = primes[primes.find_index {|i| min < i}..-1]

    # Find the number of digits necessary to represent the largest value.
    len = 1 + Math.log10( max ).to_i
    tranMax, tranSam = 0, 0

    # Feed each prime to both clocks.
    primes.each do |p|
      last = [0, [0]*len, 0]
      segroot = get_root( p, len )

      # Compute successive digital roots until we get the final value.
      until segroot == last 
        # Sam's clock just double counts every transition (on/off). Max's
        # clock counts only the net changes between values, which we can com-
        # pute easily by XOR-ing the segment masks for each digit.
        tranSam += segroot[2] << 1
        tranMax += last[1].zip( segroot[1] ).reduce( 0 ) {|acc, (u, v)| acc + (u ^ v).hamming}

        last = segroot
        segroot = get_root( last[0], len )
      end

      # Figure in the final off transition for Max's clock.s
      tranMax += last[2]
    end

    tranSam - tranMax
  end

  def solution; 'MTM2MjUyNDI=' end
  def best_time; 18.56 end
  def effort; 10 end

  def completed_on; '2016-08-19' end
  def ordinality; 2_031 end
  def population; 623_631 end

  def refs; [] end
end
