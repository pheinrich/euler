require 'projectEuler'

class Problem_0045
  def title; 'Triangular, pentagonal, and hexagonal' end
  def difficulty; 5 end

  # Triangle, pentagonal, and hexagonal numbers are generated by the following
  # formulae:
  #
  #     Triangle    T[n]=n(n+1)/2   1, 3,  6, 10, 15, ...
  #     Pentagonal  P[n]=n(3n-1)/2  1, 5, 12, 22, 35, ...
  #     Hexagonal   H[n]=n(2n-1)    1, 6, 15, 28, 45, ...
  #
  # It can be verified that T[285] = P[165] = H[143] = 40755.
  #
  # Find the next triangle number that is also pentagonal and hexagonal.

  def solve( t = 285, p = 165, h = 143 )
    # Every hexagonal number is also triangular, so just look for numbers
    # that are also pentagonal.
    dp, dh = 3*p + 1, 4*h + 1
    p = h = 2*h*h - h

    begin
      # Advance to the next hexagonal number.
      h += dh
      dh += 4

      # Advance pentagonal numbers until we reach the current hexagonal one.
      while p < h
        p += dp
        dp += 3
      end
    end while p != h

    p
  end

  def solution; 'MTUzMzc3NjgwNQ==' end
  def best_time; 0.002225 end
  def effort; 5 end

  def completed_on; '2013-03-09' end
  def ordinality; 29_787 end
  def population; 303_855 end

  def refs; [] end
end
