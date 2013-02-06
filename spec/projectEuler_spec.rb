require 'spec_helper'
require_relative '../projectEuler'

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

  describe "#fact" do
    it "computes the product of all integers up to n" do
      0.fact.should be( 0 )
      -5.fact.should be( 0 )
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

  describe "#in_words" do
    it "expresses a number less than 1000 in English words" do
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
    end
  end

  describe ".modular_power" do
    it "performs exponentiation over a modulus" do
      ProjectEuler.modular_power( 1234, 567, 890 ).should be( 304 )
    end
  end

  describe ".tree_sum" do
    it "adds rows from the bottom up of a triangle of numbers" do
      ProjectEuler.tree_sum( [3, 7, 4, 2, 4, 6, 8, 5, 9, 3], 4 ).should be( 23 )
    end
  end
end
