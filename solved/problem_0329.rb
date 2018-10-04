require 'projectEuler'

class Problem_0329
  def title; 'Prime Frog' end
  def difficulty; 25 end

  # Susan has a prime frog. Her frog is jumping around over 500 squares
  # numbered 1 to 500. He can only jump one square to the left or to the
  # right, with equal probability, and he cannot jump outside the range
  # [1;500]. (If it lands at either end, it automatically jumps to the only
  # available square on the next move.)
  #
  # When he is on a square with a prime number on it, he croaks 'P' (PRIME)
  # with probability 2/3 or 'N' (NOT PRIME) with probability 1/3 just before
  # jumping to the next square.
  #
  # When he is on a square with a number on it that is not a prime he croaks
  # 'P' with probability 1/3 or 'N' with probability 2/3 just before jumping
  # to the next square.
  #
  # Given that the frog's starting position is random with the same
  # probability for every square, and given that she listens to his first 15
  # croaks, what is the probability that she hears the sequence
  # PPPPNNPPPNPPNPN?
  #
  # Give your answer as a fraction p/q in reduced form.

  def solve( n = 500, s = 'PPPPNNPPPNPPNPN' )
    primes = (1..500).map {|i| i.prime?}
    probs = [Rational( 1, n )] * n

    s.each_char do |c|
      succ = [Rational( 0, 1 )] * n
      (0...n).each do |i|
        match = Rational( ('P' != c) ^ primes[i] ? 2 : 1, 3 )

        if 0 == i
          succ[i + 1] += match * probs[i]
        elsif n - 1 == i
          succ[i - 1] += match * probs[i]
        else
          succ[i + 1] += (match * probs[i]) / 2
          succ[i - 1] += (match * probs[i]) / 2
        end
      end

      probs = succ
    end

    probs.sum
  end

  def solution; 'MTk5NzQwMzUzLzI5Mzg2NTYxNTM2MDAw' end
  def best_time; 0.01254 end
  def effort; 75 end

  def completed_on; '2018-10-04' end
  def ordinality; 1_949 end
  def population; 786_414 end

  def refs; [] end
end


__END__

P(A and B) = P(A|B)P(B) = P(B|A)P(A), or P(A)P(B) if A,B independent
P(A or B) = P(A) + P(B) - P(A and B), or P(A) + P(B) if A,B mutually exclusive
P(A|B) = P(A and B) / P(B) = P(B|A)P(A) / P(B)
P(B|A) = P(A|B)P(B) / P(A)

P(on P) = 95/500
P(on N) = 405/500
P(move right) = P(on 2-499)P(1/2) + P(on 1) = (498/500)(1/2) + 1/500 = 498/1000 + 2/1000 = 500/1000 = 1/2
P(move left) = P(on 2-499)P(1/2) + P(on 500) = (498/500)(1/2) + 1/500 = 498/1000 + 2/1000 = 500/1000 = 1/2
P(on P|move right) = P(on P and move right) / P(move right) = P(on P)P(move right) / P(move right) = P(on P)

P(say P|on P) = 2/3 = P(say P and on P) / P(on P)
  P(say P and on P) = (2/3)(95/500) = 190/1500
P(say N|on P) = 1/3 = P(say N and on P) / P(on P)
  P(say N and on P) = (1/3)(95/500) = 95/1500
P(say P|on N) = 1/3 = P(say P and on N) / P(on N)
  P(say P and on N) = (1/3)(405/500) = 405/1500
P(say N|on N) = 2/3 = P(say N and on N) / P(on N)
  P(say N and on N) = (2/3)(405/500) = 810/1500

P((say P and on P) or (say P and on N)) = P(say P and on P) + P(say P and on N) = 190/1500 + 405/1500 = 595/1500
  P(say P) = 595/1500
P((say N and on P) or (say N and on N)) = P(say N and on P) + P(say N and on N) = 95/1500 + 810/1500 = 905/1500
  P(say N) = 905/1500

Reverse probabilities:
P(on P|say P) = P(say P|on P)P(on P) / P(say P)
  (2/3)(95/500) / (595/1500) = (190/1500)(1500/595) = 38/119
P(on N|say P) = P(say P|on N)P(on N) / P(say P)
  (1/3)(405/500) / (595/1500) = (405/1500)(1500/595) = 81/119
P(on P|say N) = P(say N|on P)P(on P) / P(say N)
  (1/3)(95/500) / (905/1500) = (95/1500)(1500/905) = 19/181
P(on N|say N) = P(say N|on N)P(on N) / P(say N)
  (2/3)(405/500) / (905/1500) = (810/1500)(1500/905) = 162/181

If said P, P(from P) = 38/119 and P(from N) = 81/119
If said N, P(from P) = 19/181 and P(from N) = 162/181

                on P   on N
                  \     /
            38/119 \   / 81/119
               |    \ /    |
               |    "P"    |
               |           |
               |          / \
               |  95/405 /   \ 310/405
               |    |   /     \   |
               |    | on P   on N |
               |    |             |
               |   / \           / \
              2/3 /   \ 1/3 1/3 /   \ 2/3
               | /     \       /     \
               "P"     "N"   "P"     "N"
               |
              / \
        1/95 /   \ 94/95
         |  /     \   |
         |on P   on N |
         |            |
        / \          / \
   2/3 /   \ 1/3 1/3/   \ 2/3
      /     \      /     \
    "P"     "N"  "P"     "N"

                on P   on N
                  \     /
            19/181 \   / 162/181
               |    \ /    |
               |    "N"    |
               |           |
               |          / \
               |  95/405 /   \ 310/405
               |    |   /     \   |
               |    | on P   on N |
               |    |             |
               |   / \           / \
              2/3 /   \ 1/3 1/3 /   \ 2/3
               | /     \       /     \
               "P"     "N"   "P"     "N"
               |
              / \
        1/95 /   \ 94/95
         |  /     \   |
         |on P   on N |
         |            |
        / \          / \
   2/3 /   \ 1/3 1/3/   \ 2/3
      /     \      /     \
    "P"     "N"  "P"     "N"

P(P|P) = (81/119)(95/405)(2/3) + (81/119)(310/405)(1/3) + (38/119)(1/95)(2/3) + (38/119)(94/95)(1/3)
       = 692/1785
P(N|P) = (81/119)(95/405)(1/3) + (81/119)(310/405)(2/3) + (38/119)(1/95)(1/3) + (38/119)(94/95)(2/3)
       = 1093/1785
P(P|N) = (162/181)(95/405)(2/3) + (162/181)(310/405)(1/3) + (19/181)(1/95)(2/3) + (19/181)(94/95)(1/3)
       = 1096/2715
P(N|N) = (162/181)(95/405)(1/3) + (162/181)(310/405)(2/3) + (19/181)(1/95)(1/3) + (19/181)(94/95)(2/3)
       = 1619/2715

If on P now, what is prob of being on P after move?
  P(2)(1/2) + P(3)(1/2) = (1/95)(1/2) + (1/95)(1/2) = 1/95
If on N now, what is prob of being on P after move?
  [P(1) + P(500)] + [P(4) + P(6) + P(12) + P(18) + ... + P(462)] + P(8 or 14 or 20 ... 492)(1/2) + P(10 or 16 or 22 ... 498)(1/2)
  2/405 + 24/405 + (69/405)(1/2) + (69/405)(1/2) = 26/405 + 69/405 = 95/405
If on P now, what is prob of being on N after move?
  P(5 or 7 or 11 ... 499) + P(2)(1/2) + P(3)(1/2) = 93/95 + (1/95)(1/2) + (1/95)(1/2) = 94/95
If on N now, what is prob of being on N after move?
  P(9 or 15 or 21 ... 497) + P(10 or 16 or 22 ... 498)(1/2) + P(8 or 14 or 20 ... 492)(1/2) = 241/405 + 69/405 = 310/405

P(now P|was P) = 1/95
P(now P|was N) = 95/405
P(now N|was P) = 94/95
P(now N|was N) = 310/405

P(on P) = P(2) + P(3) + P(5) + ... + P(499) = 1/500 + 1/500 + 1/500 + ... + 1/500 = 95/500
P(L|1) = 0, P(L|2) = 1/2, P(L|3) = 1/2, ... P(L|499) = 1/2, P(L|500) = 1
P(R|1) = 1, P(R|2) = 1/2, P(R|3) = 1/2, ... P(R|499) = 1/2, P(R|500) = 0

P(on P) = 95/500
 -- P(say P) = 2/3
    -- P(on P) = 95/500
       -- P(say P) = 2/3 -> P("PP") = (95/500)(2/3)(95/500)(2/3) = 36100/2250000
       -- P(say N) = 1/3 -> P("PN") = (95/500)(2/3)(95/500)(1/3) = 18050/2250000
    -- P(on N) = 405/500
       -- P(say P) = 1/3 -> P("PP") = (95/500)(2/3)(405/500)(1/3) = 76950/2250000
       -- P(say N) = 2/3 -> P("PN") = (95/500)(2/3)(405/500)(2/3) = 153900/2250000
 -- P(say N) = 1/3
    -- P(on P) = 95/500
       -- P(say P) = 2/3 -> P("NP") = (95/500)(1/3)(95/500)(2/3) = 18050/2250000
       -- P(say N) = 1/3 -> P("NN") = (95/500)(1/3)(95/500)(1/3) = 9025/2250000
    -- P(on N) = 405/500
       -- P(say P) = 1/3 -> P("NP") = (95/500)(1/3)(405/500)(1/3) = 38475/2250000
       -- P(say N) = 2/3 -> P("NN") = (95/500)(1/3)(405/500)(2/3) = 76950/2250000
P(on N) = 405/500
 -- P(say P) = 1/3
    -- P(on P) = 95/500
       -- P(say P) = 2/3 -> P("PP") = (405/500)(1/3)(95/500)(2/3) = 76950/2250000
       -- P(say N) = 1/3 -> P("PN") = (405/500)(1/3)(95/500)(1/3) = 38475/2250000
    -- P(on N) = 405/500
       -- P(say P) = 1/3 -> P("PP") = (405/500)(1/3)(405/500)(1/3) = 164025/2250000
       -- P(say N) = 2/3 -> P("PN") = (405/500)(1/3)(405/500)(2/3) = 328050/2250000
 -- P(say N) = 2/3
    -- P(on P) = 95/500
       -- P(say P) = 2/3 -> P("NP") = (405/500)(2/3)(95/500)(2/3) = 153900/2250000
       -- P(say N) = 1/3 -> P("NN") = (405/500)(2/3)(95/500)(1/3) = 76950/2250000
    -- P(on N) = 405/500
       -- P(say P) = 1/3 -> P("NP") = (405/500)(2/3)(405/500)(1/3) = 328050/2250000
       -- P(say N) = 2/3 -> P("NN") = (405/500)(2/3)(405/500)(2/3) = 656100/2250000

So,
  P("PP") = 36100/2250000 + 76950/2250000 + 76950/2250000 + 164025/2250000 = 354025/2250000 = 15.7344%
  P("PN") = 18050/2250000 + 153900/2250000 + 38475/2250000 + 328050/2250000 = 538475/2250000 = 23.9322%
  P("NP") = 18050/2250000 + 38475/2250000 + 153900/2250000 + 328050/2250000 = 538475/2250000 = 23.9322%
  P("NN") = 9025/2250000 + 76950/2250000 + 76950/2250000 + 656100/2250000 = 819025/2250000 = 36.4011%

s.chars.reduce( Rational( 1, 1 ) ) {|acc, c| acc = acc * ('P' == c ? Rational( 595, 1500 ) : Rational( 905, 1500 ))}
WRONG: 110627344643726229307799294051701/14348907000000000000000000000000000000 = 0.0000007709

Verified this result using the tree summation method:
       110627344643726229307799294051701/14348907000000000000000000000000000000
