require 'projectEuler'

# 10001st prime
class Problem_0007
  # By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
  # that the 6th prime is 13.
  #
  # What is the 10001st prime number?

  def self.solve( n )
    i = 3
    p = 2

    while 1 < n
      if i.prime?
        p = i
        n -= 1
      end
      i += 2
    end

    puts p
  end
end

ProjectEuler.time do
  # 104743
  Problem_0007.solve( 10001 )
end
