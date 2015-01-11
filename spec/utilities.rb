require 'spec_helper'
require 'projectEuler'

describe Array do
  it "provides some additional array operations" do; end

  describe "#convergent" do
    it "calculates the kth convergent of a continued fraction" do
      expect( [1, 2].convergent( 5 ) ).to eq( Rational( 99, 70 ) )
      expect( [2, 1, 2, 1, 1, 4, 1, 1, 6, 1].convergent( 9 ) ).to eq( Rational( 1457, 536 ) )
    end
  end

  describe "#lagrange_interp_func" do
    it "creates a Lagrange Polynomial interpolation function" do
      f = [[1, 1], [2, 8], [5, 125], [9, 729]].lagrange_interp_func
      expect( f.call( 4 ) ).to eq( 64 )

      g = [[1, 0.1411], [1.3, -0.6878], [1.6, -0.9962], [1.9, -0.5507], [2.2, 0.3115]].lagrange_interp_func
      expect( '%.4f' % g.call( 1.5 ) ).to eq( '-0.9774' )
    end
  end

  describe "#poly_gen_func" do
    it "creates a polynomial generating function from coefficients" do
      # f(x) = x^3
      f = [0, 0, 0, 1].poly_gen_func
      expect( f ).to be_an_instance_of( Proc )
      expect( f.call( 3 ) ).to eq( 27 )
      expect( f.call( 34.1 ) ).to eq( 39651.821 )
      expect( f.call( -0.75 ) ).to eq( -0.421875 )

      # g(x) = x^9 + 2x^7 - 0.8x^6 + 0.5x^5 + x^2 + 2x - 3
      g = [-3, 2, 1, 0, 0, 0.5, -0.8, 2, 0, 1].poly_gen_func()
      expect( g.call( 0 ) ).to eq( -3.0 )
      expect( g.call( 13 ) ).to eq( 10726320798.3 )
      expect( g.call( -0.125 ) ).to eq( -3.234394271671772 )
    end
  end

  describe "#tree_sum" do
    it "adds rows from the bottom up of a triangle of numbers" do
      expect { [1, 2, 3, 4, 5 ].tree_sum }.to raise_error( ArgumentError )
      expect( [3, 7, 4, 2, 4, 6, 8, 5, 9, 3].tree_sum ).to eq( 23 )
    end
  end
end

describe Integer do
  it "provides some additional integer operations" do; end

  describe "#choose" do
    it "computes a binomial coefficient" do
      expect( 0.choose( 4 ) ).to eq( 0 )
      expect( 345.choose( 400 ) ).to eq( 0) 
      expect( 12.choose( 0 ) ).to eq( 1 )
      expect( 45.choose( 17 ) ).to eq( 1103068603890 )
    end
  end

  describe "#factors" do
    it "returns a sorted array of divisors" do
      expect( 0.factors ).to eq( [0] )
      expect( 240.factors ).to eq( [1, 2, 3, 4, 5, 6, 8, 10, 12, 15, 16, 20, 24, 30, 40, 48, 60, 80, 120, 240] )
      expect( 10784.factors ).to eq( [1, 2, 4, 8, 16, 32, 337, 674, 1348, 2696, 5392, 10784] )
      expect( 10099.factors ).to eq( [1, 10099] )
      expect( 51891840.factors.size ).to eq( 640 )
    end
  end

  describe "#fib" do
    it "returns the kth term in the Fibonacci series" do
      expect( 0.fib ).to eq( 0 )
      expect( 1.fib ).to eq( 1 )
      expect( 2.fib ).to eq( 1 )
      expect( 34.fib ).to eq( 5702887 )

      # Should work for negative numbers, too.
      expect( -7.fib ).to eq( 13 )
      expect( -28.fib ).to eq( -317811 )
    end
  end

  describe "#palindrome?" do
    it "returns true if a base-10 integer reads the same backwards and forwards" do
      expect( 0 ).to be_palindrome
      expect( 99 ).to be_palindrome
      expect( 32455955423 ).to be_palindrome

      expect( 154 ).to_not be_palindrome
      expect( -1001 ).to_not be_palindrome
    end
  end

  describe "#pandigital?" do
    it "returns true if a base-10 integer's digits include exactly one of 1-9" do
      expect( 123456789 ).to be_pandigital
      expect( 741258963 ).to be_pandigital
      expect( 326159487 ).to be_pandigital

      expect( 123456780 ).to_not be_pandigital
      expect( 326159486 ).to_not be_pandigital
    end
  end

  describe "#prime_factors" do
    it "returns a sorted array of all prime divisors" do
      expect( 0.prime_factors ).to be_empty
      expect( 1.prime_factors ).to be_empty
      expect( 20894.prime_factors ).to eq( [2, 31, 337] )
      expect( 135459162.prime_factors ).to eq( [2, 3, 3, 3, 17, 41, 59, 61] )
      expect( 1235591280.prime_factors.size ).to eq( 13 )
    end
  end

  describe "#prime?" do
    it "returns true if a number is divisible only by itself and 1" do
      expect( 2 ).to be_prime
      expect( 97366669 ).to be_prime

      expect( 0 ).to_not be_prime
      expect( 1 ).to_not be_prime
      expect( 7777774 ).to_not be_prime
    end
  end

  describe "#coprime?" do
    it "returns true if a number is coprime with another" do
      expect( 5 ).to be_coprime( 2 )
      expect( 123 ).to be_coprime( 89 )
      expect( 552638 ).to be_coprime( 66523 )

      expect( 12 ).to_not be_coprime( 4 )
      expect( 100 ).to_not be_coprime( 250 )
    end
  end

  describe "#factorsum_sieve" do
    it "generates an array of factor sums" do
      expect( 10.factorsum_sieve ).to eq( [0, 0, 1, 1, 3, 1, 6, 1, 7, 4] )
      expect( 8364.factorsum_sieve[-5, 5] ).to eq( [657, 13240, 3729, 4634, 1] ) 
    end
  end

  describe "#genpents" do
    it "generates an array of generalized pentagonal numbers" do
      expect( 0.genpents ).to eq( [0] )
      expect( 100.genpents ).to eq( [0, 1, 2, 5, 7, 12, 15, 22, 26, 35, 40, 51, 57, 70, 77, 92, 100] )
      expect( 6543.genpents[121, 5] ).to eq( [5551, 5612, 5735, 5797, 5922] )
    end
  end

  describe "#partition_sieve" do
    it "generates an array of partition numbers" do
      expect( 0.partition_sieve ).to eq( [1] )
      expect( 1.partition_sieve ).to eq( [1, 1] )
      expect( 13.partition_sieve ).to eq( [1, 1, 2, 3, 5, 7, 11, 15, 22, 30, 42, 56, 77, 101] )
      expect( 439.partition_sieve[329, 3] ).to eq( [68834885946073850, 73653287861850339, 78801255302666615] )
    end
  end

  describe "#prime_sieve" do
    it "generates an array of primes" do
      expect( 100.prime_sieve ).to eq( [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97] )
      expect( 100000.prime_sieve.size ).to eq( 9592 )
    end
  end

  describe "#primefactorsum_sieve" do
    it "generates an array of prime factor sums" do
      expect( 10.primefactorsum_sieve ).to eq( [0, 0, 2, 3, 2, 5, 5, 7, 2, 3] )
      expect( 8364.primefactorsum_sieve[-5, 5] ).to eq( [656, 37, 932, 152, 8363] ) 
    end
  end

  describe "#primepartition_sieve" do
    it "generates an array of prime partition numbers" do
      expect( 15.primepartition_sieve ).to eq( [0, 0, 1, 1, 1, 2, 2, 3, 3, 4, 5, 6, 7, 9, 10] )
      expect( 553.primepartition_sieve[-3, 3] ).to eq( [1665790419712, 1711588947172, 1758600154825] )
      expect( 750.primepartition_sieve.count {|i| i.prime?} ).to eq( 53 ) 
    end
  end

  describe "#pytriple_sieve" do
    it "generates an array of Pythagorean triple counts" do
      expect( 1000.pytriple_sieve[415, 10] ).to eq( [0, 1, 0, 1, 0, 5, 0, 0, 0, 0] )
      expect( 5613.pytriple_sieve.inject( :+ ) ).to eq( 2502 )
      expect( 17777.pytriple_sieve.max ).to eq( 20 )
    end
  end

  describe "#totient_sieve" do
    it "generates an array of totient values" do
      expect( 1.totient_sieve ).to eq( [0, 1] )
      expect( 10.totient_sieve ).to eq( [0, 1, 1, 2, 2, 4, 2, 6, 4, 6, 4] )
      expect( 629.totient_sieve[123, 10] ).to eq( [80, 60, 100, 36, 126, 64, 84, 48, 130, 40] )
    end
  end

  describe "#lychrel?" do
    it "returns true if reverse-and-add does lead to a palindrome in less that 50 iterations" do
      expect( 196 ).to be_lychrel
      expect( 4994 ).to be_lychrel

      expect( 47 ).to_not be_lychrel
      expect( 349 ).to_not be_lychrel
    end
  end

  describe "#fact" do
    it "computes the product of all integers up to n" do
      expect { -5.fact }.to raise_error( Math::DomainError )
      expect( 0.fact ).to eq( 1 )
      expect( 12.fact ).to eq( 479001600 )  # largest result that will fit in 32 bits

      # These results generate objects (Bignum). 
      expect( 21.fact ).to eq( 51090942171709440000 )
      expect( 30.fact ).to eq( 265252859812191058636308480000000 )
    end
  end

  describe "#sum_digits" do
    it "adds the decimal digits representing a number" do
      expect( 0.sum_digits ).to eq( 0 )
      expect( 987654.sum_digits ).to eq( 39 )

      # Check some other bases.
      expect( 66272.sum_digits( 8 ) ).to eq( 10 )
      expect( 99182267.sum_digits( 4 ) ).to eq( 26 )
    end
  end

  describe "#collatz_length" do
    it "returns the length of the Collatz sequence starting at n" do
      expect( 0.collatz_length ).to eq( 0 )
      expect( 1.collatz_length ).to eq( 1 )
      expect( 198.collatz_length ).to eq( 27 )
      expect( 772283.collatz_length ).to eq( 194 )
    end
  end

  describe "#farey_length" do
    it "returns the length of the Farey sequence of order n" do
      expect( 0.farey_length ).to eq( 1 )
      expect( 36.farey_length ).to eq( 397 )
      expect( 53673.farey_length ).to eq( 875674873 )
    end
  end

  describe "#amicable?" do
    it "returns true if n forms part of an amicable pair" do
      expect( 220 ).to be_amicable
      expect( 5564 ).to be_amicable
      expect( 88730 ).to be_amicable
      expect( 503056 ).to be_amicable

      expect( 0 ).to_not be_amicable
      expect( 1 ).to_not be_amicable
      expect( 6 ).to_not be_amicable
    end
  end

  describe "#perfect?" do
    it "returns true if a number's divisors sum to the number" do
      expect( 6 ).to be_perfect
      expect( 28 ).to be_perfect
      expect( 8128 ).to be_perfect

      expect( 12 ).to_not be_perfect
      expect( 22 ).to_not be_perfect
    end
  end

  describe "#abundant?" do
    it "returns true if a number's divisors sum to less than the number" do
      expect( 12 ).to be_abundant
      expect( 714 ).to be_abundant
      expect( 109944 ).to be_abundant

      expect( 6 ).to_not be_abundant
      expect( 22 ).to_not be_abundant
    end
  end

  describe "#deficient?" do
    it "returns true if a number's divisors sum to more than the number" do
      expect( 22 ).to be_deficient
      expect( 615 ).to be_deficient
      expect( 5512371 ).to be_deficient

      expect( 6 ).to_not be_deficient
      expect( 12 ).to_not be_deficient
    end
  end

  describe "#sqrt_cf" do
    it "computes the continued fraction for the square root of an integer" do
      expect( 76.sqrt_cf ).to eq( [8, 1, 2, 1, 1, 5, 4, 5, 1, 1, 2, 1, 16] )
      expect( 94.sqrt_cf ).to eq( [9, 1, 2, 3, 1, 1, 5, 1, 8, 1, 5, 1, 1, 3, 2, 1, 18] )
      expect( 31684.sqrt_cf ).to eq( [178] )
      expect( 9949.sqrt_cf.size ).to eq( 218 )
    end
  end

  describe "#totient" do
    it "counts the coprimes less than a number" do
      expect { 0.totient }.to raise_error( ArgumentError )
      expect( 1.totient ).to eq( 1 )
      expect( 10.totient ).to eq( 4 )
      expect( 763.totient ).to eq( 648 )

      # Some identities.
      m, n = 282, 43779
      expect( (m*n).totient ).to eq( (m.totient * n.totient * m.gcd( n )) / m.gcd( n ).totient )

      m, n = 5, 17
      expect( (n**m).totient ).to eq(  n.totient * n**(m - 1) )
    end
  end

  describe "#in_words" do
    it "expresses an integer number in English words" do
      expect( 0.in_words ).to eq( 'zero' )
      expect( 12.in_words ).to eq( 'twelve' )
      expect( 79.in_words ).to eq( 'seventy-nine' )
      expect( 200.in_words ).to eq( 'two hundred' )
      expect( 893.in_words ).to eq( 'eight hundred and ninety-three' )
      expect( 1004.in_words ).to eq( 'one thousand four' )
      expect( 8890.in_words ).to eq( 'eight thousand eight hundred and ninety' )
      expect( 2300754.in_words ).to eq( 'two million three hundred thousand seven hundred and fifty-four' )
    end
  end
end

describe Numeric do
  it "provides some additional numeric operations" do; end

  describe "#modular_power" do
    it "performs exponentiation over a modulus" do
      expect( 1234.modular_power( 567, 890 ) ).to eq( 304 )
    end
  end
end

describe String do
  it "provides some additional string operations" do; end

  describe "#make_mask" do
    it "returns a mask based on the positions of unique characters" do
      expect( "ARISE".make_mask ).to eq( "01234" )
      expect( "Incontrovertible".make_mask ).to eq( "01231453675489:7" )
    end
  end

  describe "#palindromic?" do
    it "returns true if a string reads the same backwards and forwards" do
      expect( "A" ).to be_palindromic

      expect( "ABA" ).to be_palindromic
      expect( "ABC" ).to_not be_palindromic

      expect( "ABBA" ).to be_palindromic
      expect( "ABCD" ).to_not be_palindromic
    end
  end
end

module ProjectEuler
  describe ProjectEuler do
    it "provides general functions helpful when solving the problems" do; end
    
    describe ".time" do
      it "measures execution time of a code block" do
        expect {
          ProjectEuler.time do
            # Dummy operation; time irrelevant.
            (0..100).each {|n| n.factors}

            # Output string has format similar to "0.4105238914s\n"
          end
        }.to output( a_string_matching( /\d+\.\d{10}s\n/ ) ).to_stdout
      end
    end
  end

  describe Graph do
    it "represents a set of vertices and the directed edges between them" do; end

    before( :all ) do
      @matrix = m = [[ 0, 16, 12, 21,  0,  0,  0],
                     [16,  0,  0, 17, 20,  0,  0],
                     [12,  0,  0, 28,  0, 31,  0],
                     [21,  0, 28,  0, 18,  0, 23],
                     [ 0, 20,  0, 18,  0,  0, 11],
                     [ 0,  0, 31,  0,  0,  0, 27],
                     [ 0,  0,  0, 23, 11, 27,  0]]

      @graph = Graph.new( @matrix )
      @graph.connect( 1, 3, 17 ).biconnect( 5, 3, 19 )
    end

    describe "#new" do
      it "creates a Graph object" do
        expect( @graph ).to be_an_instance_of( Graph )
      end
    end

    describe "#add" do
      it "ensures a node is present in the graph, even if it has no out-bound paths" do
        @graph.add( 10 )
        expect( @graph ).to have_key( 10 )
      end
    end

    describe "#connect" do
      it "creates a one-way-weighted directed edge between two nodes" do
        @graph.connect( 1, 7, 8 )
        expect( @graph.len( 1, 7 ) ).to eq( 8 )
        expect( @graph.len( 7, 1 ) ).to eq( Float::INFINITY )

        @graph.connect( 1, 8, 9, 10 )
        expect( @graph.len( 1, 8 ) ).to eq( 9 )
        expect( @graph.len( 8, 1 ) ).to eq( 10 )
      end
    end

    describe "#biconnect" do
      it "creates a two-way-weighted directed edge between two nodes" do
        @graph.biconnect( 1, 9, 11 )
        expect( @graph.len( 1, 9 ) ).to eq( 11 )
        expect( @graph.len( 9, 1 ) ).to eq( 11 )
      end
    end

    describe "#neighbors" do
      it "returns the nodes reachable from another" do
        @graph.add( 10 )
        expect( @graph.neighbors( 2 ) ).to eq( [0, 3, 5] )
        expect( @graph.neighbors( 10 ) ).to be_empty
      end
    end

    describe "#len" do
      it "returns the weight for the edge between two nodes" do
        expect( @graph.len( 1, 4 ) ).to eq( 20 )
        expect( @graph.len( 3, 6 ) ).to eq( 23 )
        expect( @graph.len( 2, 6 ) ).to eq( Float::INFINITY )
      end
    end

    describe "#dijkstra" do
      it "it returns the least-cost path total between nodes" do
        expect( @graph.dijkstra( 1, 5 ) ).to eq( 36 )
        expect( @graph.dijkstra( 2, 6 ) ).to eq( 51 )
        expect( @graph.dijkstra( 2, 10 ) ).to eq( Float::INFINITY )
        expect( @graph.dijkstra( 3 ) ).to eq( {3=>0, 0=>21, 1=>17, 2=>28, 4=>18, 6=>23, 5=>19, 7=>25, 8=>26, 9=>28} )
      end
    end
  end

  describe PokerHand do
    it "represents a set of five playing cards" do; end
  
    describe "#new" do
      it "takes an array of two-character card names and returns a PokerHand object" do
        hand = PokerHand.new( ["AS", "2H", "AD", "2C", "JC"] )
        expect( hand ).to be_an_instance_of( PokerHand )
      end
    end
  
    describe "#<=>" do
      it "compares the numerical ranks of two collections of cards" do
        expect( PokerHand.new( ["6H", "5S", "4C", "3H", "2S"] ) ).to be > PokerHand.new( ["KH", "6S", "3D", "2D", "7S"] ) 
      end
    end
  
    describe "#straight?" do
      it "returns true if all cards form a contiguous sequence" do
        expect( PokerHand.new( ["4C", "2C", "3D", "6H", "5D"] ) ).to be_straight
        expect( PokerHand.new( ["JH", "AD", "4H", "2S", "QS"] ) ).to_not be_straight
      end
    end
  
    describe "#flush?" do
      it "returns true if all cards have the same suit" do
        expect( PokerHand.new( ["AC", "TC", "QC", "7C", "3C"] ) ).to be_flush
        expect( PokerHand.new( ["JH", "AD", "4H", "2S", "QS"] ) ).to_not be_flush
      end
    end
  
    describe "#rank" do
      it "calculates a numeric score associated based on hand type and card values" do
        expect( PokerHand.new( ["TH", "TD", "6C", "2S", "2S"] ).rank ).to eq( 707438114 )
        expect( PokerHand.new( ["KD", "9H", "5C", "7C", "5S"] ).rank ).to eq( 274569045 )
        expect( PokerHand.new( ["KS", "6S", "3S", "9S", "7S"] ).rank ).to eq( 1343068003 )
      end
    end
  end

  describe Roman do
    it "represents an integer value as a Roman numeral" do; end

    describe ".to_i" do
      it "computes the integer value of a Roman numeral string" do
        expect( Roman.to_i( 'MCCCCCCCCCXCIX' ) ).to eq( 1999 )
        expect( Roman.to_i( 'MMMMDCCCLXXIIII' ) ).to eq( 4874 )
        expect( Roman.to_i( 'MCDLXXXXIV' ) ).to eq( 1494 )
      end
    end

    describe ".from_i" do
      it "converts an integer value to a Roman numeral" do
        expect { Roman.from_i( 5000 ) }.to raise_error( ArgumentError )
        expect( Roman.from_i( 1999 ) ).to eq( 'MCMXCIX' )
        expect( Roman.from_i( 4874 ) ).to eq( 'MMMMDCCCLXXIV' )
        expect( Roman.from_i( 1494 ) ).to eq( 'MCDXCIV' )
      end
    end
  end

  describe SuDoku do
    it "solves Su Doku puzzles" do; end

    before( :all ) do
      @puzzle = [[0, 0, 5, 0, 0, 0, 0, 0, 6],
                 [0, 7, 0, 0, 0, 9, 0, 2, 0],
                 [0, 0, 0, 5, 0, 0, 1, 0, 7],
                 [8, 0, 4, 1, 5, 0, 0, 0, 0],
                 [0, 0, 0, 8, 0, 3, 0, 0, 0],
                 [0, 0, 0, 0, 9, 2, 8, 0, 5],
                 [9, 0, 7, 0, 0, 6, 0, 0, 0],
                 [0, 3, 0, 4, 0, 0, 0, 1, 0],
                 [2, 0, 0, 0, 0, 0, 6, 0, 0]]
    end

    describe ".constraints" do
      it "find missing values for each each row, column, and subsquare" do
        r, c, s = SuDoku.constraints( @puzzle )
        
        expect( r.flatten.inject( :+ ) ).to eq( 272 )
        expect( c.flatten.count ).to eq( 55 )
        expect( s[2] ).to eq( [3, 4, 5, 8, 9] )
        expect( (r[3] & c[6] & s[7]) ).to eq( [2, 3, 7, 9] )
      end
    end

    describe ".solve" do
      it "fills in blank squares, or returns nil if impossible" do
        solved = SuDoku.solve( @puzzle )
        expect( solved ).to_not be_nil
        expect( solved[6] ).to eq( [9, 8, 7, 2, 1, 6, 4, 5, 3] )
        expect( solved.map {|row| row[3]} ).to eq( [7, 3, 5, 1, 8, 6, 2, 4, 9] )

        @puzzle[2][5] = 1
        expect( SuDoku.solve( @puzzle ) ).to be_nil
      end
    end
  end
end
