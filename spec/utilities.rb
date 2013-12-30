require 'spec_helper'
require 'projectEuler'

describe Array do
  it "provides some additional array operations" do; end

  describe "#tree_sum" do
    it "adds rows from the bottom up of a triangle of numbers" do
      expect { [1, 2, 3, 4, 5 ].tree_sum }.to raise_error( ArgumentError )
      [3, 7, 4, 2, 4, 6, 8, 5, 9, 3].tree_sum.should == 23
    end
  end

  describe "#convergent" do
    it "calculates the kth convergent of a continued fraction" do
      [1, 2].convergent( 5 ).should == Rational( 99, 70 )
      [2, 1, 2, 1, 1, 4, 1, 1, 6, 1].convergent( 9 ).should == Rational( 1457, 536 )
    end
  end
end

describe Integer do
  it "provides some additional integer operations" do; end

  describe "#factors" do
    it "returns a sorted array of divisors" do
      0.factors.should == [0]
      240.factors.should == [1, 2, 3, 4, 5, 6, 8, 10, 12, 15, 16, 20, 24, 30, 40, 48, 60, 80, 120, 240]
      10784.factors.should == [1, 2, 4, 8, 16, 32, 337, 674, 1348, 2696, 5392, 10784]
      10099.factors.should == [1, 10099]
      51891840.factors.should have( 640 ).items
    end
  end

  describe "#prime_factors" do
    it "returns a sorted array of all prime divisors" do
      0.prime_factors.should be_empty
      1.prime_factors.should be_empty
      20894.prime_factors.should == [2, 31, 337]
      135459162.prime_factors.should == [2, 3, 3, 3, 17, 41, 59, 61]
      1235591280.prime_factors.should have( 13 ).items
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

  describe "#genpents" do
    it "generates an array of generalized pentagonal numbers" do
      0.genpents.should == [0]
      100.genpents.should == [0, 1, 2, 5, 7, 12, 15, 22, 26, 35, 40, 51, 57, 70, 77, 92, 100]
      6543.genpents[121, 5].should == [5551, 5612, 5735, 5797, 5922]
    end
  end

  describe "#partition_sieve" do
    it "generates an array of partition numbers" do
      0.partition_sieve.should == [1]
      1.partition_sieve.should == [1, 1]
      13.partition_sieve.should == [1, 1, 2, 3, 5, 7, 11, 15, 22, 30, 42, 56, 77, 101]
      439.partition_sieve[329, 3].should == [68834885946073850, 73653287861850339, 78801255302666615]
    end
  end

  describe "#prime_sieve" do
    it "generates an array of primes" do
      100.prime_sieve.should == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
      100000.prime_sieve.should have( 9592 ).items
    end
  end

  describe "#primefactorsum_sieve" do
    it "generates an array of prime factor sums" do
      10.primefactorsum_sieve.should == [0, 0, 2, 3, 2, 5, 5, 7, 2, 3]
      8364.primefactorsum_sieve[-5, 5].should == [656, 37, 932, 152, 8363] 
    end
  end

  describe "#primepartition_sieve" do
    it "generates an array of prime partition numbers" do
      15.primepartition_sieve.should == [0, 0, 1, 1, 1, 2, 2, 3, 3, 4, 5, 6, 7, 9, 10]
      553.primepartition_sieve[-3, 3].should == [1665790419712, 1711588947172, 1758600154825]
      750.primepartition_sieve.count {|i| i.prime?}.should == 53 
    end
  end

  describe "#pytriple_sieve" do
    it "generates an array of Pythagorean triple counts" do
      1000.pytriple_sieve[415, 10].should == [0, 1, 0, 1, 0, 5, 0, 0, 0, 0]
      5613.pytriple_sieve.inject( :+ ).should == 2502
      17777.pytriple_sieve.max.should == 20
    end
  end

  describe "#totient_sieve" do
    it "generates an array of totient values" do
      1.totient_sieve.should == [0, 1]
      10.totient_sieve.should == [0, 1, 1, 2, 2, 4, 2, 6, 4, 6, 4]
      629.totient_sieve[123, 10].should == [80, 60, 100, 36, 126, 64, 84, 48, 130, 40]
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
      0.fact.should == 1
      12.fact.should == 479001600  # largest result that will fit in 32 bits

      # These results generate objects (Bignum). 
      21.fact.should == 51090942171709440000
      30.fact.should == 265252859812191058636308480000000
    end
  end

  describe "#sum_digits" do
    it "adds the decimal digits representing a number" do
      0.sum_digits.should == 0
      987654.sum_digits.should == 39

      # Check some other bases.
      66272.sum_digits( 8 ).should == 10
      99182267.sum_digits( 4 ).should == 26
    end
  end

  describe "#collatz_length" do
    it "returns the length of the Collatz sequence starting at n" do
      0.collatz_length.should == 0
      1.collatz_length.should == 1
      198.collatz_length.should == 27
      772283.collatz_length.should == 194
    end
  end

  describe "#farey_length" do
    it "returns the length of the Farey sequence of order n" do
      0.farey_length.should == 1
      36.farey_length.should == 397
      53673.farey_length.should == 875674873
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

      12.should_not be_perfect
      22.should_not be_perfect
    end
  end

  describe "#abundant?" do
    it "returns true if a number's divisors sum to less than the number" do
      12.should be_abundant
      714.should be_abundant
      109944.should be_abundant

      6.should_not be_abundant
      22.should_not be_abundant
    end
  end

  describe "#deficient?" do
    it "returns true if a number's divisors sum to more than the number" do
      22.should be_deficient
      615.should be_deficient
      5512371.should be_deficient

      6.should_not be_deficient
      12.should_not be_deficient
    end
  end

  describe "#sqrt_cf" do
    it "computes the continued fraction for the square root of an integer" do
      76.sqrt_cf.should == [8, 1, 2, 1, 1, 5, 4, 5, 1, 1, 2, 1, 16]
      94.sqrt_cf.should == [9, 1, 2, 3, 1, 1, 5, 1, 8, 1, 5, 1, 1, 3, 2, 1, 18]
      31684.sqrt_cf.should == [178]
      9949.sqrt_cf.should have( 218 ).items
    end
  end

  describe "#totient" do
    it "counts the coprimes less than a number" do
      expect { 0.totient }.to raise_error( ArgumentError )
      1.totient.should == 1
      10.totient.should == 4
      763.totient.should == 648

      # Some identities.
      m, n = 282, 43779
      (m*n).totient.should == ((m.totient * n.totient * m.gcd( n )) / m.gcd( n ).totient)

      m, n = 5, 17
      (n**m).totient.should == n.totient * n**(m - 1)
    end
  end

  describe "#in_words" do
    it "expresses an integer number in English words" do
      0.in_words.should == 'zero'
      12.in_words.should == 'twelve'
      79.in_words.should == 'seventy-nine'
      200.in_words.should == 'two hundred'
      893.in_words.should == 'eight hundred and ninety-three'
      1004.in_words.should == 'one thousand four'
      8890.in_words.should == 'eight thousand eight hundred and ninety'
      2300754.in_words.should == 'two million three hundred thousand seven hundred and fifty-four'
    end
  end
end

describe Numeric do
  it "provides some additional numeric operations" do; end

  describe "#modular_power" do
    it "performs exponentiation over a modulus" do
      1234.modular_power( 567, 890 ).should == 304
    end
  end
end

describe String do
  it "provides some additional string operations" do; end

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

module ProjectEuler
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
  end

  describe Graph do
    it "represents a set of vertices and the directed edges between them" do; end

    before( :all ) do
      @graph = Graph.new
      @graph.connect( 1, 2, 7 ).connect( 1, 3, 9 ).connect( 1, 6, 14 )
      @graph.connect( 2, 3, 10 ).connect( 2, 4, 15 )
      @graph.connect( 3, 4, 11 ).connect( 3, 6, 2 )
      @graph.connect( 4, 5, 6 )
      @graph.connect( 6, 5, 9 )
    end

    describe "#new" do
      it "creates a Graph object" do
        @graph.should be_an_instance_of( Graph )
      end
    end

    describe "#connect" do
      it "creates a one-way-weighted directed edge between two nodes" do
        @graph.connect( 1, 7, 8 )
        @graph.len( 1, 7 ).should == 8
        @graph.len( 7, 1 ).should == Float::INFINITY

        @graph.connect( 1, 8, 9, 10 )
        @graph.len( 1, 8 ).should == 9
        @graph.len( 8, 1 ).should == 10
      end
    end

    describe "#biconnect" do
      it "creates a two-way-weighted directed edge between two nodes" do
        @graph.biconnect( 1, 9, 11 )
        @graph.len( 1, 9 ).should == 11
        @graph.len( 9, 1 ).should == 11
      end
    end

    describe "#neighbors" do
      it "returns the nodes reachable from another" do
        @graph.neighbors( 2 ).should == [3, 4]
        @graph.neighbors( 5 ).should be_empty
      end
    end

    describe "#len" do
      it "returns the weight for the edge between two nodes" do
        @graph.len( 1, 2 ).should == 7
        @graph.len( 3, 4 ).should == 11
        @graph.len( 2, 6 ).should == Float::INFINITY
      end
    end

    describe "#dijkstra" do
      it "it returns the least-cost path total between nodes" do
        @graph.dijkstra( 1, 5 ).should == 20
        @graph.dijkstra( 2, 6 ).should == 12
        @graph.dijkstra( 2, 7 ).should == Float::INFINITY
        @graph.dijkstra( 3 ).should == {3=>0, 4=>11, 6=>2, 5=>11}
      end
    end
  end

  describe PokerHand do
    it "represents a set of five playing cards" do; end
  
    describe "#new" do
      it "takes an array of two-character card names and returns a PokerHand object" do
        hand = PokerHand.new( ["AS", "2H", "AD", "2C", "JC"] )
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
        PokerHand.new( ["TH", "TD", "6C", "2S", "2S"] ).rank.should == 707438114
        PokerHand.new( ["KD", "9H", "5C", "7C", "5S"] ).rank.should == 274569045
        PokerHand.new( ["KS", "6S", "3S", "9S", "7S"] ).rank.should == 1343068003
      end
    end
  end
end
