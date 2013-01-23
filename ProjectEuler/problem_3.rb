class Problem_3
  # The prime factors of 13195 are 5, 7, 13 and 29.
  #
  # What is the largest prime factor of the number 600851475143?

  def self.solve
    n = 600851475143
    f = n
    i = 2

    while i <= n / i do
      while n % i == 0 do
        f = i
        n /= i
      end
      i += 1
    end

    puts 1 < n ? n : f
  end
end

Problem_3.solve
 