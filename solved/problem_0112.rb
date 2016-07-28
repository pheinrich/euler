require 'projectEuler'

class Problem_0112
  def title; 'Bouncy numbers' end
  def difficulty; 15 end

  # Working from left-to-right if no digit is exceeded by the digit to its
  # left it is called an increasing number; for example, 134468.
  #
  # Similarly if no digit is exceeded by the digit to its right it is called a
  # decreasing number; for example, 66420.
  #
  # We shall call a positive integer that is neither increasing nor decreasing
  # a "bouncy" number; for example, 155349.
  #
  # Clearly there cannot be any bouncy numbers below one-hundred, but just
  # over half of the numbers below one-thousand (525) are bouncy. In fact, the
  # least number for which the proportion of bouncy numbers first reaches 50%
  # is 538.
  #
  # Surprisingly, bouncy numbers become more and more common and by the time
  # we reach 21780 the proportion of bouncy numbers is equal to 90%.
  #
  # Find the least number for which the proportion of bouncy numbers is ex-
  # actly 99%.

  def solve( n = 99 )
    type = [0, 0, 0, 0]
    x, limit = 0, 0

    begin
      x += 1

      # As x increases, keep a running total of n*x and 100 times the count of
      # bouncy numbers so far. This makes our percentage check a simple (and
      # exact) comparison of integers for equality. 
      limit += n
      type[ x.bounce ] += 100
    end while limit != type[3]

    x
  end

  def solution; 'MTU4NzAwMA==' end
  def best_time; 0.7786 end
  def effort; 20 end
    
  def completed_on; '2015-01-12' end
  def ordinality; 14_269 end
  def population; 481_348 end
  
  def refs; [] end
end
