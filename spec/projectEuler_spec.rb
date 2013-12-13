require 'spec_helper'
require_relative '../projectEuler'

describe String do
  it "provides some additional string utilities" do
  end

  describe "#palindromic?" do
    it "returns true if a string reads the same backwards and forwards" do
      "A".should be_palindromic

      "ABA".should be_palindromic
      "ABC".should_not be_palindromic

      "ABBA".should be_palindromic
      "ABCD".should_not be_palindromic
    end
  end
end

describe Integer do
  it "provides some additional integer operations" do
  end

  describe "#factors" do
    it "returns a sorted array of divisors" do
      0.factors.should eq( [0] )
      240.factors.should eq( [1, 2, 3, 4, 5, 6, 8, 10, 12, 15, 16, 20, 24, 30, 40, 48, 60, 80, 120, 240] )
      10784.factors.should eq( [1, 2, 4, 8, 16, 32, 337, 674, 1348, 2696, 5392, 10784] )
      10099.factors.should eq( [1, 10099] )
    end
  end

  describe "#prime_factors" do
    it "returns a sorted array of all prime divisors" do
      0.prime_factors.should eq( [] )
      1.prime_factors.should eq( [] )
      20894.prime_factors.should eq( [2, 31, 337] )
      135459162.prime_factors.should eq( [2, 3, 3, 3, 17, 41, 59, 61] )
    end
  end

  describe "#prime?" do
    it "returns true if a number is divisible only by itself and 1" do
      2.should be_prime
      97366669.should be_prime

      0.should_not be_prime
      1.should_not be_prime
      7777774.should_not be_prime
    end
  end

  describe "#coprime?" do
    it "returns true if a number is coprime with another" do
      5.should be_coprime( 2 )
      123.should be_coprime( 89 )
      552638.should be_coprime( 66523 )

      12.should_not be_coprime( 4 )
      100.should_not be_coprime( 250 )
    end
  end

  describe "#lychrel?" do
    it "returns true if reverse-and-add does lead to a palindrome in less that 50 iterations" do
      196.should be_lychrel
      4994.should be_lychrel

      47.should_not be_lychrel
      349.should_not be_lychrel
    end
  end

  describe "#fact" do
    it "computes the product of all integers up to n" do
      expect { -5.fact }.to raise_error( Math::DomainError )
      0.fact.should be( 1 )
      12.fact.should be( 479001600 )  # largest result that will fit in 32 bits

      # These results generate objects (Bignum), so we must use eq(). 
      21.fact.should eq( 51090942171709440000 )
      30.fact.should eq( 265252859812191058636308480000000 )
    end
  end

  describe "#sum_digits" do
    it "adds the decimal digits representing a number" do
      0.sum_digits.should be( 0 )
      987654.sum_digits.should be( 39 )

      # Check some other bases.
      66272.sum_digits( 8 ).should be( 10 )
      99182267.sum_digits( 4 ).should be( 26 )
    end
  end

  describe "#collatz" do
    it "returns an array of the Collatz sequence starting at n" do
      0.collatz.should be_nil
      1.collatz.should eq( [1] )
      144.collatz.should eq( [144, 72, 36, 18, 9, 28, 14, 7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1] )
      301.collatz.should eq( [301, 904, 452, 226, 113, 340, 170, 85, 256, 128, 64, 32, 16, 8, 4, 2, 1] )
    end
  end

  describe "#collatz_length" do
    it "returns the length of the Collatz sequence starting at n" do
      0.collatz_length.should be( 0 )
      1.collatz_length.should be( 1 )
      198.collatz_length.should be( 27 )
      772283.collatz_length.should be( 194 )
    end
  end

  describe "#amicable?" do
    it "returns true if n forms part of an amicable pair" do
      220.should be_amicable
      5564.should be_amicable
      88730.should be_amicable
      503056.should be_amicable

      0.should_not be_amicable
      1.should_not be_amicable
      6.should_not be_amicable
    end
  end

  describe "#perfect?" do
    it "returns true if a number's divisors sum to the number" do
      6.should be_perfect
      28.should be_perfect
      8128.should be_perfect
    end
  end

  describe "#abundant?" do
    it "returns true if a number's divisors sum to less than the number" do
      12.should be_abundant
      714.should be_abundant
      109944.should be_abundant
    end
  end

  describe "#deficient?" do
    it "returns true if a number's divisors sum to more than the number" do
      22.should be_deficient
      615.should be_deficient
      5512371.should be_deficient
    end
  end

  describe "#in_words" do
    it "expresses an integer number in English words" do
      0.in_words.should eq( 'zero' )
      12.in_words.should eq( 'twelve' )
      79.in_words.should eq( 'seventy-nine' )
      200.in_words.should eq( 'two hundred' )
      893.in_words.should eq( 'eight hundred and ninety-three' )
      1004.in_words.should eq( 'one thousand four' )
      8890.in_words.should eq( 'eight thousand eight hundred and ninety' )
      2300754.in_words.should eq( 'two million three hundred thousand seven hundred and fifty-four' )
    end
  end
end

describe PokerHand do
  it "represents a set of five playing cards" do
  end

  describe "#new" do
    hand = PokerHand.new( ["AS", "2H", "AD", "2C", "JC"] )
    it "takes an array of two-character card names and returns a PokerHand object" do
      hand.should be_an_instance_of( PokerHand )
    end
  end

  describe "#<=>" do
    it "compares the numerical ranks of two collections of cards" do
      PokerHand.new( ["6H", "5S", "4C", "3H", "2S"] ).should > PokerHand.new( ["KH", "6S", "3D", "2D", "7S"] ) 
    end
  end

  describe "#straight?" do
    it "returns true if all cards form a contiguous sequence" do
      PokerHand.new( ["4C", "2C", "3D", "6H", "5D"] ).should be_straight
      PokerHand.new( ["JH", "AD", "4H", "2S", "QS"] ).should_not be_straight
    end
  end

  describe "#flush?" do
    it "returns true if all cards have the same suit" do
      PokerHand.new( ["AC", "TC", "QC", "7C", "3C"] ).should be_flush
      PokerHand.new( ["JH", "AD", "4H", "2S", "QS"] ).should_not be_flush
    end
  end

  describe "#rank" do
    it "calculates a numeric score associated based on hand type and card values" do
      PokerHand.new( ["TH", "TD", "6C", "2S", "2S"] ).rank.should eq( 707438114 )
      PokerHand.new( ["KD", "9H", "5C", "7C", "5S"] ).rank.should eq( 274569045 )
      PokerHand.new( ["KS", "6S", "3S", "9S", "7S"] ).rank.should eq( 1343068003 )
    end
  end
end

describe ProjectEuler do
  it "provides general functions helpful when solving the problems" do
  end
  
  describe ".time" do
    it "measures execution time of a code block" do
      out = capture_stdout do
        ProjectEuler.time do
          # Dummy operation; time irrelevant.
          (0..100).each {|n| n.factors}
        end
      end

      # Output string has format similar to "0.4105238914s\n"
      out.string.should =~ /\d+\.\d{10}s\n/
    end
  end

  describe ".eratosthenes" do
    it "generates an array of primes" do
      array = ProjectEuler.eratosthenes( 100 )
      array.should eq( [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97] )

      ProjectEuler.eratosthenes(100000).count.should be( 9592 )
    end
  end

  describe ".modular_power" do
    it "performs exponentiation over a modulus" do
      ProjectEuler.modular_power( 1234, 567, 890 ).should be( 304 )
    end
  end

  describe ".tree_sum" do
    it "adds rows from the bottom up of a triangle of numbers" do
      expect { ProjectEuler.tree_sum( [1, 2, 3, 4, 5 ] ) }.to raise_error( ArgumentError )
      ProjectEuler.tree_sum( [3, 7, 4, 2, 4, 6, 8, 5, 9, 3] ).should be( 23 )
    end
  end

  describe ".sqrt_cf" do
    it "computes the continued fraction for the square root of an integer" do
      ProjectEuler.sqrt_cf( 76 ).should eq( [8, 1, 2, 1, 1, 5, 4, 5, 1, 1, 2, 1, 16] )
      ProjectEuler.sqrt_cf( 94 ).should eq( [9, 1, 2, 3, 1, 1, 5, 1, 8, 1, 5, 1, 1, 3, 2, 1, 18] )
      ProjectEuler.sqrt_cf( 31684 ).should eq( [178] )
      ProjectEuler.sqrt_cf( 9949 ).count.should be( 218 )
    end
  end

  describe ".convergent" do
    it "calculates the kth convergent of a continued fraction" do
      ProjectEuler.convergent( [1, 2], 5 ).should eq( Rational( 99, 70 ) )
      ProjectEuler.convergent( [2, 1, 2, 1, 1, 4, 1, 1, 6, 1], 9 ).should eq( Rational( 1457, 536 ) )
    end
  end
end
