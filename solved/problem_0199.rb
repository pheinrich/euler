require 'projectEuler'

class Problem_0199
  def title; 'Iterative Circle Packing' end
  def difficulty; 70 end

  # Three circles of equal radius are placed inside a larger circle such that
  # each pair of circles is tangent to one another and the inner circles do not
  # overlap. There are four uncovered "gaps" which are to be filled iteratively
  # with more tangent circles (see diagram).
  #
  # At each iteration, a maximally sized circle is placed in each gap, which
  # creates more gaps for the next iteration. After 3 iterations (pictured),
  # there are 108 gaps and the fraction of the area which is not covered by
  # circles is 0.06790342, rounded to eight decimal places.
  #
  # What fraction of the area is not covered by circles after 10 iterations?
  # Give your answer rounded to eight decimal places using the format
  # x.xxxxxxxx.

  CIRCLES = [[1, Complex( 0, 0 )],
             [1, Complex( 2, 0 )],
             [1, Complex( 1, Math.sqrt( 3 ) )]]

  def external( u, v, w )
    # Use Descartes' Theorem to find the curvature (1/r) and center of the
    # circle externally tangent to three other mutually tangent circles.
    c1, c2, c3  = CIRCLES[u], CIRCLES[v], CIRCLES[w]

    k = c1[0] + c2[0] + c3[0] - 2*Math.sqrt( c1[0]*c2[0] + c2[0]*c3[0] + c3[0]*c1[0] )
    z = (c1[1]*c1[0] + c2[1]*c2[0] + c3[1]*c3[0] - 2*Math.sqrt( c1[0]*c2[0]*c1[1]*c2[1] + c2[0]*c3[0]*c2[1]*c3[1] + c3[0]*c1[0]*c3[1]*c1[1])) / k

    return [k, z]
  end

  def internal( u, v, w )
    # Use Descartes' Theorem to find the curvature (1/r) and center of the
    # circle internally tangent to three other mutually tangent circles.
    c1, c2, c3  = CIRCLES[u], CIRCLES[v], CIRCLES[w]

    k = c1[0] + c2[0] + c3[0] + 2*Math.sqrt( c1[0]*c2[0] + c2[0]*c3[0] + c3[0]*c1[0] )
    z = (c1[1]*c1[0] + c2[1]*c2[0] + c3[1]*c3[0] + 2*Math.sqrt( c1[0]*c2[0]*c1[1]*c2[1] + c2[0]*c3[0]*c2[1]*c3[1] + c3[0]*c1[0]*c3[1]*c1[1])) / k

    return [k, z]
  end

  def solve( n = 10 )
    # Start with three mutually tangent unit circles and find a circle that
    # circumscribes them.
    CIRCLES << external( 0, 1, 2 )
    i = CIRCLES.length

    # Track 3-tuples of mutually tangent circles to be inscribed.
    nextGaps = [[0, 1, 2], [0, 1, 3], [0, 2, 3], [1, 2, 3]]

    # Iterate over the gaps between circles, filling them in with ever smaller
    # and smaller circles.
    n.times do
      gaps, nextGaps = nextGaps, []

      # For each set of three circles, generate a new inscribed circle. This
      # will create three new gaps to be similarly filled in the next phase
      # (if there is one).
      gaps.each do |gap|
        CIRCLES << internal( gap[0], gap[1], gap[2] )
        nextGaps << [gap[0], gap[1], i] << [gap[0], gap[2], i] << [gap[1], gap[2], i]
        i += 1
      end
    end

    # Calculate the area of the circumscribing circle and the total amount
    # covered by all the smaller circles we generated.
    disk = Math::PI / (CIRCLES[3][0] * CIRCLES[3][0])
    covered = CIRCLES.reduce( 0 ) {|acc, c| acc + Math::PI / (c[0]*c[0]) }

    # Format the uncovered ratio as directed.
    "%0.8f" % (2 - covered / disk)
  end

  def solution; 'MC4wMDM5NjA4Nw==' end
  def best_time; 1.943 end
  def effort; 15 end

  def completed_on; '2018-09-13' end
  def ordinality; 1520 end
  def population; 780_654 end

  def refs
    ['https://en.wikipedia.org/wiki/Apollonian_gasket',
     'https://en.wikipedia.org/wiki/Descartes%27_theorem']
  end
end
