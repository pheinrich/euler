require 'projectEuler'

# Truncatable primes
class Problem_0037
  # The number 3797 has an interesting property. Being prime itself, it is
  # possible to continuously remove digits from left to right, and remain
  # prime at each stage: 3797, 797, 97, and 7. Similarly we can work from
  # right to left: 3797, 379, 37, and 3.
  #
  # Find the sum of the only eleven primes that are both truncatable from left
  # to right and right to left.
  #
  # NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

  def self.solve()
    p = ProjectEuler.eratosthenes( 1000000 ).map( &:to_s ).select {|s| s =~ /^[25]?[1379]*$/ }
    sum = 0

    for s in p
      next if 1 == s.length
      next if true == (1...s.length).each {|i| break true if !s[i..-1].to_i.prime?}
      next if true == (1..s.length).each {|i| break true if !s[0..-i].to_i.prime?}

      sum += s.to_i
    end

    puts sum
  end
end

ProjectEuler.time do
  # 748317 (1.183s)
  Problem_0037.solve()
end
